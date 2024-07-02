import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:quick_log_money/Datas/UserData.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:quick_log_money/Utilities/SqlGenerator.dart';
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
CREATE TABLE LedgerRecentTags(Id INTEGER PRIMARY KEY AUTOINCREMENT, TagId INTEGER);
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
  static Future DeleteAllDatas() async {
    DB.execute("DROP TABLE LedgerEntries; DROP TABLE Ledgers; DROP TABLE LedgerRecentTags;");
  }

  ///
  static Future<bool> DeleteLedger(int id) async {
    final rs = await DB.execute("DELETE FROM Ledgers WHERE Id=$id");
    return rs.isNotEmpty;
  }

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
    final rs = await DB.execute("INSERT INTO Ledgers (Json) VALUES(${jsonEncode(ledgerData)})");
    if (rs.isEmpty) {
      throw Exception("put ledger error");
    }
    return rs.first["Id"];
  }

  ///
  static Future UpdateLedger(Map ledgerData) async {
    final id = ledgerData.remove("Id");
    if (id == null) throw Exception("not found key: Id");
    final rs = await DB.execute("UPDATE Ledgers SET Json=${jsonEncode(ledgerData)} WHERE Id=$id");
    if (rs.isEmpty) {
      throw Exception("not found ledger:$id");
    }
  }

  ///
  static Future AddEntry(Map entryData) async {
    entryData.remove("Id");
    await DB.execute("INSERT INTO LedgerEntries (${entryData.keys.join(",")}) VALUES(?)", entryData.values.toList());
  }

  ///
  static Future DeleteEntry(int id) async {
    await DB.execute("DELETE FROM LedgerEntries WHERE Id=$id");
  }

  ///
  static Future UpdateEntry(Map<String, dynamic> entryData) async {
    final id = entryData.remove("Id");
    if (id == null) throw Exception("not found key: Id");
    DB.execute(SqlGenerator.Update("LedgerEntries", entryData, {"Id": id}));
  }
}
