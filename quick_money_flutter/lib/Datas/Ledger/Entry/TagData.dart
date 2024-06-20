import 'package:json_annotation/json_annotation.dart';

part 'TagData.g.dart';

@JsonSerializable()
class TagData {
  int Id;
  String Icon;
  String Name;
  TagData(this.Id, {this.Name = "未命名", this.Icon = ""});

  Map<String, dynamic> toJson() => _$TagDataToJson(this);
  factory TagData.fromJson(Map<String, dynamic> json) => _$TagDataFromJson(json);
}
