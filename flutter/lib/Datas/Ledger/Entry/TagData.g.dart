// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagData _$TagDataFromJson(Map<String, dynamic> json) => TagData(
      json['Name'] as String,
      (json['Icon'] as num).toInt(),
    );

Map<String, dynamic> _$TagDataToJson(TagData instance) => <String, dynamic>{
      'Icon': instance.Icon,
      'Name': instance.Name,
    };
