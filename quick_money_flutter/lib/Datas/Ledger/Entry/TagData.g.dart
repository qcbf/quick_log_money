// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagData _$TagDataFromJson(Map<String, dynamic> json) => TagData(
      (json['Id'] as num).toInt(),
      Name: json['Name'] as String? ?? "未命名",
      Icon: (json['Icon'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TagDataToJson(TagData instance) => <String, dynamic>{
      'Id': instance.Id,
      'Icon': instance.Icon,
      'Name': instance.Name,
    };
