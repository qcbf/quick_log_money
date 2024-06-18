import 'package:flutter/material.dart';

///
class EntryData {
  ///
  final int LedgerId;

  ///
  final int TagId;

  ///
  final int Money;

  ///
  late final DateTime Date;

  ///
  final String Comment;

  EntryData(this.Money, this.LedgerId, this.TagId, {DateTime? date, this.Comment = ""}) {
    Date = date ?? DateTime.now();
  }

  String GetMoneyString() {
    return (Money * 0.01).toString();
  }

  String GetDateTime() {
    var str = StringBuffer();
    var now = DateTime.now();
    if (now.year != Date.year) {
      str.write(now.year);
      str.write("年");
    }
    if (now.month != Date.month) {
      str.write(now.month);
      str.write("月");
    }
    if (now.day != Date.day) {
      str.write(now.day);
      str.write("日");
    }
    str.write(now.hour);
    str.write("时");
    str.write(now.minute);
    str.write("分");
    return str.toString();
  }

  String GetTagName() {
    return "晚餐";
  }

  String GetBookName() {
    return "默认账本";
  }
}

///
class EntryDataProvier with ChangeNotifier {
  EntryData? Data;

  ///
  bool IsCost = true;

  ///
  String MoneyIntegerStr = "";
  String? MoneyDecimalStr;

  String GetMoneyString() {
    final integer = MoneyIntegerStr.isEmpty ? "0" : MoneyIntegerStr;
    if (MoneyDecimalStr == null) return integer;
    return "$integer.$MoneyDecimalStr";
  }

  void Done() {
    Data = EntryData();
    Data.Money = (int.tryParse(MoneyIntegerStr) ?? 0) * 100;
    if (MoneyDecimalStr?.isNotEmpty == true) {
      Money += int.parse(MoneyDecimalStr!);
    }
  }

  void SetDirty() {
    notifyListeners();
  }
}
