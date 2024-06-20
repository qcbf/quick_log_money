// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LedgerData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LedgerData _$LedgerDataFromJson(Map<String, dynamic> json) => LedgerData()
  ..Id = (json['Id'] as num).toInt()
  ..Type = (json['Type'] as num).toInt()
  ..OwnerUser = (json['OwnerUser'] as num).toInt()
  ..Name = json['Name'] as String?
  ..Icon = json['Icon'] as String?
  ..IsHided = json['IsHided'] as bool
  ..Entries = (json['Entries'] as List<dynamic>)
      .map((e) => EntryData.fromJson(e as Map<String, dynamic>))
      .toList()
  ..Tags = (json['Tags'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
        k,
        (e as List<dynamic>)
            .map((e) => TagData.fromJson(e as Map<String, dynamic>))
            .toList()),
  )
  ..MoreUsers = (json['MoreUsers'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList();

Map<String, dynamic> _$LedgerDataToJson(LedgerData instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Type': instance.Type,
      'OwnerUser': instance.OwnerUser,
      'Name': instance.Name,
      'Icon': instance.Icon,
      'IsHided': instance.IsHided,
      'Entries': instance.Entries,
      'Tags': instance.Tags,
      'MoreUsers': instance.MoreUsers,
    };
