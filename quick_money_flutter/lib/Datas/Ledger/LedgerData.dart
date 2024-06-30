import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagGroupData.dart';
import 'package:quick_log_money/Datas/UserData.dart';
import 'package:quick_log_money/Utilities/Def.dart';

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
  static Future<LazyBox> _OpenDB() async {
    final box = await Hive.openLazyBox("ledger");
    return box;
  }

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
    print("set ledger: ${newValue?.Data.Id} ${newValue?.Data.Name}");
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
      1 => LocalLedger(data),
      2 => ServerLedger(data),
      _ => throw Exception(""),
    };
  }
}

/// 账本基类
abstract class LedgerBase<TData extends LedgerData> {
  final TData Data;
  const LedgerBase(this.Data);
}

/// 本地账本
class LocalLedger extends LedgerBase<LedgerData> {
  const LocalLedger(super.Data);
}

/// 网络账本
class ServerLedger extends LedgerBase<LedgerData> {
  const ServerLedger(super.Data);
}
