import 'package:json_annotation/json_annotation.dart';
part "EntryData.g.dart";

/// 账本条目
@JsonSerializable()
class EntryData {
  ///
  final int LedgerId;

  ///
  final int TagId;

  ///
  final int IntMoney;

  ///
  final DateTime Date;

  ///
  final String Comment;

  String get MoneyStr => (IntMoney * 0.01).toString();

  const EntryData({required this.LedgerId, required this.TagId, required this.Date, this.IntMoney = 0, this.Comment = ""});
  EntryData CopyWith({int? LedgerId, int? TagId, DateTime? Date, int? IntMoney, String? Comment}) {
    return EntryData(
        LedgerId: LedgerId ?? this.LedgerId,
        TagId: TagId ?? this.TagId,
        Date: Date ?? this.Date,
        Comment: Comment ?? this.Comment,
        IntMoney: IntMoney ?? this.IntMoney);
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
