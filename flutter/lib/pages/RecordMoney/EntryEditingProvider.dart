import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';

/// 编辑时的条目数据
class EntryEditingProvider with ChangeNotifier {
  late LedgerEntry Data;

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
    Data = LedgerEntry.fromJson({});
  }

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
    Data = Data.copyWith(IntMoney: money, Comment: Comment);
    final loadingCancel = BotToast.showLoading();

    // LedgerDatabase.managers.ledgerEntries.create((o) => o());
    BotToast.showSimpleNotification(title: "保存成功", duration: Durations.long2);
    loadingCancel();
  }

  void Notify() {
    notifyListeners();
  }
}
