// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecentDaysCard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentDaysConfig _$RecentDaysConfigFromJson(Map<String, dynamic> json) =>
    RecentDaysConfig()
      ..Type = $enumDecode(_$ERecentDaysTypeEnumMap, json['Type']);

Map<String, dynamic> _$RecentDaysConfigToJson(RecentDaysConfig instance) =>
    <String, dynamic>{
      'Type': _$ERecentDaysTypeEnumMap[instance.Type]!,
    };

const _$ERecentDaysTypeEnumMap = {
  ERecentDaysType.CurrentWeek: 'CurrentWeek',
  ERecentDaysType.SevenDays: 'SevenDays',
  ERecentDaysType.Fourteen: 'Fourteen',
};
