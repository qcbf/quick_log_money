import 'package:json_annotation/json_annotation.dart';

part 'TagGroupData.g.dart';

@JsonSerializable()
class TagGroupData {
  final String Name;
  final List<int> Tags;
  const TagGroupData(this.Tags, {this.Name = ""});

  Map<String, dynamic> toJson() => _$TagGroupDataToJson(this);
  factory TagGroupData.fromJson(Map<String, dynamic> json) => _$TagGroupDataFromJson(json);
}
