import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:quick_log_money/Datas/UserData.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:sqlite_async/sqlite_async.dart';

///
class LedgerDao {
  static final SqliteDatabase DB = CreateDB();
  static bool IsInited = false;
  static FutureOr<void> get InitedWating => IsInited ? null : Future.doWhile(() => !LedgerDao.IsInited);

  ///
  static SqliteDatabase CreateDB() {
    final db = SqliteDatabase(path: "${Def.LocalPath}${UserDataProvider.Global.Id}");
    final migrations = SqliteMigrations()
      ..createDatabase = SqliteMigration(1, (cxt) async {
        await cxt.execute("""
CREATE TABLE Ledgers(Id INTEGER PRIMARY KEY AUTOINCREMENT, Json TEXT);
CREATE TABLE LedgerEntries (
  Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  LedgerId INTEGER NOT NULL,
  TagId INTEGER NOT NULL,
  IntMoney integer DEFAULT 0,
  Date integer,
  Comment TEXT,
  FOREIGN KEY (LedgerId) REFERENCES Ledgers (Id) ON DELETE CASCADE
);
CREATE INDEX LedgerEntriesIdx ON LedgerEntries (LedgerId, TagId);
        """);
      });
    migrations
        .migrate(db)
        .then((_) => IsInited = true, onError: (_) => BotToast.showSimpleNotification(title: "init ledger error"));
    return db;
  }

  ///
  static Future DeleteAllDatas() async {}

  ///
  static Future DeleteLedger(int id) async {}

  ///
  static Future<Map?> GetLedger(int id) async {
    final row = await DB.get("SELECT * FROM Ledgers WHERE Id=$id");
    if (row.isEmpty) return null;
    final rs = jsonDecode(row["Json"]);
    rs["Id"] = row["Id"];
    return rs;
  }

  ///
  static Future<int> AddLedger(Map ledgerData) async {
    jsonEncode(ledgerData);
    final rs = await DB.execute("INSERT INTO Ledgers (Json) VALUES(${jsonEncode(ledgerData)})");
    if (rs.isEmpty) {
      throw Exception("put ledger error");
    }
    return rs.first["Id"];
  }
}
