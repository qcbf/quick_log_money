import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';

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

  final MoneyCalc = Calculator();

  Future<String?> Save() async {
    var money = MoneyCalc.GetResult();
    if (money == 0) {
      return "请填写金额";
    }
    final loadingCancel = BotToast.showLoading();
    await LedgerDB.managers.ledgerEntries.create((o) => LedgerEntriesCompanion.insert(TagId: Tag.Id, IntMoney: money, Date: Date, Comment: Comment));
    loadingCancel();
    return null;
  }

  void SetState(VoidCallback handler, {bool isHapticFeedback = true}) {
    handler.call();
    notifyListeners();
    if (isHapticFeedback) HapticFeedback.lightImpact();
  }

  void Notify() {
    notifyListeners();
  }
}

enum ECalcOperator {
  None,
  Add,
  Sub,
}

class Calculator {
  final List<dynamic> Values = [CalcNumeric()];
  bool get IsHasOperator => Values.length > 1;

  ///
  @override
  String toString() {
    var strbuf = StringBuffer();
    for (var i = 0; i < Values.length; i++) {
      final op = TryCastType<ECalcOperator>(Values[i]);
      if (op != null) {
        if (op == ECalcOperator.Add) {
          strbuf.write("+");
        } else if (op == ECalcOperator.Sub) {
          strbuf.write("-");
        } else {
          throw Exception("not found oprator: $op");
        }
      } else {
        strbuf.write(Values[i].toString());
      }
    }
    return strbuf.toString();
  }

  ///
  void Clear() {
    Values.clear();
    Values.add(CalcNumeric());
  }

  ///
  String GetResultStr() {
    return IsHasOperator ? (GetResult() * 0.01).toStringAsFixed(2) : (Values[0] as CalcNumeric).toString();
  }

  ///
  int GetResult() {
    var op = ECalcOperator.None;
    int leftNum = (Values[0] as CalcNumeric).GetInteger();
    for (var i = 1; i < Values.length; i++) {
      if (i % 2 == 1) {
        op = (Values[i] as ECalcOperator);
      } else {
        leftNum = Calc(leftNum, op, (Values[i] as CalcNumeric).GetInteger());
      }
    }
    return leftNum;
  }

  static int Calc(int left, ECalcOperator op, int right) =>
      switch (op) { ECalcOperator.Add => left + right, ECalcOperator.Sub => left - right, ECalcOperator.None => throw UnimplementedError() };
}

class CalcNumeric {
  String IntegerStr;
  String? DecimalStr;

  CalcNumeric({this.IntegerStr = "", this.DecimalStr});

  @override
  String toString() {
    final integer = IntegerStr.isEmpty ? "0" : IntegerStr;
    if (DecimalStr == null) return integer;
    return "$integer.$DecimalStr";
  }

  int GetInteger() {
    var val = (int.tryParse(IntegerStr) ?? 0) * 100;
    if (DecimalStr?.isNotEmpty == true) {
      var decimal = int.parse(DecimalStr!);
      if (decimal < 10) decimal *= 10;
      val += decimal;
    }
    return val;
  }
}
