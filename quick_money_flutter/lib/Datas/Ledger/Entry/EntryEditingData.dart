import 'package:quick_money_flutter/Datas/Ledger/Entry/EntryData.dart';

class EntryEditingData extends EntryData {
  ///
  bool IsCost = true;

  ///
  String MoneyIntegerStr = "";
  String? MoneyDecimalStr;

  @override
  String GetMoneyString() {
    final integer = MoneyIntegerStr.isEmpty ? "0" : MoneyIntegerStr;
    if (MoneyDecimalStr == null) return integer;
    return "$integer.$MoneyDecimalStr";
  }

  void Done() {
    Money = (int.tryParse(MoneyIntegerStr) ?? 0) * 100;
    if (MoneyDecimalStr?.isNotEmpty == true) {
      Money += int.parse(MoneyDecimalStr!);
    }
  }
}
