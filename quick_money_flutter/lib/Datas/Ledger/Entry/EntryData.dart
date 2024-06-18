import 'package:flutter/material.dart';

class EntryData with ChangeNotifier {
  ///
  int Book = 0;

  ///
  int TagId = 0;

  ///
  int Money = 0;

  ///
  DateTime Date = DateTime.now();

  ///
  String? Comment;

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

  void SetDirty() {
    notifyListeners();
  }
}
