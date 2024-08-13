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
      'token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
    } else if (isInserting) {
      context.missing(_TokenMeta);
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
          .read(DriftSqlType.string, data['${effectivePrefix}token'])!,
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
  final String Token;
  final DateTime? VipExpiryDate;
  final DateTime RegisterDate;
  const UserInfo(
      {required this.Id,
      required this.LedgerId,
      this.LedgerRecentCount,
      required this.Name,
      required this.Icon,
      required this.Token,
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
    map['token'] = Variable<String>(Token);
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
      Token: Value(Token),
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
      Token: serializer.fromJson<String>(json['Token']),
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
      'Token': serializer.toJson<String>(Token),
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
          String? Token,
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
        Token: Token ?? this.Token,
        VipExpiryDate:
            VipExpiryDate.present ? VipExpiryDate.value : this.VipExpiryDate,
        RegisterDate: RegisterDate ?? this.RegisterDate,
      );
  UserInfo copyWithCompanion(UserInfosCompanion data) {
    return UserInfo(
      Id: data.Id.present ? data.Id.value : this.Id,
      LedgerId: data.LedgerId.present ? data.LedgerId.value : this.LedgerId,
      LedgerRecentCount: data.LedgerRecentCount.present
          ? data.LedgerRecentCount.value
          : this.LedgerRecentCount,
      Name: data.Name.present ? data.Name.value : this.Name,
      Icon: data.Icon.present ? data.Icon.value : this.Icon,
      Token: data.Token.present ? data.Token.value : this.Token,
      VipExpiryDate: data.VipExpiryDate.present
          ? data.VipExpiryDate.value
          : this.VipExpiryDate,
      RegisterDate: data.RegisterDate.present
          ? data.RegisterDate.value
          : this.RegisterDate,
    );
  }

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
  final Value<String> Token;
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
    required String Token,
    this.VipExpiryDate = const Value.absent(),
    this.RegisterDate = const Value.absent(),
  })  : LedgerId = Value(LedgerId),
        Name = Value(Name),
        Icon = Value(Icon),
        Token = Value(Token);
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
      Value<String>? Token,
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
  static const VerificationMeta _TimeMeta = const VerificationMeta('Time');
  @override
  late final GeneratedColumn<DateTime> Time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime(0)));
  @override
  List<GeneratedColumn> get $columns => [Id, Uid, TagId, Time];
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
    if (data.containsKey('time')) {
      context.handle(
          _TimeMeta, Time.isAcceptableOrUnknown(data['time']!, _TimeMeta));
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
      Time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
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
  final DateTime Time;
  const UserLedgerRecentTag(
      {required this.Id,
      required this.Uid,
      required this.TagId,
      required this.Time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['uid'] = Variable<int>(Uid);
    map['tag_id'] = Variable<int>(TagId);
    map['time'] = Variable<DateTime>(Time);
    return map;
  }

  UserLedgerRecentTagsCompanion toCompanion(bool nullToAbsent) {
    return UserLedgerRecentTagsCompanion(
      Id: Value(Id),
      Uid: Value(Uid),
      TagId: Value(TagId),
      Time: Value(Time),
    );
  }

  factory UserLedgerRecentTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserLedgerRecentTag(
      Id: serializer.fromJson<int>(json['Id']),
      Uid: serializer.fromJson<int>(json['Uid']),
      TagId: serializer.fromJson<int>(json['TagId']),
      Time: serializer.fromJson<DateTime>(json['Time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'Uid': serializer.toJson<int>(Uid),
      'TagId': serializer.toJson<int>(TagId),
      'Time': serializer.toJson<DateTime>(Time),
    };
  }

  UserLedgerRecentTag copyWith(
          {int? Id, int? Uid, int? TagId, DateTime? Time}) =>
      UserLedgerRecentTag(
        Id: Id ?? this.Id,
        Uid: Uid ?? this.Uid,
        TagId: TagId ?? this.TagId,
        Time: Time ?? this.Time,
      );
  UserLedgerRecentTag copyWithCompanion(UserLedgerRecentTagsCompanion data) {
    return UserLedgerRecentTag(
      Id: data.Id.present ? data.Id.value : this.Id,
      Uid: data.Uid.present ? data.Uid.value : this.Uid,
      TagId: data.TagId.present ? data.TagId.value : this.TagId,
      Time: data.Time.present ? data.Time.value : this.Time,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserLedgerRecentTag(')
          ..write('Id: $Id, ')
          ..write('Uid: $Uid, ')
          ..write('TagId: $TagId, ')
          ..write('Time: $Time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, Uid, TagId, Time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLedgerRecentTag &&
          other.Id == this.Id &&
          other.Uid == this.Uid &&
          other.TagId == this.TagId &&
          other.Time == this.Time);
}

class UserLedgerRecentTagsCompanion
    extends UpdateCompanion<UserLedgerRecentTag> {
  final Value<int> Id;
  final Value<int> Uid;
  final Value<int> TagId;
  final Value<DateTime> Time;
  const UserLedgerRecentTagsCompanion({
    this.Id = const Value.absent(),
    this.Uid = const Value.absent(),
    this.TagId = const Value.absent(),
    this.Time = const Value.absent(),
  });
  UserLedgerRecentTagsCompanion.insert({
    this.Id = const Value.absent(),
    required int Uid,
    required int TagId,
    this.Time = const Value.absent(),
  })  : Uid = Value(Uid),
        TagId = Value(TagId);
  static Insertable<UserLedgerRecentTag> custom({
    Expression<int>? Id,
    Expression<int>? Uid,
    Expression<int>? TagId,
    Expression<DateTime>? Time,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (Uid != null) 'uid': Uid,
      if (TagId != null) 'tag_id': TagId,
      if (Time != null) 'time': Time,
    });
  }

  UserLedgerRecentTagsCompanion copyWith(
      {Value<int>? Id,
      Value<int>? Uid,
      Value<int>? TagId,
      Value<DateTime>? Time}) {
    return UserLedgerRecentTagsCompanion(
      Id: Id ?? this.Id,
      Uid: Uid ?? this.Uid,
      TagId: TagId ?? this.TagId,
      Time: Time ?? this.Time,
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
    if (Time.present) {
      map['time'] = Variable<DateTime>(Time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserLedgerRecentTagsCompanion(')
          ..write('Id: $Id, ')
          ..write('Uid: $Uid, ')
          ..write('TagId: $TagId, ')
          ..write('Time: $Time')
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
  late final GeneratedColumnWithTypeConverter<ELedgerCardSpace, String> Place =
      GeneratedColumn<String>('place', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ELedgerCardSpace>($UserCardsTable.$converterPlace);
  static const VerificationMeta _NameMeta = const VerificationMeta('Name');
  @override
  late final GeneratedColumn<String> Name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ParamsMeta = const VerificationMeta('Params');
  @override
  late final GeneratedColumn<String> Params = GeneratedColumn<String>(
      'params', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [Id, Uid, Place, Name, Params];
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
    context.handle(_PlaceMeta, const VerificationResult.success());
    if (data.containsKey('name')) {
      context.handle(
          _NameMeta, Name.isAcceptableOrUnknown(data['name']!, _NameMeta));
    } else if (isInserting) {
      context.missing(_NameMeta);
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
      Place: $UserCardsTable.$converterPlace.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}place'])!),
      Name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      Params: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}params']),
    );
  }

  @override
  $UserCardsTable createAlias(String alias) {
    return $UserCardsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ELedgerCardSpace, String, String> $converterPlace =
      const EnumNameConverter<ELedgerCardSpace>(ELedgerCardSpace.values);
}

class UserCard extends DataClass implements Insertable<UserCard> {
  final int Id;
  final int Uid;
  final ELedgerCardSpace Place;
  final String Name;
  final String? Params;
  const UserCard(
      {required this.Id,
      required this.Uid,
      required this.Place,
      required this.Name,
      this.Params});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['uid'] = Variable<int>(Uid);
    {
      map['place'] =
          Variable<String>($UserCardsTable.$converterPlace.toSql(Place));
    }
    map['name'] = Variable<String>(Name);
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
      Name: Value(Name),
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
      Place: $UserCardsTable.$converterPlace
          .fromJson(serializer.fromJson<String>(json['Place'])),
      Name: serializer.fromJson<String>(json['Name']),
      Params: serializer.fromJson<String?>(json['Params']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'Uid': serializer.toJson<int>(Uid),
      'Place': serializer
          .toJson<String>($UserCardsTable.$converterPlace.toJson(Place)),
      'Name': serializer.toJson<String>(Name),
      'Params': serializer.toJson<String?>(Params),
    };
  }

  UserCard copyWith(
          {int? Id,
          int? Uid,
          ELedgerCardSpace? Place,
          String? Name,
          Value<String?> Params = const Value.absent()}) =>
      UserCard(
        Id: Id ?? this.Id,
        Uid: Uid ?? this.Uid,
        Place: Place ?? this.Place,
        Name: Name ?? this.Name,
        Params: Params.present ? Params.value : this.Params,
      );
  UserCard copyWithCompanion(UserCardsCompanion data) {
    return UserCard(
      Id: data.Id.present ? data.Id.value : this.Id,
      Uid: data.Uid.present ? data.Uid.value : this.Uid,
      Place: data.Place.present ? data.Place.value : this.Place,
      Name: data.Name.present ? data.Name.value : this.Name,
      Params: data.Params.present ? data.Params.value : this.Params,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserCard(')
          ..write('Id: $Id, ')
          ..write('Uid: $Uid, ')
          ..write('Place: $Place, ')
          ..write('Name: $Name, ')
          ..write('Params: $Params')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, Uid, Place, Name, Params);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCard &&
          other.Id == this.Id &&
          other.Uid == this.Uid &&
          other.Place == this.Place &&
          other.Name == this.Name &&
          other.Params == this.Params);
}

class UserCardsCompanion extends UpdateCompanion<UserCard> {
  final Value<int> Id;
  final Value<int> Uid;
  final Value<ELedgerCardSpace> Place;
  final Value<String> Name;
  final Value<String?> Params;
  const UserCardsCompanion({
    this.Id = const Value.absent(),
    this.Uid = const Value.absent(),
    this.Place = const Value.absent(),
    this.Name = const Value.absent(),
    this.Params = const Value.absent(),
  });
  UserCardsCompanion.insert({
    this.Id = const Value.absent(),
    required int Uid,
    required ELedgerCardSpace Place,
    required String Name,
    this.Params = const Value.absent(),
  })  : Uid = Value(Uid),
        Place = Value(Place),
        Name = Value(Name);
  static Insertable<UserCard> custom({
    Expression<int>? Id,
    Expression<int>? Uid,
    Expression<String>? Place,
    Expression<String>? Name,
    Expression<String>? Params,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (Uid != null) 'uid': Uid,
      if (Place != null) 'place': Place,
      if (Name != null) 'name': Name,
      if (Params != null) 'params': Params,
    });
  }

  UserCardsCompanion copyWith(
      {Value<int>? Id,
      Value<int>? Uid,
      Value<ELedgerCardSpace>? Place,
      Value<String>? Name,
      Value<String?>? Params}) {
    return UserCardsCompanion(
      Id: Id ?? this.Id,
      Uid: Uid ?? this.Uid,
      Place: Place ?? this.Place,
      Name: Name ?? this.Name,
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
      map['place'] =
          Variable<String>($UserCardsTable.$converterPlace.toSql(Place.value));
    }
    if (Name.present) {
      map['name'] = Variable<String>(Name.value);
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
          ..write('Name: $Name, ')
          ..write('Params: $Params')
          ..write(')'))
        .toString();
  }
}

abstract class _$UserDBHelper extends GeneratedDatabase {
  _$UserDBHelper(QueryExecutor e) : super(e);
  $UserDBHelperManager get managers => $UserDBHelperManager(this);
  late final $UserInfosTable userInfos = $UserInfosTable(this);
  late final $UserLedgerRecentTagsTable userLedgerRecentTags =
      $UserLedgerRecentTagsTable(this);
  late final $UserCardsTable userCards = $UserCardsTable(this);
  late final Index userInfosToken = Index('UserInfos.Token',
      'CREATE INDEX "UserInfos.Token" ON user_infos (token)');
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
        userInfosToken,
        userLedgerRecentTagsUid,
        userCardsPlace,
        userCardsUid
      ];
}

typedef $$UserInfosTableCreateCompanionBuilder = UserInfosCompanion Function({
  Value<int> Id,
  required int LedgerId,
  Value<int?> LedgerRecentCount,
  required String Name,
  required String Icon,
  required String Token,
  Value<DateTime?> VipExpiryDate,
  Value<DateTime> RegisterDate,
});
typedef $$UserInfosTableUpdateCompanionBuilder = UserInfosCompanion Function({
  Value<int> Id,
  Value<int> LedgerId,
  Value<int?> LedgerRecentCount,
  Value<String> Name,
  Value<String> Icon,
  Value<String> Token,
  Value<DateTime?> VipExpiryDate,
  Value<DateTime> RegisterDate,
});

class $$UserInfosTableTableManager extends RootTableManager<
    _$UserDBHelper,
    $UserInfosTable,
    UserInfo,
    $$UserInfosTableFilterComposer,
    $$UserInfosTableOrderingComposer,
    $$UserInfosTableCreateCompanionBuilder,
    $$UserInfosTableUpdateCompanionBuilder> {
  $$UserInfosTableTableManager(_$UserDBHelper db, $UserInfosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserInfosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserInfosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            Value<int> LedgerId = const Value.absent(),
            Value<int?> LedgerRecentCount = const Value.absent(),
            Value<String> Name = const Value.absent(),
            Value<String> Icon = const Value.absent(),
            Value<String> Token = const Value.absent(),
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
          createCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            required int LedgerId,
            Value<int?> LedgerRecentCount = const Value.absent(),
            required String Name,
            required String Icon,
            required String Token,
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

typedef $$UserLedgerRecentTagsTableCreateCompanionBuilder
    = UserLedgerRecentTagsCompanion Function({
  Value<int> Id,
  required int Uid,
  required int TagId,
  Value<DateTime> Time,
});
typedef $$UserLedgerRecentTagsTableUpdateCompanionBuilder
    = UserLedgerRecentTagsCompanion Function({
  Value<int> Id,
  Value<int> Uid,
  Value<int> TagId,
  Value<DateTime> Time,
});

class $$UserLedgerRecentTagsTableTableManager extends RootTableManager<
    _$UserDBHelper,
    $UserLedgerRecentTagsTable,
    UserLedgerRecentTag,
    $$UserLedgerRecentTagsTableFilterComposer,
    $$UserLedgerRecentTagsTableOrderingComposer,
    $$UserLedgerRecentTagsTableCreateCompanionBuilder,
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
          updateCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            Value<int> Uid = const Value.absent(),
            Value<int> TagId = const Value.absent(),
            Value<DateTime> Time = const Value.absent(),
          }) =>
              UserLedgerRecentTagsCompanion(
            Id: Id,
            Uid: Uid,
            TagId: TagId,
            Time: Time,
          ),
          createCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            required int Uid,
            required int TagId,
            Value<DateTime> Time = const Value.absent(),
          }) =>
              UserLedgerRecentTagsCompanion.insert(
            Id: Id,
            Uid: Uid,
            TagId: TagId,
            Time: Time,
          ),
        ));
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

  ColumnFilters<DateTime> get Time => $state.composableBuilder(
      column: $state.table.Time,
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

  ColumnOrderings<DateTime> get Time => $state.composableBuilder(
      column: $state.table.Time,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UserCardsTableCreateCompanionBuilder = UserCardsCompanion Function({
  Value<int> Id,
  required int Uid,
  required ELedgerCardSpace Place,
  required String Name,
  Value<String?> Params,
});
typedef $$UserCardsTableUpdateCompanionBuilder = UserCardsCompanion Function({
  Value<int> Id,
  Value<int> Uid,
  Value<ELedgerCardSpace> Place,
  Value<String> Name,
  Value<String?> Params,
});

class $$UserCardsTableTableManager extends RootTableManager<
    _$UserDBHelper,
    $UserCardsTable,
    UserCard,
    $$UserCardsTableFilterComposer,
    $$UserCardsTableOrderingComposer,
    $$UserCardsTableCreateCompanionBuilder,
    $$UserCardsTableUpdateCompanionBuilder> {
  $$UserCardsTableTableManager(_$UserDBHelper db, $UserCardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserCardsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserCardsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            Value<int> Uid = const Value.absent(),
            Value<ELedgerCardSpace> Place = const Value.absent(),
            Value<String> Name = const Value.absent(),
            Value<String?> Params = const Value.absent(),
          }) =>
              UserCardsCompanion(
            Id: Id,
            Uid: Uid,
            Place: Place,
            Name: Name,
            Params: Params,
          ),
          createCompanionCallback: ({
            Value<int> Id = const Value.absent(),
            required int Uid,
            required ELedgerCardSpace Place,
            required String Name,
            Value<String?> Params = const Value.absent(),
          }) =>
              UserCardsCompanion.insert(
            Id: Id,
            Uid: Uid,
            Place: Place,
            Name: Name,
            Params: Params,
          ),
        ));
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

  ColumnWithTypeConverterFilters<ELedgerCardSpace, ELedgerCardSpace, String>
      get Place => $state.composableBuilder(
          column: $state.table.Place,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get Name => $state.composableBuilder(
      column: $state.table.Name,
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

  ColumnOrderings<String> get Place => $state.composableBuilder(
      column: $state.table.Place,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Name => $state.composableBuilder(
      column: $state.table.Name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Params => $state.composableBuilder(
      column: $state.table.Params,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $UserDBHelperManager {
  final _$UserDBHelper _db;
  $UserDBHelperManager(this._db);
  $$UserInfosTableTableManager get userInfos =>
      $$UserInfosTableTableManager(_db, _db.userInfos);
  $$UserLedgerRecentTagsTableTableManager get userLedgerRecentTags =>
      $$UserLedgerRecentTagsTableTableManager(_db, _db.userLedgerRecentTags);
  $$UserCardsTableTableManager get userCards =>
      $$UserCardsTableTableManager(_db, _db.userCards);
}
