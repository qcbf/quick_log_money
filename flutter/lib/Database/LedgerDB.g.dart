// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LedgerDB.dart';

// ignore_for_file: type=lint
class $LedgerInfosTable extends LedgerInfos
    with TableInfo<$LedgerInfosTable, LedgerInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _IdMeta = const VerificationMeta('Id');
  @override
  late final GeneratedColumn<int> Id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _NameMeta = const VerificationMeta('Name');
  @override
  late final GeneratedColumn<String> Name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _IconMeta = const VerificationMeta('Icon');
  @override
  late final GeneratedColumn<String> Icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _OptionsMeta =
      const VerificationMeta('Options');
  @override
  late final GeneratedColumnWithTypeConverter<ELedgerOption?, String> Options =
      GeneratedColumn<String>('options', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ELedgerOption?>($LedgerInfosTable.$converterOptionsn);
  @override
  List<GeneratedColumn> get $columns => [Id, Name, Icon, Options];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_infos';
  @override
  VerificationContext validateIntegrity(Insertable<LedgerInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_IdMeta, Id.isAcceptableOrUnknown(data['id']!, _IdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _NameMeta, Name.isAcceptableOrUnknown(data['name']!, _NameMeta));
    } else if (isInserting) {
      context.missing(_NameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _IconMeta, Icon.isAcceptableOrUnknown(data['icon']!, _IconMeta));
    } else if (isInserting) {
      context.missing(_IconMeta);
    }
    context.handle(_OptionsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {Id};
  @override
  LedgerInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerInfo(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      Name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      Icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      Options: $LedgerInfosTable.$converterOptionsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options'])),
    );
  }

  @override
  $LedgerInfosTable createAlias(String alias) {
    return $LedgerInfosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ELedgerOption, String, String> $converterOptions =
      const EnumNameConverter<ELedgerOption>(ELedgerOption.values);
  static JsonTypeConverter2<ELedgerOption?, String?, String?>
      $converterOptionsn = JsonTypeConverter2.asNullable($converterOptions);
}

class LedgerInfo extends DataClass implements Insertable<LedgerInfo> {
  final int Id;
  final String Name;
  final String Icon;
  final ELedgerOption? Options;
  const LedgerInfo(
      {required this.Id, required this.Name, required this.Icon, this.Options});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['name'] = Variable<String>(Name);
    map['icon'] = Variable<String>(Icon);
    if (!nullToAbsent || Options != null) {
      map['options'] =
          Variable<String>($LedgerInfosTable.$converterOptionsn.toSql(Options));
    }
    return map;
  }

  LedgerInfosCompanion toCompanion(bool nullToAbsent) {
    return LedgerInfosCompanion(
      Id: Value(Id),
      Name: Value(Name),
      Icon: Value(Icon),
      Options: Options == null && nullToAbsent
          ? const Value.absent()
          : Value(Options),
    );
  }

  factory LedgerInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerInfo(
      Id: serializer.fromJson<int>(json['Id']),
      Name: serializer.fromJson<String>(json['Name']),
      Icon: serializer.fromJson<String>(json['Icon']),
      Options: $LedgerInfosTable.$converterOptionsn
          .fromJson(serializer.fromJson<String?>(json['Options'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'Name': serializer.toJson<String>(Name),
      'Icon': serializer.toJson<String>(Icon),
      'Options': serializer.toJson<String?>(
          $LedgerInfosTable.$converterOptionsn.toJson(Options)),
    };
  }

  LedgerInfo copyWith(
          {int? Id,
          String? Name,
          String? Icon,
          Value<ELedgerOption?> Options = const Value.absent()}) =>
      LedgerInfo(
        Id: Id ?? this.Id,
        Name: Name ?? this.Name,
        Icon: Icon ?? this.Icon,
        Options: Options.present ? Options.value : this.Options,
      );
  LedgerInfo copyWithCompanion(LedgerInfosCompanion data) {
    return LedgerInfo(
      Id: data.Id.present ? data.Id.value : this.Id,
      Name: data.Name.present ? data.Name.value : this.Name,
      Icon: data.Icon.present ? data.Icon.value : this.Icon,
      Options: data.Options.present ? data.Options.value : this.Options,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerInfo(')
          ..write('Id: $Id, ')
          ..write('Name: $Name, ')
          ..write('Icon: $Icon, ')
          ..write('Options: $Options')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, Name, Icon, Options);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerInfo &&
          other.Id == this.Id &&
          other.Name == this.Name &&
          other.Icon == this.Icon &&
          other.Options == this.Options);
}

class LedgerInfosCompanion extends UpdateCompanion<LedgerInfo> {
  final Value<int> Id;
  final Value<String> Name;
  final Value<String> Icon;
  final Value<ELedgerOption?> Options;
  const LedgerInfosCompanion({
    this.Id = const Value.absent(),
    this.Name = const Value.absent(),
    this.Icon = const Value.absent(),
    this.Options = const Value.absent(),
  });
  LedgerInfosCompanion.insert({
    this.Id = const Value.absent(),
    required String Name,
    required String Icon,
    this.Options = const Value.absent(),
  })  : Name = Value(Name),
        Icon = Value(Icon);
  static Insertable<LedgerInfo> custom({
    Expression<int>? Id,
    Expression<String>? Name,
    Expression<String>? Icon,
    Expression<String>? Options,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (Name != null) 'name': Name,
      if (Icon != null) 'icon': Icon,
      if (Options != null) 'options': Options,
    });
  }

  LedgerInfosCompanion copyWith(
      {Value<int>? Id,
      Value<String>? Name,
      Value<String>? Icon,
      Value<ELedgerOption?>? Options}) {
    return LedgerInfosCompanion(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      Icon: Icon ?? this.Icon,
      Options: Options ?? this.Options,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Id.present) {
      map['id'] = Variable<int>(Id.value);
    }
    if (Name.present) {
      map['name'] = Variable<String>(Name.value);
    }
    if (Icon.present) {
      map['icon'] = Variable<String>(Icon.value);
    }
    if (Options.present) {
      map['options'] = Variable<String>(
          $LedgerInfosTable.$converterOptionsn.toSql(Options.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerInfosCompanion(')
          ..write('Id: $Id, ')
          ..write('Name: $Name, ')
          ..write('Icon: $Icon, ')
          ..write('Options: $Options')
          ..write(')'))
        .toString();
  }
}

class $LedgerEntriesTable extends LedgerEntries
    with TableInfo<$LedgerEntriesTable, LedgerEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _IdMeta = const VerificationMeta('Id');
  @override
  late final GeneratedColumn<int> Id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _TagIdMeta = const VerificationMeta('TagId');
  @override
  late final GeneratedColumn<int> TagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _IntMoneyMeta =
      const VerificationMeta('IntMoney');
  @override
  late final GeneratedColumn<int> IntMoney = GeneratedColumn<int>(
      'int_money', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _DateMeta = const VerificationMeta('Date');
  @override
  late final GeneratedColumn<DateTime> Date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _CommentMeta =
      const VerificationMeta('Comment');
  @override
  late final GeneratedColumn<String> Comment = GeneratedColumn<String>(
      'comment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _LocationCountryMeta =
      const VerificationMeta('LocationCountry');
  @override
  late final GeneratedColumn<String> LocationCountry = GeneratedColumn<String>(
      'location_country', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _LocationCityMeta =
      const VerificationMeta('LocationCity');
  @override
  late final GeneratedColumn<String> LocationCity = GeneratedColumn<String>(
      'location_city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _LocationStreetMeta =
      const VerificationMeta('LocationStreet');
  @override
  late final GeneratedColumn<String> LocationStreet = GeneratedColumn<String>(
      'location_street', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        Id,
        TagId,
        IntMoney,
        Date,
        Comment,
        LocationCountry,
        LocationCity,
        LocationStreet
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_entries';
  @override
  VerificationContext validateIntegrity(Insertable<LedgerEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_IdMeta, Id.isAcceptableOrUnknown(data['id']!, _IdMeta));
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _TagIdMeta, TagId.isAcceptableOrUnknown(data['tag_id']!, _TagIdMeta));
    } else if (isInserting) {
      context.missing(_TagIdMeta);
    }
    if (data.containsKey('int_money')) {
      context.handle(_IntMoneyMeta,
          IntMoney.isAcceptableOrUnknown(data['int_money']!, _IntMoneyMeta));
    } else if (isInserting) {
      context.missing(_IntMoneyMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _DateMeta, Date.isAcceptableOrUnknown(data['date']!, _DateMeta));
    } else if (isInserting) {
      context.missing(_DateMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_CommentMeta,
          Comment.isAcceptableOrUnknown(data['comment']!, _CommentMeta));
    } else if (isInserting) {
      context.missing(_CommentMeta);
    }
    if (data.containsKey('location_country')) {
      context.handle(
          _LocationCountryMeta,
          LocationCountry.isAcceptableOrUnknown(
              data['location_country']!, _LocationCountryMeta));
    }
    if (data.containsKey('location_city')) {
      context.handle(
          _LocationCityMeta,
          LocationCity.isAcceptableOrUnknown(
              data['location_city']!, _LocationCityMeta));
    }
    if (data.containsKey('location_street')) {
      context.handle(
          _LocationStreetMeta,
          LocationStreet.isAcceptableOrUnknown(
              data['location_street']!, _LocationStreetMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {Id};
  @override
  LedgerEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerEntry(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      TagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      IntMoney: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}int_money'])!,
      Date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      Comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment'])!,
      LocationCountry: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}location_country']),
      LocationCity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_city']),
      LocationStreet: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_street']),
    );
  }

  @override
  $LedgerEntriesTable createAlias(String alias) {
    return $LedgerEntriesTable(attachedDatabase, alias);
  }
}

class LedgerEntry extends DataClass implements Insertable<LedgerEntry> {
  final int Id;
  final int TagId;
  final int IntMoney;
  final DateTime Date;
  final String Comment;
  final String? LocationCountry;
  final String? LocationCity;
  final String? LocationStreet;
  const LedgerEntry(
      {required this.Id,
      required this.TagId,
      required this.IntMoney,
      required this.Date,
      required this.Comment,
      this.LocationCountry,
      this.LocationCity,
      this.LocationStreet});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['tag_id'] = Variable<int>(TagId);
    map['int_money'] = Variable<int>(IntMoney);
    map['date'] = Variable<DateTime>(Date);
    map['comment'] = Variable<String>(Comment);
    if (!nullToAbsent || LocationCountry != null) {
      map['location_country'] = Variable<String>(LocationCountry);
    }
    if (!nullToAbsent || LocationCity != null) {
      map['location_city'] = Variable<String>(LocationCity);
    }
    if (!nullToAbsent || LocationStreet != null) {
      map['location_street'] = Variable<String>(LocationStreet);
    }
    return map;
  }

  LedgerEntriesCompanion toCompanion(bool nullToAbsent) {
    return LedgerEntriesCompanion(
      Id: Value(Id),
      TagId: Value(TagId),
      IntMoney: Value(IntMoney),
      Date: Value(Date),
      Comment: Value(Comment),
      LocationCountry: LocationCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(LocationCountry),
      LocationCity: LocationCity == null && nullToAbsent
          ? const Value.absent()
          : Value(LocationCity),
      LocationStreet: LocationStreet == null && nullToAbsent
          ? const Value.absent()
          : Value(LocationStreet),
    );
  }

  factory LedgerEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerEntry(
      Id: serializer.fromJson<int>(json['Id']),
      TagId: serializer.fromJson<int>(json['TagId']),
      IntMoney: serializer.fromJson<int>(json['IntMoney']),
      Date: serializer.fromJson<DateTime>(json['Date']),
      Comment: serializer.fromJson<String>(json['Comment']),
      LocationCountry: serializer.fromJson<String?>(json['LocationCountry']),
      LocationCity: serializer.fromJson<String?>(json['LocationCity']),
      LocationStreet: serializer.fromJson<String?>(json['LocationStreet']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'TagId': serializer.toJson<int>(TagId),
      'IntMoney': serializer.toJson<int>(IntMoney),
      'Date': serializer.toJson<DateTime>(Date),
      'Comment': serializer.toJson<String>(Comment),
      'LocationCountry': serializer.toJson<String?>(LocationCountry),
      'LocationCity': serializer.toJson<String?>(LocationCity),
      'LocationStreet': serializer.toJson<String?>(LocationStreet),
    };
  }

  LedgerEntry copyWith(
          {int? Id,
          int? TagId,
          int? IntMoney,
          DateTime? Date,
          String? Comment,
          Value<String?> LocationCountry = const Value.absent(),
          Value<String?> LocationCity = const Value.absent(),
          Value<String?> LocationStreet = const Value.absent()}) =>
      LedgerEntry(
        Id: Id ?? this.Id,
        TagId: TagId ?? this.TagId,
        IntMoney: IntMoney ?? this.IntMoney,
        Date: Date ?? this.Date,
        Comment: Comment ?? this.Comment,
        LocationCountry: LocationCountry.present
            ? LocationCountry.value
            : this.LocationCountry,
        LocationCity:
            LocationCity.present ? LocationCity.value : this.LocationCity,
        LocationStreet:
            LocationStreet.present ? LocationStreet.value : this.LocationStreet,
      );
  LedgerEntry copyWithCompanion(LedgerEntriesCompanion data) {
    return LedgerEntry(
      Id: data.Id.present ? data.Id.value : this.Id,
      TagId: data.TagId.present ? data.TagId.value : this.TagId,
      IntMoney: data.IntMoney.present ? data.IntMoney.value : this.IntMoney,
      Date: data.Date.present ? data.Date.value : this.Date,
      Comment: data.Comment.present ? data.Comment.value : this.Comment,
      LocationCountry: data.LocationCountry.present
          ? data.LocationCountry.value
          : this.LocationCountry,
      LocationCity: data.LocationCity.present
          ? data.LocationCity.value
          : this.LocationCity,
      LocationStreet: data.LocationStreet.present
          ? data.LocationStreet.value
          : this.LocationStreet,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntry(')
          ..write('Id: $Id, ')
          ..write('TagId: $TagId, ')
          ..write('IntMoney: $IntMoney, ')
          ..write('Date: $Date, ')
          ..write('Comment: $Comment, ')
          ..write('LocationCountry: $LocationCountry, ')
          ..write('LocationCity: $LocationCity, ')
          ..write('LocationStreet: $LocationStreet')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, TagId, IntMoney, Date, Comment,
      LocationCountry, LocationCity, LocationStreet);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerEntry &&
          other.Id == this.Id &&
          other.TagId == this.TagId &&
          other.IntMoney == this.IntMoney &&
          other.Date == this.Date &&
          other.Comment == this.Comment &&
          other.LocationCountry == this.LocationCountry &&
          other.LocationCity == this.LocationCity &&
          other.LocationStreet == this.LocationStreet);
}

class LedgerEntriesCompanion extends UpdateCompanion<LedgerEntry> {
  final Value<int> Id;
  final Value<int> TagId;
  final Value<int> IntMoney;
  final Value<DateTime> Date;
  final Value<String> Comment;
  final Value<String?> LocationCountry;
  final Value<String?> LocationCity;
  final Value<String?> LocationStreet;
  const LedgerEntriesCompanion({
    this.Id = const Value.absent(),
    this.TagId = const Value.absent(),
    this.IntMoney = const Value.absent(),
    this.Date = const Value.absent(),
    this.Comment = const Value.absent(),
    this.LocationCountry = const Value.absent(),
    this.LocationCity = const Value.absent(),
    this.LocationStreet = const Value.absent(),
  });
  LedgerEntriesCompanion.insert({
    this.Id = const Value.absent(),
    required int TagId,
    required int IntMoney,
    required DateTime Date,
    required String Comment,
    this.LocationCountry = const Value.absent(),
    this.LocationCity = const Value.absent(),
    this.LocationStreet = const Value.absent(),
  })  : TagId = Value(TagId),
        IntMoney = Value(IntMoney),
        Date = Value(Date),
        Comment = Value(Comment);
  static Insertable<LedgerEntry> custom({
    Expression<int>? Id,
    Expression<int>? TagId,
    Expression<int>? IntMoney,
    Expression<DateTime>? Date,
    Expression<String>? Comment,
    Expression<String>? LocationCountry,
    Expression<String>? LocationCity,
    Expression<String>? LocationStreet,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (TagId != null) 'tag_id': TagId,
      if (IntMoney != null) 'int_money': IntMoney,
      if (Date != null) 'date': Date,
      if (Comment != null) 'comment': Comment,
      if (LocationCountry != null) 'location_country': LocationCountry,
      if (LocationCity != null) 'location_city': LocationCity,
      if (LocationStreet != null) 'location_street': LocationStreet,
    });
  }

  LedgerEntriesCompanion copyWith(
      {Value<int>? Id,
      Value<int>? TagId,
      Value<int>? IntMoney,
      Value<DateTime>? Date,
      Value<String>? Comment,
      Value<String?>? LocationCountry,
      Value<String?>? LocationCity,
      Value<String?>? LocationStreet}) {
    return LedgerEntriesCompanion(
      Id: Id ?? this.Id,
      TagId: TagId ?? this.TagId,
      IntMoney: IntMoney ?? this.IntMoney,
      Date: Date ?? this.Date,
      Comment: Comment ?? this.Comment,
      LocationCountry: LocationCountry ?? this.LocationCountry,
      LocationCity: LocationCity ?? this.LocationCity,
      LocationStreet: LocationStreet ?? this.LocationStreet,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Id.present) {
      map['id'] = Variable<int>(Id.value);
    }
    if (TagId.present) {
      map['tag_id'] = Variable<int>(TagId.value);
    }
    if (IntMoney.present) {
      map['int_money'] = Variable<int>(IntMoney.value);
    }
    if (Date.present) {
      map['date'] = Variable<DateTime>(Date.value);
    }
    if (Comment.present) {
      map['comment'] = Variable<String>(Comment.value);
    }
    if (LocationCountry.present) {
      map['location_country'] = Variable<String>(LocationCountry.value);
    }
    if (LocationCity.present) {
      map['location_city'] = Variable<String>(LocationCity.value);
    }
    if (LocationStreet.present) {
      map['location_street'] = Variable<String>(LocationStreet.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntriesCompanion(')
          ..write('Id: $Id, ')
          ..write('TagId: $TagId, ')
          ..write('IntMoney: $IntMoney, ')
          ..write('Date: $Date, ')
          ..write('Comment: $Comment, ')
          ..write('LocationCountry: $LocationCountry, ')
          ..write('LocationCity: $LocationCity, ')
          ..write('LocationStreet: $LocationStreet')
          ..write(')'))
        .toString();
  }
}

class $LedgerTagsTable extends LedgerTags
    with TableInfo<$LedgerTagsTable, LedgerTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _IdMeta = const VerificationMeta('Id');
  @override
  late final GeneratedColumn<int> Id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _GroupMeta = const VerificationMeta('Group');
  @override
  late final GeneratedColumn<String> Group = GeneratedColumn<String>(
      'group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _NameMeta = const VerificationMeta('Name');
  @override
  late final GeneratedColumn<String> Name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _IconMeta = const VerificationMeta('Icon');
  @override
  late final GeneratedColumn<String> Icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _IsIncomeMeta =
      const VerificationMeta('IsIncome');
  @override
  late final GeneratedColumn<bool> IsIncome = GeneratedColumn<bool>(
      'is_income', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_income" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [Id, Group, Name, Icon, IsIncome];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_tags';
  @override
  VerificationContext validateIntegrity(Insertable<LedgerTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_IdMeta, Id.isAcceptableOrUnknown(data['id']!, _IdMeta));
    }
    if (data.containsKey('group')) {
      context.handle(
          _GroupMeta, Group.isAcceptableOrUnknown(data['group']!, _GroupMeta));
    } else if (isInserting) {
      context.missing(_GroupMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _NameMeta, Name.isAcceptableOrUnknown(data['name']!, _NameMeta));
    } else if (isInserting) {
      context.missing(_NameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _IconMeta, Icon.isAcceptableOrUnknown(data['icon']!, _IconMeta));
    } else if (isInserting) {
      context.missing(_IconMeta);
    }
    if (data.containsKey('is_income')) {
      context.handle(_IsIncomeMeta,
          IsIncome.isAcceptableOrUnknown(data['is_income']!, _IsIncomeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {Id};
  @override
  LedgerTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerTag(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      Group: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group'])!,
      Name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      Icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      IsIncome: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_income']),
    );
  }

  @override
  $LedgerTagsTable createAlias(String alias) {
    return $LedgerTagsTable(attachedDatabase, alias);
  }
}

class LedgerTag extends DataClass implements Insertable<LedgerTag> {
  final int Id;
  final String Group;
  final String Name;
  final String Icon;
  final bool? IsIncome;
  const LedgerTag(
      {required this.Id,
      required this.Group,
      required this.Name,
      required this.Icon,
      this.IsIncome});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['group'] = Variable<String>(Group);
    map['name'] = Variable<String>(Name);
    map['icon'] = Variable<String>(Icon);
    if (!nullToAbsent || IsIncome != null) {
      map['is_income'] = Variable<bool>(IsIncome);
    }
    return map;
  }

  LedgerTagsCompanion toCompanion(bool nullToAbsent) {
    return LedgerTagsCompanion(
      Id: Value(Id),
      Group: Value(Group),
      Name: Value(Name),
      Icon: Value(Icon),
      IsIncome: IsIncome == null && nullToAbsent
          ? const Value.absent()
          : Value(IsIncome),
    );
  }

  factory LedgerTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerTag(
      Id: serializer.fromJson<int>(json['Id']),
      Group: serializer.fromJson<String>(json['Group']),
      Name: serializer.fromJson<String>(json['Name']),
      Icon: serializer.fromJson<String>(json['Icon']),
      IsIncome: serializer.fromJson<bool?>(json['IsIncome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'Group': serializer.toJson<String>(Group),
      'Name': serializer.toJson<String>(Name),
      'Icon': serializer.toJson<String>(Icon),
      'IsIncome': serializer.toJson<bool?>(IsIncome),
    };
  }

  LedgerTag copyWith(
          {int? Id,
          String? Group,
          String? Name,
          String? Icon,
          Value<bool?> IsIncome = const Value.absent()}) =>
      LedgerTag(
        Id: Id ?? this.Id,
        Group: Group ?? this.Group,
        Name: Name ?? this.Name,
        Icon: Icon ?? this.Icon,
        IsIncome: IsIncome.present ? IsIncome.value : this.IsIncome,
      );
  LedgerTag copyWithCompanion(LedgerTagsCompanion data) {
    return LedgerTag(
      Id: data.Id.present ? data.Id.value : this.Id,
      Group: data.Group.present ? data.Group.value : this.Group,
      Name: data.Name.present ? data.Name.value : this.Name,
      Icon: data.Icon.present ? data.Icon.value : this.Icon,
      IsIncome: data.IsIncome.present ? data.IsIncome.value : this.IsIncome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerTag(')
          ..write('Id: $Id, ')
          ..write('Group: $Group, ')
          ..write('Name: $Name, ')
          ..write('Icon: $Icon, ')
          ..write('IsIncome: $IsIncome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, Group, Name, Icon, IsIncome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerTag &&
          other.Id == this.Id &&
          other.Group == this.Group &&
          other.Name == this.Name &&
          other.Icon == this.Icon &&
          other.IsIncome == this.IsIncome);
}

class LedgerTagsCompanion extends UpdateCompanion<LedgerTag> {
  final Value<int> Id;
  final Value<String> Group;
  final Value<String> Name;
  final Value<String> Icon;
  final Value<bool?> IsIncome;
  const LedgerTagsCompanion({
    this.Id = const Value.absent(),
    this.Group = const Value.absent(),
    this.Name = const Value.absent(),
    this.Icon = const Value.absent(),
    this.IsIncome = const Value.absent(),
  });
  LedgerTagsCompanion.insert({
    this.Id = const Value.absent(),
    required String Group,
    required String Name,
    required String Icon,
    this.IsIncome = const Value.absent(),
  })  : Group = Value(Group),
        Name = Value(Name),
        Icon = Value(Icon);
  static Insertable<LedgerTag> custom({
    Expression<int>? Id,
    Expression<String>? Group,
    Expression<String>? Name,
    Expression<String>? Icon,
    Expression<bool>? IsIncome,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (Group != null) 'group': Group,
      if (Name != null) 'name': Name,
      if (Icon != null) 'icon': Icon,
      if (IsIncome != null) 'is_income': IsIncome,
    });
  }

  LedgerTagsCompanion copyWith(
      {Value<int>? Id,
      Value<String>? Group,
      Value<String>? Name,
      Value<String>? Icon,
      Value<bool?>? IsIncome}) {
    return LedgerTagsCompanion(
      Id: Id ?? this.Id,
      Group: Group ?? this.Group,
      Name: Name ?? this.Name,
      Icon: Icon ?? this.Icon,
      IsIncome: IsIncome ?? this.IsIncome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Id.present) {
      map['id'] = Variable<int>(Id.value);
    }
    if (Group.present) {
      map['group'] = Variable<String>(Group.value);
    }
    if (Name.present) {
      map['name'] = Variable<String>(Name.value);
    }
    if (Icon.present) {
      map['icon'] = Variable<String>(Icon.value);
    }
    if (IsIncome.present) {
      map['is_income'] = Variable<bool>(IsIncome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerTagsCompanion(')
          ..write('Id: $Id, ')
          ..write('Group: $Group, ')
          ..write('Name: $Name, ')
          ..write('Icon: $Icon, ')
          ..write('IsIncome: $IsIncome')
          ..write(')'))
        .toString();
  }
}

class $LedgerOwnersTable extends LedgerOwners
    with TableInfo<$LedgerOwnersTable, LedgerOwner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerOwnersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _IdMeta = const VerificationMeta('Id');
  @override
  late final GeneratedColumn<int> Id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _UserIdMeta = const VerificationMeta('UserId');
  @override
  late final GeneratedColumn<int> UserId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _RoleMeta = const VerificationMeta('Role');
  @override
  late final GeneratedColumnWithTypeConverter<EOwnerRole, String> Role =
      GeneratedColumn<String>('role', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<EOwnerRole>($LedgerOwnersTable.$converterRole);
  @override
  List<GeneratedColumn> get $columns => [Id, UserId, Role];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_owners';
  @override
  VerificationContext validateIntegrity(Insertable<LedgerOwner> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_IdMeta, Id.isAcceptableOrUnknown(data['id']!, _IdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_UserIdMeta,
          UserId.isAcceptableOrUnknown(data['user_id']!, _UserIdMeta));
    } else if (isInserting) {
      context.missing(_UserIdMeta);
    }
    context.handle(_RoleMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {Id};
  @override
  LedgerOwner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerOwner(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      UserId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      Role: $LedgerOwnersTable.$converterRole.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!),
    );
  }

  @override
  $LedgerOwnersTable createAlias(String alias) {
    return $LedgerOwnersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EOwnerRole, String, String> $converterRole =
      const EnumNameConverter<EOwnerRole>(EOwnerRole.values);
}

class LedgerOwner extends DataClass implements Insertable<LedgerOwner> {
  final int Id;
  final int UserId;
  final EOwnerRole Role;
  const LedgerOwner(
      {required this.Id, required this.UserId, required this.Role});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['user_id'] = Variable<int>(UserId);
    {
      map['role'] =
          Variable<String>($LedgerOwnersTable.$converterRole.toSql(Role));
    }
    return map;
  }

  LedgerOwnersCompanion toCompanion(bool nullToAbsent) {
    return LedgerOwnersCompanion(
      Id: Value(Id),
      UserId: Value(UserId),
      Role: Value(Role),
    );
  }

  factory LedgerOwner.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerOwner(
      Id: serializer.fromJson<int>(json['Id']),
      UserId: serializer.fromJson<int>(json['UserId']),
      Role: $LedgerOwnersTable.$converterRole
          .fromJson(serializer.fromJson<String>(json['Role'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'UserId': serializer.toJson<int>(UserId),
      'Role': serializer
          .toJson<String>($LedgerOwnersTable.$converterRole.toJson(Role)),
    };
  }

  LedgerOwner copyWith({int? Id, int? UserId, EOwnerRole? Role}) => LedgerOwner(
        Id: Id ?? this.Id,
        UserId: UserId ?? this.UserId,
        Role: Role ?? this.Role,
      );
  LedgerOwner copyWithCompanion(LedgerOwnersCompanion data) {
    return LedgerOwner(
      Id: data.Id.present ? data.Id.value : this.Id,
      UserId: data.UserId.present ? data.UserId.value : this.UserId,
      Role: data.Role.present ? data.Role.value : this.Role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerOwner(')
          ..write('Id: $Id, ')
          ..write('UserId: $UserId, ')
          ..write('Role: $Role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, UserId, Role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerOwner &&
          other.Id == this.Id &&
          other.UserId == this.UserId &&
          other.Role == this.Role);
}

class LedgerOwnersCompanion extends UpdateCompanion<LedgerOwner> {
  final Value<int> Id;
  final Value<int> UserId;
  final Value<EOwnerRole> Role;
  const LedgerOwnersCompanion({
    this.Id = const Value.absent(),
    this.UserId = const Value.absent(),
    this.Role = const Value.absent(),
  });
  LedgerOwnersCompanion.insert({
    this.Id = const Value.absent(),
    required int UserId,
    required EOwnerRole Role,
  })  : UserId = Value(UserId),
        Role = Value(Role);
  static Insertable<LedgerOwner> custom({
    Expression<int>? Id,
    Expression<int>? UserId,
    Expression<String>? Role,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (UserId != null) 'user_id': UserId,
      if (Role != null) 'role': Role,
    });
  }

  LedgerOwnersCompanion copyWith(
      {Value<int>? Id, Value<int>? UserId, Value<EOwnerRole>? Role}) {
    return LedgerOwnersCompanion(
      Id: Id ?? this.Id,
      UserId: UserId ?? this.UserId,
      Role: Role ?? this.Role,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Id.present) {
      map['id'] = Variable<int>(Id.value);
    }
    if (UserId.present) {
      map['user_id'] = Variable<int>(UserId.value);
    }
    if (Role.present) {
      map['role'] =
          Variable<String>($LedgerOwnersTable.$converterRole.toSql(Role.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerOwnersCompanion(')
          ..write('Id: $Id, ')
          ..write('UserId: $UserId, ')
          ..write('Role: $Role')
          ..write(')'))
        .toString();
  }
}

abstract class _$LedgerDBHelper extends GeneratedDatabase {
  _$LedgerDBHelper(QueryExecutor e) : super(e);
  $LedgerDBHelperManager get managers => $LedgerDBHelperManager(this);
  late final $LedgerInfosTable ledgerInfos = $LedgerInfosTable(this);
  late final $LedgerEntriesTable ledgerEntries = $LedgerEntriesTable(this);
  late final $LedgerTagsTable ledgerTags = $LedgerTagsTable(this);
  late final $LedgerOwnersTable ledgerOwners = $LedgerOwnersTable(this);
  late final Index ledgerEntriesTagId = Index('LedgerEntries.TagId',
      'CREATE INDEX "LedgerEntries.TagId" ON ledger_entries (tag_id)');
  late final Index ledgerEntriesDate = Index('LedgerEntries.Date',
      'CREATE INDEX "LedgerEntries.Date" ON ledger_entries (date)');
  late final Index ledgerOwnersUserId = Index('LedgerOwners.UserId',
      'CREATE INDEX "LedgerOwners.UserId" ON ledger_owners (user_id)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        ledgerInfos,
        ledgerEntries,
        ledgerTags,
        ledgerOwners,
        ledgerEntriesTagId,
        ledgerEntriesDate,
        ledgerOwnersUserId
      ];
}

typedef $$LedgerInfosTableCreateCompanionBuilder = LedgerInfosCompanion
    Function({
  Value<int> Id,
  required String Name,
  required String Icon,
  Value<ELedgerOption?> Options,
});
typedef $$LedgerInfosTableUpdateCompanionBuilder = LedgerInfosCompanion
    Function({
  Value<int> Id,
  Value<String> Name,
  Value<String> Icon,
  Value<ELedgerOption?> Options,
});

class $$LedgerInfosTableTableManager extends RootTableManager<
    _$LedgerDBHelper,
    $LedgerInfosTable,
    LedgerInfo,
    $$LedgerInfosTableFilterComposer,
    $$LedgerInfosTableOrderingComposer,
    $$LedgerInfosTableCreateCompanionBuilder,
    $$LedgerInfosTableUpdateCompanionBuilder> {
  $$LedgerInfosTableTableManager(_$LedgerDBHelper db, $LedgerInfosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LedgerInfosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LedgerInfosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            Value<String> Name = const Value.absent(),
            Value<String> Icon = const Value.absent(),
            Value<ELedgerOption?> Options = const Value.absent(),
          }) =>
              LedgerInfosCompanion(
            Id: Id,
            Name: Name,
            Icon: Icon,
            Options: Options,
          ),
          createCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            required String Name,
            required String Icon,
            Value<ELedgerOption?> Options = const Value.absent(),
          }) =>
              LedgerInfosCompanion.insert(
            Id: Id,
            Name: Name,
            Icon: Icon,
            Options: Options,
          ),
        ));
}

class $$LedgerInfosTableFilterComposer
    extends FilterComposer<_$LedgerDBHelper, $LedgerInfosTable> {
  $$LedgerInfosTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get Name => $state.composableBuilder(
      column: $state.table.Name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get Icon => $state.composableBuilder(
      column: $state.table.Icon,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<ELedgerOption?, ELedgerOption, String>
      get Options => $state.composableBuilder(
          column: $state.table.Options,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$LedgerInfosTableOrderingComposer
    extends OrderingComposer<_$LedgerDBHelper, $LedgerInfosTable> {
  $$LedgerInfosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Name => $state.composableBuilder(
      column: $state.table.Name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Icon => $state.composableBuilder(
      column: $state.table.Icon,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Options => $state.composableBuilder(
      column: $state.table.Options,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LedgerEntriesTableCreateCompanionBuilder = LedgerEntriesCompanion
    Function({
  Value<int> Id,
  required int TagId,
  required int IntMoney,
  required DateTime Date,
  required String Comment,
  Value<String?> LocationCountry,
  Value<String?> LocationCity,
  Value<String?> LocationStreet,
});
typedef $$LedgerEntriesTableUpdateCompanionBuilder = LedgerEntriesCompanion
    Function({
  Value<int> Id,
  Value<int> TagId,
  Value<int> IntMoney,
  Value<DateTime> Date,
  Value<String> Comment,
  Value<String?> LocationCountry,
  Value<String?> LocationCity,
  Value<String?> LocationStreet,
});

class $$LedgerEntriesTableTableManager extends RootTableManager<
    _$LedgerDBHelper,
    $LedgerEntriesTable,
    LedgerEntry,
    $$LedgerEntriesTableFilterComposer,
    $$LedgerEntriesTableOrderingComposer,
    $$LedgerEntriesTableCreateCompanionBuilder,
    $$LedgerEntriesTableUpdateCompanionBuilder> {
  $$LedgerEntriesTableTableManager(
      _$LedgerDBHelper db, $LedgerEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LedgerEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LedgerEntriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            Value<int> TagId = const Value.absent(),
            Value<int> IntMoney = const Value.absent(),
            Value<DateTime> Date = const Value.absent(),
            Value<String> Comment = const Value.absent(),
            Value<String?> LocationCountry = const Value.absent(),
            Value<String?> LocationCity = const Value.absent(),
            Value<String?> LocationStreet = const Value.absent(),
          }) =>
              LedgerEntriesCompanion(
            Id: Id,
            TagId: TagId,
            IntMoney: IntMoney,
            Date: Date,
            Comment: Comment,
            LocationCountry: LocationCountry,
            LocationCity: LocationCity,
            LocationStreet: LocationStreet,
          ),
          createCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            required int TagId,
            required int IntMoney,
            required DateTime Date,
            required String Comment,
            Value<String?> LocationCountry = const Value.absent(),
            Value<String?> LocationCity = const Value.absent(),
            Value<String?> LocationStreet = const Value.absent(),
          }) =>
              LedgerEntriesCompanion.insert(
            Id: Id,
            TagId: TagId,
            IntMoney: IntMoney,
            Date: Date,
            Comment: Comment,
            LocationCountry: LocationCountry,
            LocationCity: LocationCity,
            LocationStreet: LocationStreet,
          ),
        ));
}

class $$LedgerEntriesTableFilterComposer
    extends FilterComposer<_$LedgerDBHelper, $LedgerEntriesTable> {
  $$LedgerEntriesTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get TagId => $state.composableBuilder(
      column: $state.table.TagId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get IntMoney => $state.composableBuilder(
      column: $state.table.IntMoney,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get Date => $state.composableBuilder(
      column: $state.table.Date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get Comment => $state.composableBuilder(
      column: $state.table.Comment,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get LocationCountry => $state.composableBuilder(
      column: $state.table.LocationCountry,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get LocationCity => $state.composableBuilder(
      column: $state.table.LocationCity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get LocationStreet => $state.composableBuilder(
      column: $state.table.LocationStreet,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LedgerEntriesTableOrderingComposer
    extends OrderingComposer<_$LedgerDBHelper, $LedgerEntriesTable> {
  $$LedgerEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get TagId => $state.composableBuilder(
      column: $state.table.TagId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get IntMoney => $state.composableBuilder(
      column: $state.table.IntMoney,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get Date => $state.composableBuilder(
      column: $state.table.Date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Comment => $state.composableBuilder(
      column: $state.table.Comment,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get LocationCountry => $state.composableBuilder(
      column: $state.table.LocationCountry,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get LocationCity => $state.composableBuilder(
      column: $state.table.LocationCity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get LocationStreet => $state.composableBuilder(
      column: $state.table.LocationStreet,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LedgerTagsTableCreateCompanionBuilder = LedgerTagsCompanion Function({
  Value<int> Id,
  required String Group,
  required String Name,
  required String Icon,
  Value<bool?> IsIncome,
});
typedef $$LedgerTagsTableUpdateCompanionBuilder = LedgerTagsCompanion Function({
  Value<int> Id,
  Value<String> Group,
  Value<String> Name,
  Value<String> Icon,
  Value<bool?> IsIncome,
});

class $$LedgerTagsTableTableManager extends RootTableManager<
    _$LedgerDBHelper,
    $LedgerTagsTable,
    LedgerTag,
    $$LedgerTagsTableFilterComposer,
    $$LedgerTagsTableOrderingComposer,
    $$LedgerTagsTableCreateCompanionBuilder,
    $$LedgerTagsTableUpdateCompanionBuilder> {
  $$LedgerTagsTableTableManager(_$LedgerDBHelper db, $LedgerTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LedgerTagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LedgerTagsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            Value<String> Group = const Value.absent(),
            Value<String> Name = const Value.absent(),
            Value<String> Icon = const Value.absent(),
            Value<bool?> IsIncome = const Value.absent(),
          }) =>
              LedgerTagsCompanion(
            Id: Id,
            Group: Group,
            Name: Name,
            Icon: Icon,
            IsIncome: IsIncome,
          ),
          createCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            required String Group,
            required String Name,
            required String Icon,
            Value<bool?> IsIncome = const Value.absent(),
          }) =>
              LedgerTagsCompanion.insert(
            Id: Id,
            Group: Group,
            Name: Name,
            Icon: Icon,
            IsIncome: IsIncome,
          ),
        ));
}

class $$LedgerTagsTableFilterComposer
    extends FilterComposer<_$LedgerDBHelper, $LedgerTagsTable> {
  $$LedgerTagsTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get Group => $state.composableBuilder(
      column: $state.table.Group,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get Name => $state.composableBuilder(
      column: $state.table.Name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get Icon => $state.composableBuilder(
      column: $state.table.Icon,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get IsIncome => $state.composableBuilder(
      column: $state.table.IsIncome,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LedgerTagsTableOrderingComposer
    extends OrderingComposer<_$LedgerDBHelper, $LedgerTagsTable> {
  $$LedgerTagsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Group => $state.composableBuilder(
      column: $state.table.Group,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Name => $state.composableBuilder(
      column: $state.table.Name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Icon => $state.composableBuilder(
      column: $state.table.Icon,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get IsIncome => $state.composableBuilder(
      column: $state.table.IsIncome,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LedgerOwnersTableCreateCompanionBuilder = LedgerOwnersCompanion
    Function({
  Value<int> Id,
  required int UserId,
  required EOwnerRole Role,
});
typedef $$LedgerOwnersTableUpdateCompanionBuilder = LedgerOwnersCompanion
    Function({
  Value<int> Id,
  Value<int> UserId,
  Value<EOwnerRole> Role,
});

class $$LedgerOwnersTableTableManager extends RootTableManager<
    _$LedgerDBHelper,
    $LedgerOwnersTable,
    LedgerOwner,
    $$LedgerOwnersTableFilterComposer,
    $$LedgerOwnersTableOrderingComposer,
    $$LedgerOwnersTableCreateCompanionBuilder,
    $$LedgerOwnersTableUpdateCompanionBuilder> {
  $$LedgerOwnersTableTableManager(_$LedgerDBHelper db, $LedgerOwnersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LedgerOwnersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LedgerOwnersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            Value<int> UserId = const Value.absent(),
            Value<EOwnerRole> Role = const Value.absent(),
          }) =>
              LedgerOwnersCompanion(
            Id: Id,
            UserId: UserId,
            Role: Role,
          ),
          createCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            required int UserId,
            required EOwnerRole Role,
          }) =>
              LedgerOwnersCompanion.insert(
            Id: Id,
            UserId: UserId,
            Role: Role,
          ),
        ));
}

class $$LedgerOwnersTableFilterComposer
    extends FilterComposer<_$LedgerDBHelper, $LedgerOwnersTable> {
  $$LedgerOwnersTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get UserId => $state.composableBuilder(
      column: $state.table.UserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<EOwnerRole, EOwnerRole, String> get Role =>
      $state.composableBuilder(
          column: $state.table.Role,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$LedgerOwnersTableOrderingComposer
    extends OrderingComposer<_$LedgerDBHelper, $LedgerOwnersTable> {
  $$LedgerOwnersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get UserId => $state.composableBuilder(
      column: $state.table.UserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Role => $state.composableBuilder(
      column: $state.table.Role,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $LedgerDBHelperManager {
  final _$LedgerDBHelper _db;
  $LedgerDBHelperManager(this._db);
  $$LedgerInfosTableTableManager get ledgerInfos =>
      $$LedgerInfosTableTableManager(_db, _db.ledgerInfos);
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db, _db.ledgerEntries);
  $$LedgerTagsTableTableManager get ledgerTags =>
      $$LedgerTagsTableTableManager(_db, _db.ledgerTags);
  $$LedgerOwnersTableTableManager get ledgerOwners =>
      $$LedgerOwnersTableTableManager(_db, _db.ledgerOwners);
}
