import 'package:json_annotation/json_annotation.dart';

part 'TagData.g.dart';

@JsonSerializable()
class TagData {
  final int Id;
  final int Icon;
  final String Name;
  const TagData(this.Id, {this.Name = "未命名", this.Icon = 0});

  Map<String, dynamic> toJson() => _$TagDataToJson(this);
  factory TagData.fromJson(Map<String, dynamic> json) => _$TagDataFromJson(json);
}
