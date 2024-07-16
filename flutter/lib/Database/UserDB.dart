import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:quick_log_money/Database/DatabaseHelper.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';
import 'package:quick_log_money/pages/LedgerCards/LedgerCardUtility.dart';

part 'UserDB.g.dart';

late final UserDBHelper UserDB;
late final UserDao User;

class UserDao {
  final UserInfo Info;
  final Iterable<int> RecentTags;
  UserDao({required this.Info, required this.RecentTags});
}

///
class UserInfos extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get LedgerId => integer()();
  IntColumn get LedgerRecentCount => integer().withDefault(const Constant(8)).nullable()();
  TextColumn get Name => text()();
  TextColumn get Icon => text()();
  TextColumn get Token => text().nullable()();
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
    if (Prefs.IsNotUserId) return;
    try {
      final result = await Future.wait<dynamic>([
        UserDB.managers.userInfos.filter((f) => f.Id(Prefs.UserId)).getSingle(),
        (UserDB.selectOnly(UserDB.userLedgerRecentTags)
              ..addColumns([UserDB.userLedgerRecentTags.TagId])
              ..where(UserDB.userLedgerRecentTags.Uid.equals(Prefs.UserId)))
            .get(),
      ]);
      await _OnLoginFinish(UserDao(
        Info: result[0],
        RecentTags: (result[1] as List<TypedResult>).map((e) => e.read(UserDB.userLedgerRecentTags.TagId)!),
      ));
    } catch (e) {
      Prefs.SetNotUserId();
      rethrow;
    }
  }

  static Future Loginout() async {
    Prefs.SetNotUserId();
    // User = UserDao(Info: UserInfo(Id: 0, LedgerId: 0, Name: "", Icon: "", RegisterDate: DateTime(0)));
    await LedgerDBHelper.Uninit();
  }

  ///
  static Future Login(String username, String password) async {
    // _OnLoginFinish();
  }

  ///
  static Future LoginAnonym() async {
    // 创造账本数据
    final ledgerJson = jsonDecode(await rootBundle.loadString(Def.LedgerConfigPath, cache: false))["Template"] as Map<String, dynamic>;
    final ledgerInfo = LedgerInfosCompanion.insert(Name: ledgerJson["Name"], Icon: ledgerJson["Icon"]);
    final tags = (ledgerJson["Tags"] as Map<String, dynamic>)
        .entries
        .expand((e) => (e.value as List).map((tag) => LedgerTagsCompanion.insert(Group: e.key, Name: tag[0], Icon: tag[1])));

    await _OnLoginFinish(await UserDB.transaction<UserDao>(() async {
      final user = await UserDB.managers.userInfos.createReturning((o) => o(Name: "游客", Icon: "", LedgerId: 0));

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
      return UserDao(Info: user.copyWith(LedgerId: ledgerId), RecentTags: tagIds.map((e) => e.TagId.value));
    }));
  }

  ///
  static Future _OnLoginFinish(UserDao u) async {
    User = u;
    Prefs.UserId = User.Info.Id;
    await LedgerDBHelper.Init();
  }
}
