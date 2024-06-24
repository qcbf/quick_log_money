import 'package:flutter/material.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/EntryData.dart';

/// 编辑时的条目数据
class EntryEditingProvider with ChangeNotifier {
  final EntryData Data = EntryData();

  ///
  int? TagId;

  ///
  bool IsIncome = false;

  ///
  String MoneyIntegerStr = "";
  String? MoneyDecimalStr;

  String GetMoneyString() {
    final integer = MoneyIntegerStr.isEmpty ? "0" : MoneyIntegerStr;
    if (MoneyDecimalStr == null) return integer;
    return "$integer.$MoneyDecimalStr";
  }

  void Done() {
    Data.Money = (int.tryParse(MoneyIntegerStr) ?? 0) * 100;
    if (MoneyDecimalStr?.isNotEmpty == true) {
      Data.Money += int.parse(MoneyDecimalStr!);
    }
  }

  void SetDirty() {
    notifyListeners();
  }
}
