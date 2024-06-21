// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData()
  ..Id = (json['Id'] as num).toInt()
  ..Token = json['Token'] as String?
  ..Name = json['Name'] as String?
  ..Icon = json['Icon'] as String?
  ..VipExpiryDate = json['VipExpiryDate'] == null
      ? null
      : DateTime.parse(json['VipExpiryDate'] as String)
  ..RegisterDate = DateTime.parse(json['RegisterDate'] as String);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'Id': instance.Id,
      'Token': instance.Token,
      'Name': instance.Name,
      'Icon': instance.Icon,
      'VipExpiryDate': instance.VipExpiryDate?.toIso8601String(),
      'RegisterDate': instance.RegisterDate.toIso8601String(),
    };
