import 'dart:async';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/EntryData.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagGroupData.dart';
import 'package:quick_log_money/Datas/UserData.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:sqlite_async/sqlite_async.dart';

part 'LedgerData.g.dart';

/// 账本数据
@JsonSerializable(anyMap: true)
class LedgerData {
  final int Id;
  final int Type;
  final int OwnerUser;
  final String Name;
  final String Icon;
  final bool IsHided;
  final List<TagGroupData> TagGroups;
  final Map<int, TagData> AllTags;
  final List<int>? MoreUsers;
  const LedgerData(
      {required this.Id,
      required this.Type,
      required this.OwnerUser,
      this.Name = "",
      this.Icon = "",
      this.MoreUsers,
      this.IsHided = false,
      required this.TagGroups,
      required this.AllTags});

  Map<String, dynamic> toJson() => _$LedgerDataToJson(this);
  factory LedgerData.fromJson(Map json) => _$LedgerDataFromJson(json);

  ///从配置模板创建数据
  static Future<LedgerData> CreateFromTemplate(int id, int OwnerUser, {String? Name}) async {
    final jsonMap = jsonDecode(await rootBundle.loadString(Def.LedgerTemplatePath)) as Map;
    jsonMap["Id"] = id;
    jsonMap["OwnerUser"] = OwnerUser;
    if (Name != null) jsonMap["Name"] = Name;
    int index = 0;
    final tagGroups = List<dynamic>.empty(growable: true);
    final allTags = <String, dynamic>{};
    final jsonTags = jsonMap["Tags"] as Map<String, dynamic>;
    jsonTags.forEach((key, value) {
      final tagGroup = TagGroupData(key, List<int>.filled(value.length, 0));
      for (var i = 0; i < value.length; i++) {
        final tagJson = value[i] as List;
        final id = ++index;
        tagGroup.Tags[i] = id;
        allTags[id.toString()] = TagData(tagJson[0], tagJson[1]).toJson();
      }
      tagGroups.add(tagGroup.toJson());
    });
    jsonMap.remove("Tags");
    jsonMap["TagGroups"] = tagGroups;
    jsonMap["AllTags"] = allTags;
    return LedgerData.fromJson(jsonMap);
  }
}

/// 账本事件容器
class LedgerProvider with ChangeNotifier implements ValueListenable<LedgerBase> {
  static LedgerProvider Global = LedgerProvider();
  LedgerBase<LedgerData>? _Value;

  @override
  LedgerBase<LedgerData> get value => _Value!;

  bool get IsInited => _Value != null;

  ///
  Future TryInit() async {
    final db = await _OpenDB();
    try {
      final ledgerRawData = await db.get(UserDataProvider.Global.Id);
      if (ledgerRawData != null) {
        final ledger = CreateLedgerFromData(LedgerData.fromJson(jsonDecode(ledgerRawData)));
        _Value = ledger;
        notifyListeners();
      }
    } finally {
      db.close();
    }
  }

  ///
  Future SetLedger(LedgerBase? newValue) async {
    if (newValue == _Value) return;
    print("set ledger: ${newValue?.Data.Id} ${newValue?.Data.Name} ${newValue?.Data.Type}");
    _Value = newValue;
    notifyListeners();
    final db = await _OpenDB();
    try {
      if (newValue == null) {
        await db.delete(UserDataProvider.Global.Id);
      } else {
        await db.put(UserDataProvider.Global.Id, jsonEncode(newValue.Data.toJson()));
      }
    } finally {
      await db.close();
    }
  }

  ///
  static LedgerBase CreateLedgerFromData(LedgerData data) {
    return switch (data.Type) {
      // 1 => LocalLedger(data),
      // 2 => ServerLedger(data),
      3 => AnonymLedger(data),
      _ => throw Exception(""),
    };
  }
}

class _LedgerDao {
  static final SqliteDatabase _DB = SqliteDatabase(path: "${Def.LocalPath}${UserDataProvider.Global.Id}");
  static final SqliteMigrations _Migrations = SqliteMigrations()
    ..createDatabase = SqliteMigration(1, (cxt) async => await cxt.execute("sql"))
    ..migrate(_DB);
  void Sql(stri){
    
  }
  
}

/// 账本基类
abstract class LedgerBase<TData extends LedgerData> {
  final TData Data;
  const LedgerBase(this.Data);

  ///
  void InteractivePushEntry(EntryData data) {
    final cancelLoading = BotToast.showLoading(duration: const Duration(days: 1));
    PushEntry(data).then((_) => cancelLoading());
  }

  ///
  Future PushEntry(EntryData data) async {
    final box = await Hive.openLazyBox("${UserDataProvider.Global.Id}.ledger.entries");
    try {
      if (box.length > 9999999) {
        BotToast.showSimpleNotification(title: "保存失败", subTitle: "已经存在过多的本地缓存数据");
        return;
      }

      await box.add(data.toJson());
      SyncEntries();
    } finally {
      await box.flush();
      box.close();
    }
  }

  FutureOr SyncEntries();
}

/// 本地账本
// class LocalLedger extends LedgerBase<LedgerData> {
//   const LocalLedger(super.Data);
//   @override
//   Future PushEntry(EntryData data) {}
// }

/// 匿名账本
class AnonymLedger extends LedgerBase<LedgerData> {
  const AnonymLedger(super.Data);

  @override
  FutureOr SyncEntries() {
    BotToast.showSimpleNotification(title: "同步到临时账本", subTitle: "注意：当前是临时账号，数据存在丢失风险，请尽快登录!");
  }
}

/// 网络账本
// class ServerLedger extends LedgerBase<LedgerData> {
//   const ServerLedger(super.Data);
//   @override
//   Future PushEntry(EntryData data) {}
// }
