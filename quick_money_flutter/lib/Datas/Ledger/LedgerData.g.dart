// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LedgerData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LedgerData _$LedgerDataFromJson(Map json) => LedgerData(
      Id: (json['Id'] as num).toInt(),
      Type: (json['Type'] as num).toInt(),
      OwnerUser: (json['OwnerUser'] as num).toInt(),
      Name: json['Name'] as String? ?? "",
      Icon: json['Icon'] as String? ?? "",
      MoreUsers: (json['MoreUsers'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      IsHided: json['IsHided'] as bool? ?? false,
      TagGroups: (json['TagGroups'] as List<dynamic>)
          .map(
              (e) => TagGroupData.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      AllTags: (json['AllTags'] as Map).map(
        (k, e) => MapEntry(int.parse(k as String),
            TagData.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
    );

Map<String, dynamic> _$LedgerDataToJson(LedgerData instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Type': instance.Type,
      'OwnerUser': instance.OwnerUser,
      'Name': instance.Name,
      'Icon': instance.Icon,
      'IsHided': instance.IsHided,
      'TagGroups': instance.TagGroups,
      'AllTags': instance.AllTags.map((k, e) => MapEntry(k.toString(), e)),
      'MoreUsers': instance.MoreUsers,
    };
