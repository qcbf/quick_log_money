import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
// import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'LedgerDao.g.dart';

late final LedgerDatabaseConnector LedgerDatabase;

///
enum ELedgerOption {
  Hide,
}

///
enum EOwnerRole {
  Anim,
  Member,
}

///
class LedgerInfos extends Table {
  IntColumn get Id => integer().autoIncrement()();
  TextColumn get Name => text()();
  TextColumn get Icon => text()();
  TextColumn get Options => textEnum<ELedgerOption>().nullable()();
}

///
@TableIndex(name: "Entry.TagId", columns: {#TagId})
@TableIndex(name: "Entry.Date", columns: {#Date})
class LedgerEntries extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get TagId => integer()();
  IntColumn get IntMoney => integer()();
  DateTimeColumn get Date => dateTime()();
  TextColumn get Comment => text()();
}

///
@TableIndex(name: "TagGroup.TagId", columns: {#TagId})
class LedgerTagGroups extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get TagId => integer()();
  TextColumn get Name => text()();
}

class LedgerTags extends Table {
  IntColumn get Id => integer().autoIncrement()();
  TextColumn get Name => text()();
}

///
class LedgerRecentTags extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get TagId => integer().autoIncrement()();
}

///
@TableIndex(name: "Owner.UserId", columns: {#UserId})
class LedgerOwners extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get UserId => integer()();
  TextColumn get Role => textEnum<EOwnerRole>()();
}

///
class LedgerFlags {}

///
@DriftDatabase(tables: [LedgerInfos, LedgerEntries, LedgerTags, LedgerRecentTags, LedgerOwners])
class LedgerDatabaseConnector extends _$LedgerDatabaseConnector {
  LedgerDatabaseConnector(String name) : super(_OpenConnection(name));

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
  static LazyDatabase _OpenConnection(String name) {
    return LazyDatabase(() async {
      // await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      sqlite3.tempDirectory = (await getTemporaryDirectory()).path;

      return NativeDatabase.createInBackground(File("${Def.LocalPath}$name"), isolateSetup: () async {
        open
          ..overrideFor(OperatingSystem.android, openCipherOnAndroid)
          ..overrideFor(OperatingSystem.linux, () => DynamicLibrary.open('libsqlcipher.so'))
          ..overrideFor(OperatingSystem.windows, () => DynamicLibrary.open('sqlcipher.dll'));
      }, setup: (db) {
        final result = db.select('pragma cipher_version');
        if (result.isEmpty) {
          throw UnsupportedError('This database needs to run with SQLCipher, but that library is not available!');
        }
        db.execute("pragma key = '$name.f'");
      });
    });
  }
}
