// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EntryData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryData _$EntryDataFromJson(Map<String, dynamic> json) => EntryData()
  ..LedgerId = (json['LedgerId'] as num).toInt()
  ..TagId = (json['TagId'] as num).toInt()
  ..Money = (json['Money'] as num).toInt()
  ..Date = DateTime.parse(json['Date'] as String)
  ..Comment = json['Comment'] as String;

Map<String, dynamic> _$EntryDataToJson(EntryData instance) => <String, dynamic>{
      'LedgerId': instance.LedgerId,
      'TagId': instance.TagId,
      'Money': instance.Money,
      'Date': instance.Date.toIso8601String(),
      'Comment': instance.Comment,
    };
