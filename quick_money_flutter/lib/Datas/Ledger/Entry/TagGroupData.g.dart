// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagGroupData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagGroupData _$TagGroupDataFromJson(Map<String, dynamic> json) => TagGroupData(
      (json['Tags'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      Name: json['Name'] as String? ?? "",
    );

Map<String, dynamic> _$TagGroupDataToJson(TagGroupData instance) =>
    <String, dynamic>{
      'Name': instance.Name,
      'Tags': instance.Tags,
    };
