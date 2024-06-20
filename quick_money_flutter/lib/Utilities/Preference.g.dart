// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preference _$PreferenceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Preference',
      json,
      ($checkedConvert) {
        final val = Preference();
        $checkedConvert(
            'IsFirstPageIsRecord', (v) => val.IsFirstPageIsRecord = v as bool);
        return val;
      },
    );

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'IsFirstPageIsRecord': instance.IsFirstPageIsRecord,
    };
