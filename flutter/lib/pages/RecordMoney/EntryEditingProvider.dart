import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';

/// 编辑时的条目数据
class EntryEditingProvider with ChangeNotifier {
  ///
  DateTime Date = DateTime.now();

  ///
  int TagId = 0;

  ///
  String Comment = "";

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

  Future Save() async {
    var money = (int.tryParse(MoneyIntegerStr) ?? 0) * 100;
    if (MoneyDecimalStr?.isNotEmpty == true) {
      money += int.parse(MoneyDecimalStr!);
    }
    final loadingCancel = BotToast.showLoading();
    await LedgerDB.managers.ledgerEntries.create((o) => LedgerEntriesCompanion.insert(TagId: TagId, IntMoney: money, Date: Date, Comment: Comment));
    BotToast.showSimpleNotification(title: "保存成功", duration: Durations.long2);
    loadingCancel();
  }

  void Notify() {
    notifyListeners();
  }
}
