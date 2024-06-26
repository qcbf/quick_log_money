import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/EntryData.dart';

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
    Data = Data.CopyWith(IntMoney: money, Comment: Comment);

    BotToast.showSimpleNotification(title: jsonEncode(Data.toJson()));
  }

  void Notify() {
    notifyListeners();
  }
}
