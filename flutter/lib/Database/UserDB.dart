import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:quick_log_money/Database/DatabaseConnector.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';

part 'UserDB.g.dart';

late final UserDBHelper UserDB;
late final User UserData;

///
class Users extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get LedgerId => integer()();
  TextColumn get Name => text()();
  TextColumn get Icon => text()();
  TextColumn get Token => text().nullable()();
  DateTimeColumn get VipExpiryDate => dateTime().nullable()();
  DateTimeColumn get RegisterDate => dateTime().withDefault(currentDate)();
}

///
@DriftDatabase(tables: [Users])
class UserDBHelper extends _$UserDBHelper {
  UserDBHelper(String name) : super(DatabaseConnector.OpenConnection(name));

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
        // if (kDebugMode) {
        //   final m = Migrator(this);
        //   for (final table in allTables) {
        //     await m.deleteTable(table.actualTableName);
        //     await m.createTable(table);
        //   }
        // }
      },
    );
  }

  ///
  static Future Init() async {
    UserDB = UserDBHelper("users");
    if (Prefs.IsNotUserId) return;
    try {
      _OnLoginFinish(await UserDB.managers.users.filter((f) => f.Id(Prefs.UserId)).getSingle());
    } catch (e) {
      Prefs.SetNotUserId();
      rethrow;
    }
  }

  static Future Loginout() async {
    Prefs.SetNotUserId();
    UserData = User(Id: 0, LedgerId: 0, Name: "", Icon: "", RegisterDate: DateTime(0));
    await LedgerDBHelper.Uninit();
  }

  ///
  static Future Login(String username, String password) async {
    // _OnLoginFinish();
  }

  ///
  static Future LoginAnonym() async {
    final ledgerJson = jsonDecode(await rootBundle.loadString(Def.LedgerTemplatePath, cache: false)) as Map<String, dynamic>;
    final ledgerInfo = LedgerInfo.fromJson(ledgerJson);
    final List<(String, LedgerTagsCompanion)> tags = [];
    for (var tagGroupJson in (ledgerJson["Tags"] as Map<String, dynamic>).entries) {
      for (List tag in tagGroupJson.value) {
        tags.add((tagGroupJson.key, LedgerTagsCompanion.insert(Name: tag[0], Icon: tag[1])));
      }
    }

    await _OnLoginFinish(await UserDB.transaction<User>(() async {
      final ledgerId = await LedgerDB.managers.ledgerInfos.create((o) => ledgerInfo);
      for (var tag in tags) {
        final id = await LedgerDB.managers.ledgerTags.create((o) => tag.$2);
        await LedgerDB.managers.ledgerTagGroups.create((o) => o(Name: tag.$1, TagId: id));
      }

      final user = await UserDB.managers.users.createReturning((o) => o(
            Name: "游客",
            Icon: "",
            LedgerId: ledgerId,
          ));
      return user;
    }));
  }

  ///
  static Future _OnLoginFinish(User u) async {
    UserData = u;
    Prefs.UserId = UserData.Id;
    await LedgerDBHelper.Init();
  }
}
