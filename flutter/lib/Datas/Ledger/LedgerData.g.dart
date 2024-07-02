// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LedgerData.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LedgerDataCWProxy {
  LedgerData Id(int Id);

  LedgerData Type(int Type);

  LedgerData OwnerUser(int OwnerUser);

  LedgerData Name(String Name);

  LedgerData Icon(String Icon);

  LedgerData MoreUsers(List<int>? MoreUsers);

  LedgerData IsHided(bool IsHided);

  LedgerData TagGroups(List<TagGroupData> TagGroups);

  LedgerData AllTags(Map<int, TagData> AllTags);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LedgerData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LedgerData(...).copyWith(id: 12, name: "My name")
  /// ````
  LedgerData call({
    int? Id,
    int? Type,
    int? OwnerUser,
    String? Name,
    String? Icon,
    List<int>? MoreUsers,
    bool? IsHided,
    List<TagGroupData>? TagGroups,
    Map<int, TagData>? AllTags,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLedgerData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLedgerData.copyWith.fieldName(...)`
class _$LedgerDataCWProxyImpl implements _$LedgerDataCWProxy {
  const _$LedgerDataCWProxyImpl(this._value);

  final LedgerData _value;

  @override
  LedgerData Id(int Id) => this(Id: Id);

  @override
  LedgerData Type(int Type) => this(Type: Type);

  @override
  LedgerData OwnerUser(int OwnerUser) => this(OwnerUser: OwnerUser);

  @override
  LedgerData Name(String Name) => this(Name: Name);

  @override
  LedgerData Icon(String Icon) => this(Icon: Icon);

  @override
  LedgerData MoreUsers(List<int>? MoreUsers) => this(MoreUsers: MoreUsers);

  @override
  LedgerData IsHided(bool IsHided) => this(IsHided: IsHided);

  @override
  LedgerData TagGroups(List<TagGroupData> TagGroups) =>
      this(TagGroups: TagGroups);

  @override
  LedgerData AllTags(Map<int, TagData> AllTags) => this(AllTags: AllTags);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LedgerData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LedgerData(...).copyWith(id: 12, name: "My name")
  /// ````
  LedgerData call({
    Object? Id = const $CopyWithPlaceholder(),
    Object? Type = const $CopyWithPlaceholder(),
    Object? OwnerUser = const $CopyWithPlaceholder(),
    Object? Name = const $CopyWithPlaceholder(),
    Object? Icon = const $CopyWithPlaceholder(),
    Object? MoreUsers = const $CopyWithPlaceholder(),
    Object? IsHided = const $CopyWithPlaceholder(),
    Object? TagGroups = const $CopyWithPlaceholder(),
    Object? AllTags = const $CopyWithPlaceholder(),
  }) {
    return LedgerData(
      Id: Id == const $CopyWithPlaceholder() || Id == null
          ? _value.Id
          // ignore: cast_nullable_to_non_nullable
          : Id as int,
      Type: Type == const $CopyWithPlaceholder() || Type == null
          ? _value.Type
          // ignore: cast_nullable_to_non_nullable
          : Type as int,
      OwnerUser: OwnerUser == const $CopyWithPlaceholder() || OwnerUser == null
          ? _value.OwnerUser
          // ignore: cast_nullable_to_non_nullable
          : OwnerUser as int,
      Name: Name == const $CopyWithPlaceholder() || Name == null
          ? _value.Name
          // ignore: cast_nullable_to_non_nullable
          : Name as String,
      Icon: Icon == const $CopyWithPlaceholder() || Icon == null
          ? _value.Icon
          // ignore: cast_nullable_to_non_nullable
          : Icon as String,
      MoreUsers: MoreUsers == const $CopyWithPlaceholder()
          ? _value.MoreUsers
          // ignore: cast_nullable_to_non_nullable
          : MoreUsers as List<int>?,
      IsHided: IsHided == const $CopyWithPlaceholder() || IsHided == null
          ? _value.IsHided
          // ignore: cast_nullable_to_non_nullable
          : IsHided as bool,
      TagGroups: TagGroups == const $CopyWithPlaceholder() || TagGroups == null
          ? _value.TagGroups
          // ignore: cast_nullable_to_non_nullable
          : TagGroups as List<TagGroupData>,
      AllTags: AllTags == const $CopyWithPlaceholder() || AllTags == null
          ? _value.AllTags
          // ignore: cast_nullable_to_non_nullable
          : AllTags as Map<int, TagData>,
    );
  }
}

extension $LedgerDataCopyWith on LedgerData {
  /// Returns a callable class that can be used as follows: `instanceOfLedgerData.copyWith(...)` or like so:`instanceOfLedgerData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LedgerDataCWProxy get copyWith => _$LedgerDataCWProxyImpl(this);
}

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
      TagGroups: (json['TagGroups'] as List<dynamic>)
          .map(
              (e) => TagGroupData.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      AllTags: (json['AllTags'] as Map).map(
        (k, e) => MapEntry(int.parse(k as String),
            TagData.fromJson(Map<String, dynamic>.from(e as Map))),
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
      'TagGroups': instance.TagGroups,
      'AllTags': instance.AllTags.map((k, e) => MapEntry(k.toString(), e)),
      'MoreUsers': instance.MoreUsers,
    };
