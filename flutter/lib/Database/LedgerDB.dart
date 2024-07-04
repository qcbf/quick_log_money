import 'package:drift/drift.dart';
import 'package:quick_log_money/Database/DatabaseConnector.dart';

part 'LedgerDB.g.dart';

late final LedgerDBHelper LedgerDB;

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
@TableIndex(name: "LedgerEntries.TagId", columns: {#TagId})
@TableIndex(name: "LedgerEntries.Date", columns: {#Date})
class LedgerEntries extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get TagId => integer()();
  IntColumn get IntMoney => integer()();
  DateTimeColumn get Date => dateTime()();
  TextColumn get Comment => text()();
}

///
@TableIndex(name: "LedgerTagGroups.TagId", columns: {#TagId})
class LedgerTagGroups extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get TagId => integer()();
  TextColumn get Name => text()();
}

class LedgerTags extends Table {
  IntColumn get Id => integer().autoIncrement()();
  TextColumn get Name => text()();
  TextColumn get Icon => text()();
}

///
class LedgerRecentTags extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get TagId => integer()();
}

///
@TableIndex(name: "LedgerOwners.UserId", columns: {#UserId})
class LedgerOwners extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get UserId => integer()();
  TextColumn get Role => textEnum<EOwnerRole>()();
}

///
class LedgerFlags {}

///
@DriftDatabase(tables: [LedgerInfos, LedgerEntries, LedgerTags, LedgerTagGroups, LedgerRecentTags, LedgerOwners])
class LedgerDBHelper extends _$LedgerDBHelper {
  LedgerDBHelper(String name) : super(DatabaseConnector.OpenConnection(name));

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
}
