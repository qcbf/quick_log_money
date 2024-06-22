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

  String GetTagName() {
    return "晚餐";
  }

  String GetBookName() {
    return "默认账本";
  }

  Map<String, dynamic> toJson() => _$EntryDataToJson(this);
  factory EntryData.fromJson(Map<String, dynamic> json) => _$EntryDataFromJson(json);
}
