import 'package:flutter/material.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/EntryData.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerEntity.dart';

/// 编辑时的条目数据
class EntryEditingProvider with ChangeNotifier {
  late EntryData Data;

  ///
  int? TagId;

  ///
  String Comment = "";

  ///
  bool IsIncome = false;

  ///
  String MoneyIntegerStr = "";
  String? MoneyDecimalStr;

  EntryEditingProvider() {
    Data = EntryData(LedgerId: 0, TagId: 0, Date: DateTime.now());
  }

  String GetMoneyString() {
    final integer = MoneyIntegerStr.isEmpty ? "0" : MoneyIntegerStr;
    if (MoneyDecimalStr == null) return integer;
    return "$integer.$MoneyDecimalStr";
  }

  void Save() {
    var money = (int.tryParse(MoneyIntegerStr) ?? 0) * 100;
    if (MoneyDecimalStr?.isNotEmpty == true) {
      money += int.parse(MoneyDecimalStr!);
    }
    LedgerProvider.Global.value.InteractivePushEntry(Data.CopyWith(IntMoney: money, Comment: Comment));
  }

  void Notify() {
    notifyListeners();
  }
}
