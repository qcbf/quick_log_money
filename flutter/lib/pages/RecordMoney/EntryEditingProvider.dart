import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/EntryData.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerDao.dart';

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

  Future Save() async {
    var money = (int.tryParse(MoneyIntegerStr) ?? 0) * 100;
    if (MoneyDecimalStr?.isNotEmpty == true) {
      money += int.parse(MoneyDecimalStr!);
    }
    Data = Data.copyWith(IntMoney: money, Comment: Comment);
    final loadingCancel = BotToast.showLoading();
    await LedgerDao.AddEntry(Data.toJson());
    BotToast.showSimpleNotification(title: "保存成功", duration: Durations.long2);
    loadingCancel();
  }

  void Notify() {
    notifyListeners();
  }
}
