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
      Tags: (json['Tags'] as Map).map(
        (k, e) => MapEntry(
            k as String,
            (e as List<dynamic>)
                .map((e) =>
                    TagData.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList()),
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
      'Tags': instance.Tags,
      'MoreUsers': instance.MoreUsers,
    };
