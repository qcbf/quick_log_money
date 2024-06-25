import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
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
  @JsonKey(fromJson: _TagsFromJson, toJson: _TagsToJson)
  final Map<String, Map<int, TagData>> Tags;
  final List<int>? MoreUsers;
  const LedgerData(
      {required this.Id,
      required this.Type,
      required this.OwnerUser,
      this.Name = "",
      this.Icon = "",
      this.MoreUsers,
      this.IsHided = false,
      required this.Tags});

  Map<String, dynamic> toJson() => _$LedgerDataToJson(this);
  factory LedgerData.fromJson(Map json) => _$LedgerDataFromJson(json);
  static Future<LedgerData> CreateFromTemplate(int OwnerUser, {String? Name}) async {
    final jsonMap = jsonDecode(await rootBundle.loadString(DefaultLedgerPath));
    jsonMap["OwnerUser"] = OwnerUser;
    if (Name != null) jsonMap["Name"] = Name;
    int index = 0;
    final tags = jsonMap["Tags"] as Map<String, dynamic>;
    tags.forEach((key, value) {
      for (List item in value) {
        item.insert(0, ++index);
      }
    });
    return LedgerData.fromJson(jsonMap);
  }

  static Map<String, Map<int, TagData>> _TagsFromJson(Map<String, dynamic> json) => json.map((key, value) =>
      MapEntry(key, {for (var element in value) element[0]: TagData(element[0], Icon: element[1], Name: element[2])}));
  static Map<String, Iterable<List>> _TagsToJson(Map<String, Map<int, TagData>> data) =>
      data.map((key, value) => MapEntry(key, value.values.map((v) => [v.Id, v.Icon, v.Name])));
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
