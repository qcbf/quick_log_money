// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagGroupData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagGroupData _$TagGroupDataFromJson(Map<String, dynamic> json) => TagGroupData(
      json['Name'] as String,
      (json['Tags'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    );

Map<String, dynamic> _$TagGroupDataToJson(TagGroupData instance) =>
    <String, dynamic>{
      'Name': instance.Name,
      'Tags': instance.Tags,
    };
