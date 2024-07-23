import 'dart:async';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:quick_log_money/Database/DatabaseHelper.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';
import 'package:quick_log_money/pages/LedgerCards/CardWidget.dart';

part 'UserDB.g.dart';

late final UserDBHelper UserDB;
late UserDao User;

class UserDao {
  final UserInfo Info;
  final Iterable<int> RecentTags;
  int get Id => Info.Id;
  UserDao({required this.Info, required this.RecentTags});
}

///
@TableIndex(name: "UserInfos.Token", columns: {#Token})
class UserInfos extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get LedgerId => integer()();
  IntColumn get LedgerRecentCount => integer().withDefault(const Constant(8)).nullable()();
  TextColumn get Name => text()();
  TextColumn get Icon => text()();
  TextColumn get Token => text()();
  DateTimeColumn get VipExpiryDate => dateTime().nullable()();
  DateTimeColumn get RegisterDate => dateTime().withDefault(currentDate)();
}

///
@TableIndex(name: "UserLedgerRecentTags.Uid", columns: {#Uid})
class UserLedgerRecentTags extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get Uid => integer()();
  IntColumn get TagId => integer()();
}

///
@TableIndex(name: "UserCards.Place", columns: {#Place})
@TableIndex(name: "UserCards.Uid", columns: {#Uid})
class UserCards extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get Uid => integer()();
  TextColumn get Place => textEnum<ELedgerCardSpace>()();
  TextColumn get Name => text()();
  TextColumn get Params => text().nullable()();
}

///
@DriftDatabase(tables: [UserInfos, UserLedgerRecentTags, UserCards])
class UserDBHelper extends _$UserDBHelper {
  UserDBHelper(String name) : super(DatabaseHelper.OpenConnection(name));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) => m.createAll(),
      onUpgrade: (m, from, to) async {
        await customStatement('PRAGMA foreign_keys = OFF');
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  ///
  static Future Init() async {
    UserDB = UserDBHelper("users");
    await DatabaseHelper.DebugTryResetDatabase(UserDB);
    if (Prefs.IsLogined) {
      await LoginForToken(Prefs.UserToken);
    }
  }

  static Future Loginout() async {
    Prefs.UserToken = "";
    await LedgerDBHelper.Uninit();
  }

  ///
  static Future LoginForUser(String username, String password) async {
    // _OnLoginFinish();
    return null;
  }

  ///
  static Future LoginForToken(String token) {
    return _LoginImpl(UserDB.managers.userInfos.filter((f) => f.Token(token)));
  }

  ///
  static Future LoginForAnonym() async {
    // 判断是否已经存在匿名账户
    final existUser = await (UserDB.selectOnly(UserDB.userInfos)
          ..addColumns([UserDB.userInfos.Token])
          ..where(UserDB.userInfos.Id.equals(1) & UserDB.userInfos.Token.equals(".")))
        .getSingleOrNull();
    if (existUser != null) {
      return LoginForToken(existUser.read(UserDB.userInfos.Token)!);
    }

    // 创造账本数据
    final ledgerJson = jsonDecode(await rootBundle.loadString(Def.LedgerConfigPath, cache: false))["Template"] as Map<String, dynamic>;
    final ledgerInfo = LedgerInfosCompanion.insert(Name: ledgerJson["Name"], Icon: ledgerJson["Icon"]);
    final tags = (ledgerJson["Tags"] as Map<String, dynamic>)
        .entries
        .expand((e) => (e.value as List).map((tag) => LedgerTagsCompanion.insert(Group: e.key, Name: tag[0], Icon: tag[1])));

    User = await UserDB.transaction<UserDao>(() async {
      final user = await UserDB.managers.userInfos.createReturning((o) => o(Name: "游客", Icon: "", LedgerId: 0, Token: "."));

      final ledgerDB = LedgerDBHelper.FromUser(user.Id);
      final ledgerId = await LedgerDBHelper.CreateLedger(user.Id, ledgerDB, ledgerInfo, tags);
      await UserDB.managers.userInfos.filter((f) => f.Id(user.Id)).update((o) => o(LedgerId: Value(ledgerId)));

      final recentCount = user.LedgerRecentCount!;
      final tagIds = await (ledgerDB.selectOnly(ledgerDB.ledgerTags)
            ..addColumns([ledgerDB.ledgerTags.Id])
            ..limit(recentCount))
          .map((e) => UserLedgerRecentTagsCompanion.insert(Uid: user.Id, TagId: e.read(ledgerDB.ledgerTags.Id)!))
          .get();

      await UserDB.managers.userLedgerRecentTags.bulkCreate((o) => tagIds);
      await ledgerDB.close();
      await UserDB.managers.userCards.bulkCreate((o) => [
            o(Uid: user.Id, Name: "RecentDays", Place: ELedgerCardSpace.Record),
            o(Uid: user.Id, Name: "EveryDayEntries", Place: ELedgerCardSpace.Record),
            o(Uid: user.Id, Name: "Month", Place: ELedgerCardSpace.Home),
            o(Uid: user.Id, Name: "RecentDays", Place: ELedgerCardSpace.Home),
            o(Uid: user.Id, Name: "EveryDayEntries", Place: ELedgerCardSpace.Home),
          ]);
      return UserDao(Info: user.copyWith(LedgerId: ledgerId), RecentTags: tagIds.map((e) => e.TagId.value));
    });
    Prefs.UserToken = User.Info.Token;
    await LedgerDBHelper.Init();
  }

  ///
  static Future _LoginImpl(ProcessedTableManager query) async {
    try {
      final info = await query.getSingleOrNull() as UserInfo?;
      if (info == null) {
        Prefs.UserToken = "";
        BotToast.showSimpleNotification(title: "找不到用户");
        return;
      }

      final recentTags = (await (UserDB.selectOnly(UserDB.userLedgerRecentTags)
                ..addColumns([UserDB.userLedgerRecentTags.TagId])
                ..where(UserDB.userLedgerRecentTags.Uid.equals(info.Id)))
              .get())
          .map((e) => e.read(UserDB.userLedgerRecentTags.TagId)!);

      User = UserDao(Info: info, RecentTags: recentTags);
      Prefs.UserToken = User.Info.Token;
      await LedgerDBHelper.Init();
    } catch (e) {
      BotToast.showSimpleNotification(title: "登录失败");
      rethrow;
    }
  }
}
