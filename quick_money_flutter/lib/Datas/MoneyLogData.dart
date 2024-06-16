import 'package:flutter/material.dart';

class MoneyLogData with ChangeNotifier {
  ///
  bool IsCost = true;

  ///
  int Book = 0;

  ///
  int TagId = 0;

  ///
  double Money = 0;

  ///
  DateTime Date = DateTime.now();

  ///
  String? Comment;

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

  void SetDirty() {
    notifyListeners();
  }
}
