import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';

/// 编辑时的条目数据
class RecordEntryEditingProvider with ChangeNotifier {
  ///
  DateTime Date = DateTime.now();

  ///
  LedgerTag Tag = const LedgerTag(Id: 0, Group: "", Name: "", Icon: "");

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

  Future<String?> Save() async {
    var money = (int.tryParse(MoneyIntegerStr) ?? 0) * 100;
    if (MoneyDecimalStr?.isNotEmpty == true) {
      money += int.parse(MoneyDecimalStr!);
    }
    if (money == 0) {
      return "请填写金额";
    }
    final loadingCancel = BotToast.showLoading();
    await LedgerDB.managers.ledgerEntries.create((o) => LedgerEntriesCompanion.insert(TagId: Tag.Id, IntMoney: money, Date: Date, Comment: Comment));
    loadingCancel();
    return null;
  }

  void Notify() {
    notifyListeners();
  }
}
