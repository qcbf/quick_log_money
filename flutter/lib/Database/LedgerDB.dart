import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:quick_log_money/Database/DatabaseHelper.dart';
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
      Info: AsyncValue(() async => await LedgerDB.managers.ledgerInfos.filter((f) => f.Id(User.Info.LedgerId)).getSingle()),
      Tag: AsyncValue(() async => await LedgerTagDao.Create()),
    );
  }
}

///
class LedgerTagDao {
  final Map<int, LedgerTag> AllTags;
  final Map<String, List<LedgerTag>> TagGroups;
  LedgerTagDao({required this.AllTags, required this.TagGroups});
  static Future<LedgerTagDao> Create() async {
    final allTags = await LedgerDB.managers.ledgerTags.get();
    return LedgerTagDao(
      AllTags: Map.fromEntries(allTags.map((e) => MapEntry(e.Id, e))),
      TagGroups: allTags.groupListsBy((e) => e.Group),
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
  TextColumn get LocationCountry => text()();
  TextColumn get LocationCity => text()();
  TextColumn get LocationStreet => text()();
}

class LedgerTags extends Table {
  IntColumn get Id => integer().autoIncrement()();
  TextColumn get Group => text()();
  TextColumn get Name => text()();
  TextColumn get Icon => text()();
}

///
@TableIndex(name: "LedgerOwners.UserId", columns: {#UserId})
class LedgerOwners extends Table {
  IntColumn get Id => integer().autoIncrement()();
  IntColumn get UserId => integer().unique()();
  TextColumn get Role => textEnum<EOwnerRole>()();
}

///
class LedgerFlags {}

///
@DriftDatabase(tables: [LedgerInfos, LedgerEntries, LedgerTags, LedgerOwners])
class LedgerDBHelper extends _$LedgerDBHelper {
  static bool _LedgerDBIsConnected = false;
  LedgerDBHelper(String name, int userId) : super(DatabaseHelper.OpenConnection("lg.$userId.sl"));
  LedgerDBHelper.FromUser(int userId)
      : assert(userId > 0, "not found UserId"),
        super(DatabaseHelper.OpenConnection("lg.$userId.sl"));

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
    assert(!Prefs.IsNotUserId, "not found UserId");
    if (_LedgerDBIsConnected) LedgerDB.close();
    LedgerDB = LedgerDBHelper.FromUser(Prefs.UserId);
    _LedgerDBIsConnected = true;
    await DatabaseHelper.DebugTryResetDatabase(LedgerDB);
    Ledger = await UserLedgerDao.Create();
  }

  ///
  static Future Uninit() async {
    await LedgerDB.close();
  }

  ///
  static Future<int> CreateLedger(int userId, LedgerDBHelper db, LedgerInfosCompanion info, Iterable<LedgerTagsCompanion> tags) async {
    await Future.wait([for (var t in db.allTables) t.deleteAll()]);
    final id = await db.managers.ledgerInfos.create((o) => info);
    await db.managers.ledgerTags.bulkCreate((o) => tags);
    await db.managers.ledgerOwners.create((o) => o(Role: EOwnerRole.Anim, UserId: userId));
    return id;
  }
}
