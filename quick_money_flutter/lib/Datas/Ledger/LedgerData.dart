import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagGroupData.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:quick_log_money/Utilities/LocalDB.dart';

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
  static Future<LedgerData> CreateFromTemplate(int OwnerUser, {String? Name}) async {
    final jsonMap = jsonDecode(await rootBundle.loadString(DefaultLedgerPath)) as Map;
    jsonMap["OwnerUser"] = OwnerUser;
    if (Name != null) jsonMap["Name"] = Name;
    int index = 0;
    final tagGroups = List<dynamic>.empty(growable: true);
    final allTags = <String, dynamic>{};
    final jsonTags = jsonMap["Tags"] as Map<String, dynamic>;
    jsonTags.forEach((key, value) {
      final tagGroup = TagGroupData(List<int>.filled(value.length, 0));
      for (var i = 0; i < value.length; i++) {
        final tagJson = value[i] as List;
        final id = ++index;
        tagGroup.Tags[i] = id;
        allTags[id.toString()] = TagData(Name: tagJson[0], Icon: tagJson[1]).toJson();
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
class LedgerProvider with ChangeNotifier {
  LedgerBase? _Ledger;
  LedgerBase get Ledger => _Ledger!;

  bool get IsInited => _Ledger != null;

  LedgerProvider() {
    LocalDB.get("Ledger").then((v) {
      if (v == null) return;
      SetLedgerFromData(LedgerData.fromJson(jsonDecode(v)));
    });
  }

  ///
  Future SetLedger(LedgerBase v) async {
    print("set ledger: ${v.Data.Id} ${v.Data.Name}");
    _Ledger = v;
    await LocalDB.put("Ledger", jsonEncode(v.Data.toJson()));
    notifyListeners();
  }

  Future SetLedgerFromData(LedgerData data) async {
    switch (data.Type) {
      case 1:
        await SetLedger(LocalLedger(data));
        return true;
      case 2:
        await SetLedger(ServerLedger(data));
        return true;
    }
  }
}

/// 账本基类
abstract class LedgerBase<TData extends LedgerData> {
  final TData Data;
  // List<EntryData> Entries = List.empty();

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
