// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EntryData.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EntryDataCWProxy {
  EntryData LedgerId(int LedgerId);

  EntryData TagId(int TagId);

  EntryData Date(DateTime Date);

  EntryData IntMoney(int IntMoney);

  EntryData Comment(String Comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EntryData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EntryData(...).copyWith(id: 12, name: "My name")
  /// ````
  EntryData call({
    int? LedgerId,
    int? TagId,
    DateTime? Date,
    int? IntMoney,
    String? Comment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEntryData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEntryData.copyWith.fieldName(...)`
class _$EntryDataCWProxyImpl implements _$EntryDataCWProxy {
  const _$EntryDataCWProxyImpl(this._value);

  final EntryData _value;

  @override
  EntryData LedgerId(int LedgerId) => this(LedgerId: LedgerId);

  @override
  EntryData TagId(int TagId) => this(TagId: TagId);

  @override
  EntryData Date(DateTime Date) => this(Date: Date);

  @override
  EntryData IntMoney(int IntMoney) => this(IntMoney: IntMoney);

  @override
  EntryData Comment(String Comment) => this(Comment: Comment);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EntryData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EntryData(...).copyWith(id: 12, name: "My name")
  /// ````
  EntryData call({
    Object? LedgerId = const $CopyWithPlaceholder(),
    Object? TagId = const $CopyWithPlaceholder(),
    Object? Date = const $CopyWithPlaceholder(),
    Object? IntMoney = const $CopyWithPlaceholder(),
    Object? Comment = const $CopyWithPlaceholder(),
  }) {
    return EntryData(
      LedgerId: LedgerId == const $CopyWithPlaceholder() || LedgerId == null
          ? _value.LedgerId
          // ignore: cast_nullable_to_non_nullable
          : LedgerId as int,
      TagId: TagId == const $CopyWithPlaceholder() || TagId == null
          ? _value.TagId
          // ignore: cast_nullable_to_non_nullable
          : TagId as int,
      Date: Date == const $CopyWithPlaceholder() || Date == null
          ? _value.Date
          // ignore: cast_nullable_to_non_nullable
          : Date as DateTime,
      IntMoney: IntMoney == const $CopyWithPlaceholder() || IntMoney == null
          ? _value.IntMoney
          // ignore: cast_nullable_to_non_nullable
          : IntMoney as int,
      Comment: Comment == const $CopyWithPlaceholder() || Comment == null
          ? _value.Comment
          // ignore: cast_nullable_to_non_nullable
          : Comment as String,
    );
  }
}

extension $EntryDataCopyWith on EntryData {
  /// Returns a callable class that can be used as follows: `instanceOfEntryData.copyWith(...)` or like so:`instanceOfEntryData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EntryDataCWProxy get copyWith => _$EntryDataCWProxyImpl(this);
}

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
