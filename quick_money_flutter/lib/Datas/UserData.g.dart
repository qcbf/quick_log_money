// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map json) => UserData(
      Id: (json['Id'] as num).toInt(),
      LedgerId: (json['LedgerId'] as num?)?.toInt() ?? 0,
      Name: json['Name'] as String? ?? "",
      RegisterDate: DateTime.parse(json['RegisterDate'] as String),
      Token: json['Token'] as String?,
      Icon: json['Icon'] as String?,
      VipExpiryDate: json['VipExpiryDate'] == null
          ? null
          : DateTime.parse(json['VipExpiryDate'] as String),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'Id': instance.Id,
      'LedgerId': instance.LedgerId,
      'Name': instance.Name,
      'Token': instance.Token,
      'Icon': instance.Icon,
      'VipExpiryDate': instance.VipExpiryDate?.toIso8601String(),
      'RegisterDate': instance.RegisterDate.toIso8601String(),
    };
