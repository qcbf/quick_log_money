import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:quick_log_money/Database/DatabaseConnector.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/Utilities/AsyncValue.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';

part 'LedgerDB.g.dart';

late final LedgerDBHelper LedgerDB;
late final UserLedgerDao Ledger;

///
class UserLedgerDao {
  final AsyncValue<LedgerInfo> Info;
  final AsyncValue<LedgerTagDao> Tag;
  UserLedgerDao({required this.Info, required this.Tag});
  static Future<UserLedgerDao> Create() async {
    return UserLedgerDao(
      Info: AsyncValue(() async => await LedgerDB.managers.ledgerInfos.filter((f) => f.Id(UserData.LedgerId)).getSingle()),
      Tag: AsyncValue(() async => await LedgerTagDao.Create()),
    );
  }
}

///
class LedgerTagDao {
  final Map<int, LedgerTag> AllTags;
  final Map<String, List<LedgerTag>> TagGroups;
  final List<LedgerTag> RecentTags;
  LedgerTagDao({required this.AllTags, required this.TagGroups, required this.RecentTags});
  static Future<LedgerTagDao> Create() async {
    final allTags = await LedgerDB.managers.ledgerTags.get();
    return LedgerTagDao(
      AllTags: Map.fromEntries(allTags.map((e) => MapEntry(e.Id, e))),
      TagGroups: allTags.groupListsBy((e) => e.Group),
      RecentTags: await LedgerDB.select(LedgerDB.ledgerRecentTags).map((t) => allTags[t.Id]).get(),
    );
  }
}

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
  IntColumn get RecentCount => integer().withDefault(const Constant(8))();
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

class LedgerTags extends Table {
  IntColumn get Id => integer().autoIncrement()();
  TextColumn get Group => text()();
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
@DriftDatabase(tables: [LedgerInfos, LedgerEntries, LedgerTags, LedgerRecentTags, LedgerOwners])
class LedgerDBHelper extends _$LedgerDBHelper {
  LedgerDBHelper(String name, int userId) : super(DatabaseConnector.OpenConnection("lg.$userId.sl"));
  LedgerDBHelper.FromUser(int userId)
      : assert(userId > 0, "not found UserId"),
        super(DatabaseConnector.OpenConnection("lg.$userId.sl"));

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
    assert(!Prefs.IsNotUserId, "not found UserId");
    LedgerDB = LedgerDBHelper.FromUser(Prefs.UserId);
    Ledger = await UserLedgerDao.Create();
  }

  ///
  static Future Uninit() async {
    await LedgerDB.close();
  }

  ///
  static Future<int> CreateLedger(int userId, LedgerDBHelper db, LedgerInfosCompanion info, Iterable<LedgerTagsCompanion> tags) async {
    final id = await db.managers.ledgerInfos.create((o) => info);
    await db.managers.ledgerTags.bulkCreate((o) => tags);
    await db.managers.ledgerOwners.create((o) => o(Role: EOwnerRole.Anim, UserId: userId));
    await db.managers.ledgerRecentTags.bulkCreate((o) => tags.take(info.RecentCount.value).map((e) => LedgerRecentTagsCompanion(TagId: e.Id)));
    return id;
  }
}
