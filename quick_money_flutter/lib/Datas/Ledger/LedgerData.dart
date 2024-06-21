import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_money_flutter/Datas/Ledger/Entry/EntryData.dart';
import 'package:quick_money_flutter/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_money_flutter/Utilities/Def.dart';
import 'package:quick_money_flutter/Utilities/LocalDB.dart';

part 'LedgerData.g.dart';

/// 账本数据
@JsonSerializable()
class LedgerData {
  int Id = 0;
  int Type = 0;
  int OwnerUser = 0;
  String? Name;
  String? Icon;
  bool IsHided = false;
  List<EntryData> Entries = List.empty();
  Map<String, List<TagData>> Tags = Map.identity();
  List<int>? MoreUsers;
  LedgerData();

  Map<String, dynamic> toJson() => _$LedgerDataToJson(this);
  factory LedgerData.fromJson(Map<String, dynamic> json) => _$LedgerDataFromJson(json);
}

/// 账本事件容器
class LedgerProvider with ChangeNotifier {
  Ledger? _Value;
  Ledger? get Value => _Value;

  ///
  SetValue(Ledger? v) {
    _Value = v;
    notifyListeners();
  }

  ///
  _SetValue(String jsonText) {
    final jsonData = jsonDecode(jsonText);
    final data = LedgerData.fromJson(jsonData);
    switch (data.Type) {
      case 1:
        SetValue(LocalLedger(data));
        return true;
      case 2:
        SetValue(ServerLedger(data));
        return true;
    }
  }

  ///
  Future<bool> Init() async {
    if (LocalDB.containsKey("Ledger")) {
      _SetValue(await LocalDB.get("Ledger"));
    }
    return false;
  }

  ///
  Future LoadTemplate() async {
    final json = await rootBundle.loadString(DefaultLedgerPath);
    // LocalDB.put("Ledger", json);
    _SetValue(json);
  }
}

/// 账本基类
abstract class Ledger<TData extends LedgerData> {
  TData? Data;
  Ledger(this.Data);
}

/// 本地账本
class LocalLedger extends Ledger<LedgerData> {
  LocalLedger(super.Data);
}

/// 网络账本
class ServerLedger extends Ledger<LedgerData> {
  ServerLedger(super.Data);
}
