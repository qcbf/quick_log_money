// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EntryData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryData _$EntryDataFromJson(Map<String, dynamic> json) => EntryData(
      LedgerId: (json['LedgerId'] as num).toInt(),
      TagId: (json['TagId'] as num).toInt(),
      Date: DateTime.parse(json['Date'] as String),
      IntMoney: (json['IntMoney'] as num?)?.toInt() ?? 0,
      Comment: json['Comment'] as String? ?? "",
    );

Map<String, dynamic> _$EntryDataToJson(EntryData instance) => <String, dynamic>{
      'LedgerId': instance.LedgerId,
      'TagId': instance.TagId,
      'IntMoney': instance.IntMoney,
      'Date': instance.Date.toIso8601String(),
      'Comment': instance.Comment,
    };
