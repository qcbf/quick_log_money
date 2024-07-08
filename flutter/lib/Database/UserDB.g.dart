// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDB.dart';

// ignore_for_file: type=lint
class $UserInfosTable extends UserInfos
    with TableInfo<$UserInfosTable, UserInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _IdMeta = const VerificationMeta('Id');
  @override
  late final GeneratedColumn<int> Id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _LedgerIdMeta =
      const VerificationMeta('LedgerId');
  @override
  late final GeneratedColumn<int> LedgerId = GeneratedColumn<int>(
      'ledger_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _LedgerRecentCountMeta =
      const VerificationMeta('LedgerRecentCount');
  @override
  late final GeneratedColumn<int> LedgerRecentCount = GeneratedColumn<int>(
      'ledger_recent_count', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(8));
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
  static const VerificationMeta _TokenMeta = const VerificationMeta('Token');
  @override
  late final GeneratedColumn<String> Token = GeneratedColumn<String>(
      'token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _VipExpiryDateMeta =
      const VerificationMeta('VipExpiryDate');
  @override
  late final GeneratedColumn<DateTime> VipExpiryDate =
      GeneratedColumn<DateTime>('vip_expiry_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _RegisterDateMeta =
      const VerificationMeta('RegisterDate');
  @override
  late final GeneratedColumn<DateTime> RegisterDate = GeneratedColumn<DateTime>(
      'register_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  @override
  List<GeneratedColumn> get $columns => [
        Id,
        LedgerId,
        LedgerRecentCount,
        Name,
        Icon,
        Token,
        VipExpiryDate,
        RegisterDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_infos';
  @override
  VerificationContext validateIntegrity(Insertable<UserInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_IdMeta, Id.isAcceptableOrUnknown(data['id']!, _IdMeta));
    }
    if (data.containsKey('ledger_id')) {
      context.handle(_LedgerIdMeta,
          LedgerId.isAcceptableOrUnknown(data['ledger_id']!, _LedgerIdMeta));
    } else if (isInserting) {
      context.missing(_LedgerIdMeta);
    }
    if (data.containsKey('ledger_recent_count')) {
      context.handle(
          _LedgerRecentCountMeta,
          LedgerRecentCount.isAcceptableOrUnknown(
              data['ledger_recent_count']!, _LedgerRecentCountMeta));
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
    if (data.containsKey('token')) {
      context.handle(
          _TokenMeta, Token.isAcceptableOrUnknown(data['token']!, _TokenMeta));
    }
    if (data.containsKey('vip_expiry_date')) {
      context.handle(
          _VipExpiryDateMeta,
          VipExpiryDate.isAcceptableOrUnknown(
              data['vip_expiry_date']!, _VipExpiryDateMeta));
    }
    if (data.containsKey('register_date')) {
      context.handle(
          _RegisterDateMeta,
          RegisterDate.isAcceptableOrUnknown(
              data['register_date']!, _RegisterDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {Id};
  @override
  UserInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserInfo(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      LedgerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ledger_id'])!,
      LedgerRecentCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}ledger_recent_count']),
      Name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      Icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      Token: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}token']),
      VipExpiryDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}vip_expiry_date']),
      RegisterDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}register_date'])!,
    );
  }

  @override
  $UserInfosTable createAlias(String alias) {
    return $UserInfosTable(attachedDatabase, alias);
  }
}

class UserInfo extends DataClass implements Insertable<UserInfo> {
  final int Id;
  final int LedgerId;
  final int? LedgerRecentCount;
  final String Name;
  final String Icon;
  final String? Token;
  final DateTime? VipExpiryDate;
  final DateTime RegisterDate;
  const UserInfo(
      {required this.Id,
      required this.LedgerId,
      this.LedgerRecentCount,
      required this.Name,
      required this.Icon,
      this.Token,
      this.VipExpiryDate,
      required this.RegisterDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['ledger_id'] = Variable<int>(LedgerId);
    if (!nullToAbsent || LedgerRecentCount != null) {
      map['ledger_recent_count'] = Variable<int>(LedgerRecentCount);
    }
    map['name'] = Variable<String>(Name);
    map['icon'] = Variable<String>(Icon);
    if (!nullToAbsent || Token != null) {
      map['token'] = Variable<String>(Token);
    }
    if (!nullToAbsent || VipExpiryDate != null) {
      map['vip_expiry_date'] = Variable<DateTime>(VipExpiryDate);
    }
    map['register_date'] = Variable<DateTime>(RegisterDate);
    return map;
  }

  UserInfosCompanion toCompanion(bool nullToAbsent) {
    return UserInfosCompanion(
      Id: Value(Id),
      LedgerId: Value(LedgerId),
      LedgerRecentCount: LedgerRecentCount == null && nullToAbsent
          ? const Value.absent()
          : Value(LedgerRecentCount),
      Name: Value(Name),
      Icon: Value(Icon),
      Token:
          Token == null && nullToAbsent ? const Value.absent() : Value(Token),
      VipExpiryDate: VipExpiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(VipExpiryDate),
      RegisterDate: Value(RegisterDate),
    );
  }

  factory UserInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserInfo(
      Id: serializer.fromJson<int>(json['Id']),
      LedgerId: serializer.fromJson<int>(json['LedgerId']),
      LedgerRecentCount: serializer.fromJson<int?>(json['LedgerRecentCount']),
      Name: serializer.fromJson<String>(json['Name']),
      Icon: serializer.fromJson<String>(json['Icon']),
      Token: serializer.fromJson<String?>(json['Token']),
      VipExpiryDate: serializer.fromJson<DateTime?>(json['VipExpiryDate']),
      RegisterDate: serializer.fromJson<DateTime>(json['RegisterDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'LedgerId': serializer.toJson<int>(LedgerId),
      'LedgerRecentCount': serializer.toJson<int?>(LedgerRecentCount),
      'Name': serializer.toJson<String>(Name),
      'Icon': serializer.toJson<String>(Icon),
      'Token': serializer.toJson<String?>(Token),
      'VipExpiryDate': serializer.toJson<DateTime?>(VipExpiryDate),
      'RegisterDate': serializer.toJson<DateTime>(RegisterDate),
    };
  }

  UserInfo copyWith(
          {int? Id,
          int? LedgerId,
          Value<int?> LedgerRecentCount = const Value.absent(),
          String? Name,
          String? Icon,
          Value<String?> Token = const Value.absent(),
          Value<DateTime?> VipExpiryDate = const Value.absent(),
          DateTime? RegisterDate}) =>
      UserInfo(
        Id: Id ?? this.Id,
        LedgerId: LedgerId ?? this.LedgerId,
        LedgerRecentCount: LedgerRecentCount.present
            ? LedgerRecentCount.value
            : this.LedgerRecentCount,
        Name: Name ?? this.Name,
        Icon: Icon ?? this.Icon,
        Token: Token.present ? Token.value : this.Token,
        VipExpiryDate:
            VipExpiryDate.present ? VipExpiryDate.value : this.VipExpiryDate,
        RegisterDate: RegisterDate ?? this.RegisterDate,
      );
  @override
  String toString() {
    return (StringBuffer('UserInfo(')
          ..write('Id: $Id, ')
          ..write('LedgerId: $LedgerId, ')
          ..write('LedgerRecentCount: $LedgerRecentCount, ')
          ..write('Name: $Name, ')
          ..write('Icon: $Icon, ')
          ..write('Token: $Token, ')
          ..write('VipExpiryDate: $VipExpiryDate, ')
          ..write('RegisterDate: $RegisterDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, LedgerId, LedgerRecentCount, Name, Icon,
      Token, VipExpiryDate, RegisterDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserInfo &&
          other.Id == this.Id &&
          other.LedgerId == this.LedgerId &&
          other.LedgerRecentCount == this.LedgerRecentCount &&
          other.Name == this.Name &&
          other.Icon == this.Icon &&
          other.Token == this.Token &&
          other.VipExpiryDate == this.VipExpiryDate &&
          other.RegisterDate == this.RegisterDate);
}

class UserInfosCompanion extends UpdateCompanion<UserInfo> {
  final Value<int> Id;
  final Value<int> LedgerId;
  final Value<int?> LedgerRecentCount;
  final Value<String> Name;
  final Value<String> Icon;
  final Value<String?> Token;
  final Value<DateTime?> VipExpiryDate;
  final Value<DateTime> RegisterDate;
  const UserInfosCompanion({
    this.Id = const Value.absent(),
    this.LedgerId = const Value.absent(),
    this.LedgerRecentCount = const Value.absent(),
    this.Name = const Value.absent(),
    this.Icon = const Value.absent(),
    this.Token = const Value.absent(),
    this.VipExpiryDate = const Value.absent(),
    this.RegisterDate = const Value.absent(),
  });
  UserInfosCompanion.insert({
    this.Id = const Value.absent(),
    required int LedgerId,
    this.LedgerRecentCount = const Value.absent(),
    required String Name,
    required String Icon,
    this.Token = const Value.absent(),
    this.VipExpiryDate = const Value.absent(),
    this.RegisterDate = const Value.absent(),
  })  : LedgerId = Value(LedgerId),
        Name = Value(Name),
        Icon = Value(Icon);
  static Insertable<UserInfo> custom({
    Expression<int>? Id,
    Expression<int>? LedgerId,
    Expression<int>? LedgerRecentCount,
    Expression<String>? Name,
    Expression<String>? Icon,
    Expression<String>? Token,
    Expression<DateTime>? VipExpiryDate,
    Expression<DateTime>? RegisterDate,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (LedgerId != null) 'ledger_id': LedgerId,
      if (LedgerRecentCount != null) 'ledger_recent_count': LedgerRecentCount,
      if (Name != null) 'name': Name,
      if (Icon != null) 'icon': Icon,
      if (Token != null) 'token': Token,
      if (VipExpiryDate != null) 'vip_expiry_date': VipExpiryDate,
      if (RegisterDate != null) 'register_date': RegisterDate,
    });
  }

  UserInfosCompanion copyWith(
      {Value<int>? Id,
      Value<int>? LedgerId,
      Value<int?>? LedgerRecentCount,
      Value<String>? Name,
      Value<String>? Icon,
      Value<String?>? Token,
      Value<DateTime?>? VipExpiryDate,
      Value<DateTime>? RegisterDate}) {
    return UserInfosCompanion(
      Id: Id ?? this.Id,
      LedgerId: LedgerId ?? this.LedgerId,
      LedgerRecentCount: LedgerRecentCount ?? this.LedgerRecentCount,
      Name: Name ?? this.Name,
      Icon: Icon ?? this.Icon,
      Token: Token ?? this.Token,
      VipExpiryDate: VipExpiryDate ?? this.VipExpiryDate,
      RegisterDate: RegisterDate ?? this.RegisterDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Id.present) {
      map['id'] = Variable<int>(Id.value);
    }
    if (LedgerId.present) {
      map['ledger_id'] = Variable<int>(LedgerId.value);
    }
    if (LedgerRecentCount.present) {
      map['ledger_recent_count'] = Variable<int>(LedgerRecentCount.value);
    }
    if (Name.present) {
      map['name'] = Variable<String>(Name.value);
    }
    if (Icon.present) {
      map['icon'] = Variable<String>(Icon.value);
    }
    if (Token.present) {
      map['token'] = Variable<String>(Token.value);
    }
    if (VipExpiryDate.present) {
      map['vip_expiry_date'] = Variable<DateTime>(VipExpiryDate.value);
    }
    if (RegisterDate.present) {
      map['register_date'] = Variable<DateTime>(RegisterDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserInfosCompanion(')
          ..write('Id: $Id, ')
          ..write('LedgerId: $LedgerId, ')
          ..write('LedgerRecentCount: $LedgerRecentCount, ')
          ..write('Name: $Name, ')
          ..write('Icon: $Icon, ')
          ..write('Token: $Token, ')
          ..write('VipExpiryDate: $VipExpiryDate, ')
          ..write('RegisterDate: $RegisterDate')
          ..write(')'))
        .toString();
  }
}

class $UserLedgerRecentTagsTable extends UserLedgerRecentTags
    with TableInfo<$UserLedgerRecentTagsTable, UserLedgerRecentTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserLedgerRecentTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _IdMeta = const VerificationMeta('Id');
  @override
  late final GeneratedColumn<int> Id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _UidMeta = const VerificationMeta('Uid');
  @override
  late final GeneratedColumn<int> Uid = GeneratedColumn<int>(
      'uid', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _TagIdMeta = const VerificationMeta('TagId');
  @override
  late final GeneratedColumn<int> TagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [Id, Uid, TagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_ledger_recent_tags';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserLedgerRecentTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_IdMeta, Id.isAcceptableOrUnknown(data['id']!, _IdMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
          _UidMeta, Uid.isAcceptableOrUnknown(data['uid']!, _UidMeta));
    } else if (isInserting) {
      context.missing(_UidMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _TagIdMeta, TagId.isAcceptableOrUnknown(data['tag_id']!, _TagIdMeta));
    } else if (isInserting) {
      context.missing(_TagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {Id};
  @override
  UserLedgerRecentTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserLedgerRecentTag(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      Uid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uid'])!,
      TagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $UserLedgerRecentTagsTable createAlias(String alias) {
    return $UserLedgerRecentTagsTable(attachedDatabase, alias);
  }
}

class UserLedgerRecentTag extends DataClass
    implements Insertable<UserLedgerRecentTag> {
  final int Id;
  final int Uid;
  final int TagId;
  const UserLedgerRecentTag(
      {required this.Id, required this.Uid, required this.TagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['uid'] = Variable<int>(Uid);
    map['tag_id'] = Variable<int>(TagId);
    return map;
  }

  UserLedgerRecentTagsCompanion toCompanion(bool nullToAbsent) {
    return UserLedgerRecentTagsCompanion(
      Id: Value(Id),
      Uid: Value(Uid),
      TagId: Value(TagId),
    );
  }

  factory UserLedgerRecentTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserLedgerRecentTag(
      Id: serializer.fromJson<int>(json['Id']),
      Uid: serializer.fromJson<int>(json['Uid']),
      TagId: serializer.fromJson<int>(json['TagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'Uid': serializer.toJson<int>(Uid),
      'TagId': serializer.toJson<int>(TagId),
    };
  }

  UserLedgerRecentTag copyWith({int? Id, int? Uid, int? TagId}) =>
      UserLedgerRecentTag(
        Id: Id ?? this.Id,
        Uid: Uid ?? this.Uid,
        TagId: TagId ?? this.TagId,
      );
  @override
  String toString() {
    return (StringBuffer('UserLedgerRecentTag(')
          ..write('Id: $Id, ')
          ..write('Uid: $Uid, ')
          ..write('TagId: $TagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, Uid, TagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLedgerRecentTag &&
          other.Id == this.Id &&
          other.Uid == this.Uid &&
          other.TagId == this.TagId);
}

class UserLedgerRecentTagsCompanion
    extends UpdateCompanion<UserLedgerRecentTag> {
  final Value<int> Id;
  final Value<int> Uid;
  final Value<int> TagId;
  const UserLedgerRecentTagsCompanion({
    this.Id = const Value.absent(),
    this.Uid = const Value.absent(),
    this.TagId = const Value.absent(),
  });
  UserLedgerRecentTagsCompanion.insert({
    this.Id = const Value.absent(),
    required int Uid,
    required int TagId,
  })  : Uid = Value(Uid),
        TagId = Value(TagId);
  static Insertable<UserLedgerRecentTag> custom({
    Expression<int>? Id,
    Expression<int>? Uid,
    Expression<int>? TagId,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (Uid != null) 'uid': Uid,
      if (TagId != null) 'tag_id': TagId,
    });
  }

  UserLedgerRecentTagsCompanion copyWith(
      {Value<int>? Id, Value<int>? Uid, Value<int>? TagId}) {
    return UserLedgerRecentTagsCompanion(
      Id: Id ?? this.Id,
      Uid: Uid ?? this.Uid,
      TagId: TagId ?? this.TagId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Id.present) {
      map['id'] = Variable<int>(Id.value);
    }
    if (Uid.present) {
      map['uid'] = Variable<int>(Uid.value);
    }
    if (TagId.present) {
      map['tag_id'] = Variable<int>(TagId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserLedgerRecentTagsCompanion(')
          ..write('Id: $Id, ')
          ..write('Uid: $Uid, ')
          ..write('TagId: $TagId')
          ..write(')'))
        .toString();
  }
}

class $UserCardsTable extends UserCards
    with TableInfo<$UserCardsTable, UserCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _IdMeta = const VerificationMeta('Id');
  @override
  late final GeneratedColumn<int> Id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _UidMeta = const VerificationMeta('Uid');
  @override
  late final GeneratedColumn<int> Uid = GeneratedColumn<int>(
      'uid', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _PlaceMeta = const VerificationMeta('Place');
  @override
  late final GeneratedColumn<int> Place = GeneratedColumn<int>(
      'place', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ParamsMeta = const VerificationMeta('Params');
  @override
  late final GeneratedColumn<String> Params = GeneratedColumn<String>(
      'params', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [Id, Uid, Place, Params];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_cards';
  @override
  VerificationContext validateIntegrity(Insertable<UserCard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_IdMeta, Id.isAcceptableOrUnknown(data['id']!, _IdMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
          _UidMeta, Uid.isAcceptableOrUnknown(data['uid']!, _UidMeta));
    } else if (isInserting) {
      context.missing(_UidMeta);
    }
    if (data.containsKey('place')) {
      context.handle(
          _PlaceMeta, Place.isAcceptableOrUnknown(data['place']!, _PlaceMeta));
    } else if (isInserting) {
      context.missing(_PlaceMeta);
    }
    if (data.containsKey('params')) {
      context.handle(_ParamsMeta,
          Params.isAcceptableOrUnknown(data['params']!, _ParamsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {Id};
  @override
  UserCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserCard(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      Uid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uid'])!,
      Place: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}place'])!,
      Params: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}params']),
    );
  }

  @override
  $UserCardsTable createAlias(String alias) {
    return $UserCardsTable(attachedDatabase, alias);
  }
}

class UserCard extends DataClass implements Insertable<UserCard> {
  final int Id;
  final int Uid;
  final int Place;
  final String? Params;
  const UserCard(
      {required this.Id, required this.Uid, required this.Place, this.Params});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['uid'] = Variable<int>(Uid);
    map['place'] = Variable<int>(Place);
    if (!nullToAbsent || Params != null) {
      map['params'] = Variable<String>(Params);
    }
    return map;
  }

  UserCardsCompanion toCompanion(bool nullToAbsent) {
    return UserCardsCompanion(
      Id: Value(Id),
      Uid: Value(Uid),
      Place: Value(Place),
      Params:
          Params == null && nullToAbsent ? const Value.absent() : Value(Params),
    );
  }

  factory UserCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserCard(
      Id: serializer.fromJson<int>(json['Id']),
      Uid: serializer.fromJson<int>(json['Uid']),
      Place: serializer.fromJson<int>(json['Place']),
      Params: serializer.fromJson<String?>(json['Params']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'Uid': serializer.toJson<int>(Uid),
      'Place': serializer.toJson<int>(Place),
      'Params': serializer.toJson<String?>(Params),
    };
  }

  UserCard copyWith(
          {int? Id,
          int? Uid,
          int? Place,
          Value<String?> Params = const Value.absent()}) =>
      UserCard(
        Id: Id ?? this.Id,
        Uid: Uid ?? this.Uid,
        Place: Place ?? this.Place,
        Params: Params.present ? Params.value : this.Params,
      );
  @override
  String toString() {
    return (StringBuffer('UserCard(')
          ..write('Id: $Id, ')
          ..write('Uid: $Uid, ')
          ..write('Place: $Place, ')
          ..write('Params: $Params')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, Uid, Place, Params);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCard &&
          other.Id == this.Id &&
          other.Uid == this.Uid &&
          other.Place == this.Place &&
          other.Params == this.Params);
}

class UserCardsCompanion extends UpdateCompanion<UserCard> {
  final Value<int> Id;
  final Value<int> Uid;
  final Value<int> Place;
  final Value<String?> Params;
  const UserCardsCompanion({
    this.Id = const Value.absent(),
    this.Uid = const Value.absent(),
    this.Place = const Value.absent(),
    this.Params = const Value.absent(),
  });
  UserCardsCompanion.insert({
    this.Id = const Value.absent(),
    required int Uid,
    required int Place,
    this.Params = const Value.absent(),
  })  : Uid = Value(Uid),
        Place = Value(Place);
  static Insertable<UserCard> custom({
    Expression<int>? Id,
    Expression<int>? Uid,
    Expression<int>? Place,
    Expression<String>? Params,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (Uid != null) 'uid': Uid,
      if (Place != null) 'place': Place,
      if (Params != null) 'params': Params,
    });
  }

  UserCardsCompanion copyWith(
      {Value<int>? Id,
      Value<int>? Uid,
      Value<int>? Place,
      Value<String?>? Params}) {
    return UserCardsCompanion(
      Id: Id ?? this.Id,
      Uid: Uid ?? this.Uid,
      Place: Place ?? this.Place,
      Params: Params ?? this.Params,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Id.present) {
      map['id'] = Variable<int>(Id.value);
    }
    if (Uid.present) {
      map['uid'] = Variable<int>(Uid.value);
    }
    if (Place.present) {
      map['place'] = Variable<int>(Place.value);
    }
    if (Params.present) {
      map['params'] = Variable<String>(Params.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCardsCompanion(')
          ..write('Id: $Id, ')
          ..write('Uid: $Uid, ')
          ..write('Place: $Place, ')
          ..write('Params: $Params')
          ..write(')'))
        .toString();
  }
}

abstract class _$UserDBHelper extends GeneratedDatabase {
  _$UserDBHelper(QueryExecutor e) : super(e);
  _$UserDBHelperManager get managers => _$UserDBHelperManager(this);
  late final $UserInfosTable userInfos = $UserInfosTable(this);
  late final $UserLedgerRecentTagsTable userLedgerRecentTags =
      $UserLedgerRecentTagsTable(this);
  late final $UserCardsTable userCards = $UserCardsTable(this);
  late final Index userLedgerRecentTagsUid = Index('UserLedgerRecentTags.Uid',
      'CREATE INDEX "UserLedgerRecentTags.Uid" ON user_ledger_recent_tags (uid)');
  late final Index userCardsPlace = Index('UserCards.Place',
      'CREATE INDEX "UserCards.Place" ON user_cards (place)');
  late final Index userCardsUid = Index(
      'UserCards.Uid', 'CREATE INDEX "UserCards.Uid" ON user_cards (uid)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userInfos,
        userLedgerRecentTags,
        userCards,
        userLedgerRecentTagsUid,
        userCardsPlace,
        userCardsUid
      ];
}

typedef $$UserInfosTableInsertCompanionBuilder = UserInfosCompanion Function({
  Value<int> Id,
  required int LedgerId,
  Value<int?> LedgerRecentCount,
  required String Name,
  required String Icon,
  Value<String?> Token,
  Value<DateTime?> VipExpiryDate,
  Value<DateTime> RegisterDate,
});
typedef $$UserInfosTableUpdateCompanionBuilder = UserInfosCompanion Function({
  Value<int> Id,
  Value<int> LedgerId,
  Value<int?> LedgerRecentCount,
  Value<String> Name,
  Value<String> Icon,
  Value<String?> Token,
  Value<DateTime?> VipExpiryDate,
  Value<DateTime> RegisterDate,
});

class $$UserInfosTableTableManager extends RootTableManager<
    _$UserDBHelper,
    $UserInfosTable,
    UserInfo,
    $$UserInfosTableFilterComposer,
    $$UserInfosTableOrderingComposer,
    $$UserInfosTableProcessedTableManager,
    $$UserInfosTableInsertCompanionBuilder,
    $$UserInfosTableUpdateCompanionBuilder> {
  $$UserInfosTableTableManager(_$UserDBHelper db, $UserInfosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserInfosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserInfosTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$UserInfosTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            Value<int> LedgerId = const Value.absent(),
            Value<int?> LedgerRecentCount = const Value.absent(),
            Value<String> Name = const Value.absent(),
            Value<String> Icon = const Value.absent(),
            Value<String?> Token = const Value.absent(),
            Value<DateTime?> VipExpiryDate = const Value.absent(),
            Value<DateTime> RegisterDate = const Value.absent(),
          }) =>
              UserInfosCompanion(
            Id: Id,
            LedgerId: LedgerId,
            LedgerRecentCount: LedgerRecentCount,
            Name: Name,
            Icon: Icon,
            Token: Token,
            VipExpiryDate: VipExpiryDate,
            RegisterDate: RegisterDate,
          ),
          getInsertCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            required int LedgerId,
            Value<int?> LedgerRecentCount = const Value.absent(),
            required String Name,
            required String Icon,
            Value<String?> Token = const Value.absent(),
            Value<DateTime?> VipExpiryDate = const Value.absent(),
            Value<DateTime> RegisterDate = const Value.absent(),
          }) =>
              UserInfosCompanion.insert(
            Id: Id,
            LedgerId: LedgerId,
            LedgerRecentCount: LedgerRecentCount,
            Name: Name,
            Icon: Icon,
            Token: Token,
            VipExpiryDate: VipExpiryDate,
            RegisterDate: RegisterDate,
          ),
        ));
}

class $$UserInfosTableProcessedTableManager extends ProcessedTableManager<
    _$UserDBHelper,
    $UserInfosTable,
    UserInfo,
    $$UserInfosTableFilterComposer,
    $$UserInfosTableOrderingComposer,
    $$UserInfosTableProcessedTableManager,
    $$UserInfosTableInsertCompanionBuilder,
    $$UserInfosTableUpdateCompanionBuilder> {
  $$UserInfosTableProcessedTableManager(super.$state);
}

class $$UserInfosTableFilterComposer
    extends FilterComposer<_$UserDBHelper, $UserInfosTable> {
  $$UserInfosTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get LedgerId => $state.composableBuilder(
      column: $state.table.LedgerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get LedgerRecentCount => $state.composableBuilder(
      column: $state.table.LedgerRecentCount,
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

  ColumnFilters<String> get Token => $state.composableBuilder(
      column: $state.table.Token,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get VipExpiryDate => $state.composableBuilder(
      column: $state.table.VipExpiryDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get RegisterDate => $state.composableBuilder(
      column: $state.table.RegisterDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UserInfosTableOrderingComposer
    extends OrderingComposer<_$UserDBHelper, $UserInfosTable> {
  $$UserInfosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get LedgerId => $state.composableBuilder(
      column: $state.table.LedgerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get LedgerRecentCount => $state.composableBuilder(
      column: $state.table.LedgerRecentCount,
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

  ColumnOrderings<String> get Token => $state.composableBuilder(
      column: $state.table.Token,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get VipExpiryDate => $state.composableBuilder(
      column: $state.table.VipExpiryDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get RegisterDate => $state.composableBuilder(
      column: $state.table.RegisterDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UserLedgerRecentTagsTableInsertCompanionBuilder
    = UserLedgerRecentTagsCompanion Function({
  Value<int> Id,
  required int Uid,
  required int TagId,
});
typedef $$UserLedgerRecentTagsTableUpdateCompanionBuilder
    = UserLedgerRecentTagsCompanion Function({
  Value<int> Id,
  Value<int> Uid,
  Value<int> TagId,
});

class $$UserLedgerRecentTagsTableTableManager extends RootTableManager<
    _$UserDBHelper,
    $UserLedgerRecentTagsTable,
    UserLedgerRecentTag,
    $$UserLedgerRecentTagsTableFilterComposer,
    $$UserLedgerRecentTagsTableOrderingComposer,
    $$UserLedgerRecentTagsTableProcessedTableManager,
    $$UserLedgerRecentTagsTableInsertCompanionBuilder,
    $$UserLedgerRecentTagsTableUpdateCompanionBuilder> {
  $$UserLedgerRecentTagsTableTableManager(
      _$UserDBHelper db, $UserLedgerRecentTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$UserLedgerRecentTagsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$UserLedgerRecentTagsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$UserLedgerRecentTagsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            Value<int> Uid = const Value.absent(),
            Value<int> TagId = const Value.absent(),
          }) =>
              UserLedgerRecentTagsCompanion(
            Id: Id,
            Uid: Uid,
            TagId: TagId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            required int Uid,
            required int TagId,
          }) =>
              UserLedgerRecentTagsCompanion.insert(
            Id: Id,
            Uid: Uid,
            TagId: TagId,
          ),
        ));
}

class $$UserLedgerRecentTagsTableProcessedTableManager
    extends ProcessedTableManager<
        _$UserDBHelper,
        $UserLedgerRecentTagsTable,
        UserLedgerRecentTag,
        $$UserLedgerRecentTagsTableFilterComposer,
        $$UserLedgerRecentTagsTableOrderingComposer,
        $$UserLedgerRecentTagsTableProcessedTableManager,
        $$UserLedgerRecentTagsTableInsertCompanionBuilder,
        $$UserLedgerRecentTagsTableUpdateCompanionBuilder> {
  $$UserLedgerRecentTagsTableProcessedTableManager(super.$state);
}

class $$UserLedgerRecentTagsTableFilterComposer
    extends FilterComposer<_$UserDBHelper, $UserLedgerRecentTagsTable> {
  $$UserLedgerRecentTagsTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get Uid => $state.composableBuilder(
      column: $state.table.Uid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get TagId => $state.composableBuilder(
      column: $state.table.TagId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UserLedgerRecentTagsTableOrderingComposer
    extends OrderingComposer<_$UserDBHelper, $UserLedgerRecentTagsTable> {
  $$UserLedgerRecentTagsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get Uid => $state.composableBuilder(
      column: $state.table.Uid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get TagId => $state.composableBuilder(
      column: $state.table.TagId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UserCardsTableInsertCompanionBuilder = UserCardsCompanion Function({
  Value<int> Id,
  required int Uid,
  required int Place,
  Value<String?> Params,
});
typedef $$UserCardsTableUpdateCompanionBuilder = UserCardsCompanion Function({
  Value<int> Id,
  Value<int> Uid,
  Value<int> Place,
  Value<String?> Params,
});

class $$UserCardsTableTableManager extends RootTableManager<
    _$UserDBHelper,
    $UserCardsTable,
    UserCard,
    $$UserCardsTableFilterComposer,
    $$UserCardsTableOrderingComposer,
    $$UserCardsTableProcessedTableManager,
    $$UserCardsTableInsertCompanionBuilder,
    $$UserCardsTableUpdateCompanionBuilder> {
  $$UserCardsTableTableManager(_$UserDBHelper db, $UserCardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserCardsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserCardsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$UserCardsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            Value<int> Uid = const Value.absent(),
            Value<int> Place = const Value.absent(),
            Value<String?> Params = const Value.absent(),
          }) =>
              UserCardsCompanion(
            Id: Id,
            Uid: Uid,
            Place: Place,
            Params: Params,
          ),
          getInsertCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            required int Uid,
            required int Place,
            Value<String?> Params = const Value.absent(),
          }) =>
              UserCardsCompanion.insert(
            Id: Id,
            Uid: Uid,
            Place: Place,
            Params: Params,
          ),
        ));
}

class $$UserCardsTableProcessedTableManager extends ProcessedTableManager<
    _$UserDBHelper,
    $UserCardsTable,
    UserCard,
    $$UserCardsTableFilterComposer,
    $$UserCardsTableOrderingComposer,
    $$UserCardsTableProcessedTableManager,
    $$UserCardsTableInsertCompanionBuilder,
    $$UserCardsTableUpdateCompanionBuilder> {
  $$UserCardsTableProcessedTableManager(super.$state);
}

class $$UserCardsTableFilterComposer
    extends FilterComposer<_$UserDBHelper, $UserCardsTable> {
  $$UserCardsTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get Uid => $state.composableBuilder(
      column: $state.table.Uid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get Place => $state.composableBuilder(
      column: $state.table.Place,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get Params => $state.composableBuilder(
      column: $state.table.Params,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UserCardsTableOrderingComposer
    extends OrderingComposer<_$UserDBHelper, $UserCardsTable> {
  $$UserCardsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get Uid => $state.composableBuilder(
      column: $state.table.Uid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get Place => $state.composableBuilder(
      column: $state.table.Place,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Params => $state.composableBuilder(
      column: $state.table.Params,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$UserDBHelperManager {
  final _$UserDBHelper _db;
  _$UserDBHelperManager(this._db);
  $$UserInfosTableTableManager get userInfos =>
      $$UserInfosTableTableManager(_db, _db.userInfos);
  $$UserLedgerRecentTagsTableTableManager get userLedgerRecentTags =>
      $$UserLedgerRecentTagsTableTableManager(_db, _db.userLedgerRecentTags);
  $$UserCardsTableTableManager get userCards =>
      $$UserCardsTableTableManager(_db, _db.userCards);
}
