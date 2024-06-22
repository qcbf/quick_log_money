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
  final Map<String, List<TagData>> Tags;
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
      final data = LedgerData.fromJson(jsonDecode(v));
      Future.delayed(Durations.extralong4, () => SetLedgerFromData(data));
      // SetLedgerFromData(data);
    });
  }

  ///
  SetLedger(LedgerBase v) {
    print("set ledger: ${v.Data?.Id} ${v.Data?.Name}");
    _Ledger = v;
    if (v.Data == null) {
      LocalDB.delete("Ledger");
    } else {
      LocalDB.put("Ledger", jsonEncode(v.Data!.toJson()));
    }
    notifyListeners();
  }

  SetLedgerFromData(LedgerData data) {
    switch (data.Type) {
      case 1:
        SetLedger(LocalLedger(data));
        return true;
      case 2:
        SetLedger(ServerLedger(data));
        return true;
    }
  }
}

/// 账本基类
abstract class LedgerBase<TData extends LedgerData> {
  final TData? Data;
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
