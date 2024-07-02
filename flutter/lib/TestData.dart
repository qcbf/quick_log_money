import 'package:drift/drift.dart';

import 'dart:io';
import 'package:drift/native.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'TestData.g.dart';

@TableIndex(name: 'Name', columns: {#MyValue})
class TestTable extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get MyValue => integer()();
  IntColumn get Value2 => integer()();
  TextColumn get Name => text()();
}

@DriftDatabase(tables: [TestTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_OpenConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) => m.createAll(),
      onUpgrade: (m, from, to) async {
        await customStatement('PRAGMA foreign_keys = OFF');
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        if (kDebugMode) {
          final m = Migrator(this);
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        }
      },
    );
  }

  static LazyDatabase _OpenConnection() {
    return LazyDatabase(() async {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      sqlite3.tempDirectory = (await getTemporaryDirectory()).path;
      return NativeDatabase.createInBackground(File("${Def.LocalPath}AAA.db"));
    });
  }
}
