import 'package:json_annotation/json_annotation.dart';
part "EntryData.g.dart";

/// 账本条目
@JsonSerializable()
class EntryData {
  ///
  late int LedgerId;

  ///
  late int TagId;

  ///
  late int Money;

  ///
  DateTime Date = DateTime.now();

  ///
  late String Comment;

  EntryData();

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

  Map<String, dynamic> toJson() => _$EntryDataToJson(this);
  factory EntryData.fromJson(Map<String, dynamic> json) => _$EntryDataFromJson(json);
}
