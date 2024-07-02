// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserData.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserDataCWProxy {
  UserData Id(int Id);

  UserData LedgerId(int LedgerId);

  UserData Name(String Name);

  UserData RegisterDate(DateTime RegisterDate);

  UserData Token(String? Token);

  UserData Icon(String? Icon);

  UserData VipExpiryDate(DateTime? VipExpiryDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserData(...).copyWith(id: 12, name: "My name")
  /// ````
  UserData call({
    int? Id,
    int? LedgerId,
    String? Name,
    DateTime? RegisterDate,
    String? Token,
    String? Icon,
    DateTime? VipExpiryDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserData.copyWith.fieldName(...)`
class _$UserDataCWProxyImpl implements _$UserDataCWProxy {
  const _$UserDataCWProxyImpl(this._value);

  final UserData _value;

  @override
  UserData Id(int Id) => this(Id: Id);

  @override
  UserData LedgerId(int LedgerId) => this(LedgerId: LedgerId);

  @override
  UserData Name(String Name) => this(Name: Name);

  @override
  UserData RegisterDate(DateTime RegisterDate) =>
      this(RegisterDate: RegisterDate);

  @override
  UserData Token(String? Token) => this(Token: Token);

  @override
  UserData Icon(String? Icon) => this(Icon: Icon);

  @override
  UserData VipExpiryDate(DateTime? VipExpiryDate) =>
      this(VipExpiryDate: VipExpiryDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserData(...).copyWith(id: 12, name: "My name")
  /// ````
  UserData call({
    Object? Id = const $CopyWithPlaceholder(),
    Object? LedgerId = const $CopyWithPlaceholder(),
    Object? Name = const $CopyWithPlaceholder(),
    Object? RegisterDate = const $CopyWithPlaceholder(),
    Object? Token = const $CopyWithPlaceholder(),
    Object? Icon = const $CopyWithPlaceholder(),
    Object? VipExpiryDate = const $CopyWithPlaceholder(),
  }) {
    return UserData(
      Id: Id == const $CopyWithPlaceholder() || Id == null
          ? _value.Id
          // ignore: cast_nullable_to_non_nullable
          : Id as int,
      LedgerId: LedgerId == const $CopyWithPlaceholder() || LedgerId == null
          ? _value.LedgerId
          // ignore: cast_nullable_to_non_nullable
          : LedgerId as int,
      Name: Name == const $CopyWithPlaceholder() || Name == null
          ? _value.Name
          // ignore: cast_nullable_to_non_nullable
          : Name as String,
      RegisterDate:
          RegisterDate == const $CopyWithPlaceholder() || RegisterDate == null
              ? _value.RegisterDate
              // ignore: cast_nullable_to_non_nullable
              : RegisterDate as DateTime,
      Token: Token == const $CopyWithPlaceholder()
          ? _value.Token
          // ignore: cast_nullable_to_non_nullable
          : Token as String?,
      Icon: Icon == const $CopyWithPlaceholder()
          ? _value.Icon
          // ignore: cast_nullable_to_non_nullable
          : Icon as String?,
      VipExpiryDate: VipExpiryDate == const $CopyWithPlaceholder()
          ? _value.VipExpiryDate
          // ignore: cast_nullable_to_non_nullable
          : VipExpiryDate as DateTime?,
    );
  }
}

extension $UserDataCopyWith on UserData {
  /// Returns a callable class that can be used as follows: `instanceOfUserData.copyWith(...)` or like so:`instanceOfUserData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserDataCWProxy get copyWith => _$UserDataCWProxyImpl(this);
}

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
