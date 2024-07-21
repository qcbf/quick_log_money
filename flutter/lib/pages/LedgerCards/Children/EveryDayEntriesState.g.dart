// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EveryDayEntriesState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EveryDayEntriesConfig _$EveryDayEntriesConfigFromJson(
        Map<String, dynamic> json) =>
    EveryDayEntriesConfig()
      ..DaysCount = (json['DaysCount'] as num).toInt()
      ..ContentHeight = (json['ContentHeight'] as num).toDouble();

Map<String, dynamic> _$EveryDayEntriesConfigToJson(
        EveryDayEntriesConfig instance) =>
    <String, dynamic>{
      'DaysCount': instance.DaysCount,
      'ContentHeight': instance.ContentHeight,
    };
