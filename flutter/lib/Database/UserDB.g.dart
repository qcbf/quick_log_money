// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDB.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
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
  List<GeneratedColumn> get $columns =>
      [Id, LedgerId, Name, Icon, Token, VipExpiryDate, RegisterDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
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
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      LedgerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ledger_id'])!,
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
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int Id;
  final int LedgerId;
  final String Name;
  final String Icon;
  final String? Token;
  final DateTime? VipExpiryDate;
  final DateTime RegisterDate;
  const User(
      {required this.Id,
      required this.LedgerId,
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

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      Id: Value(Id),
      LedgerId: Value(LedgerId),
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

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      Id: serializer.fromJson<int>(json['Id']),
      LedgerId: serializer.fromJson<int>(json['LedgerId']),
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
      'Name': serializer.toJson<String>(Name),
      'Icon': serializer.toJson<String>(Icon),
      'Token': serializer.toJson<String?>(Token),
      'VipExpiryDate': serializer.toJson<DateTime?>(VipExpiryDate),
      'RegisterDate': serializer.toJson<DateTime>(RegisterDate),
    };
  }

  User copyWith(
          {int? Id,
          int? LedgerId,
          String? Name,
          String? Icon,
          Value<String?> Token = const Value.absent(),
          Value<DateTime?> VipExpiryDate = const Value.absent(),
          DateTime? RegisterDate}) =>
      User(
        Id: Id ?? this.Id,
        LedgerId: LedgerId ?? this.LedgerId,
        Name: Name ?? this.Name,
        Icon: Icon ?? this.Icon,
        Token: Token.present ? Token.value : this.Token,
        VipExpiryDate:
            VipExpiryDate.present ? VipExpiryDate.value : this.VipExpiryDate,
        RegisterDate: RegisterDate ?? this.RegisterDate,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('Id: $Id, ')
          ..write('LedgerId: $LedgerId, ')
          ..write('Name: $Name, ')
          ..write('Icon: $Icon, ')
          ..write('Token: $Token, ')
          ..write('VipExpiryDate: $VipExpiryDate, ')
          ..write('RegisterDate: $RegisterDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(Id, LedgerId, Name, Icon, Token, VipExpiryDate, RegisterDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.Id == this.Id &&
          other.LedgerId == this.LedgerId &&
          other.Name == this.Name &&
          other.Icon == this.Icon &&
          other.Token == this.Token &&
          other.VipExpiryDate == this.VipExpiryDate &&
          other.RegisterDate == this.RegisterDate);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> Id;
  final Value<int> LedgerId;
  final Value<String> Name;
  final Value<String> Icon;
  final Value<String?> Token;
  final Value<DateTime?> VipExpiryDate;
  final Value<DateTime> RegisterDate;
  const UsersCompanion({
    this.Id = const Value.absent(),
    this.LedgerId = const Value.absent(),
    this.Name = const Value.absent(),
    this.Icon = const Value.absent(),
    this.Token = const Value.absent(),
    this.VipExpiryDate = const Value.absent(),
    this.RegisterDate = const Value.absent(),
  });
  UsersCompanion.insert({
    this.Id = const Value.absent(),
    required int LedgerId,
    required String Name,
    required String Icon,
    this.Token = const Value.absent(),
    this.VipExpiryDate = const Value.absent(),
    this.RegisterDate = const Value.absent(),
  })  : LedgerId = Value(LedgerId),
        Name = Value(Name),
        Icon = Value(Icon);
  static Insertable<User> custom({
    Expression<int>? Id,
    Expression<int>? LedgerId,
    Expression<String>? Name,
    Expression<String>? Icon,
    Expression<String>? Token,
    Expression<DateTime>? VipExpiryDate,
    Expression<DateTime>? RegisterDate,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (LedgerId != null) 'ledger_id': LedgerId,
      if (Name != null) 'name': Name,
      if (Icon != null) 'icon': Icon,
      if (Token != null) 'token': Token,
      if (VipExpiryDate != null) 'vip_expiry_date': VipExpiryDate,
      if (RegisterDate != null) 'register_date': RegisterDate,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? Id,
      Value<int>? LedgerId,
      Value<String>? Name,
      Value<String>? Icon,
      Value<String?>? Token,
      Value<DateTime?>? VipExpiryDate,
      Value<DateTime>? RegisterDate}) {
    return UsersCompanion(
      Id: Id ?? this.Id,
      LedgerId: LedgerId ?? this.LedgerId,
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
    return (StringBuffer('UsersCompanion(')
          ..write('Id: $Id, ')
          ..write('LedgerId: $LedgerId, ')
          ..write('Name: $Name, ')
          ..write('Icon: $Icon, ')
          ..write('Token: $Token, ')
          ..write('VipExpiryDate: $VipExpiryDate, ')
          ..write('RegisterDate: $RegisterDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$UserDBHelper extends GeneratedDatabase {
  _$UserDBHelper(QueryExecutor e) : super(e);
  _$UserDBHelperManager get managers => _$UserDBHelperManager(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}

typedef $$UsersTableInsertCompanionBuilder = UsersCompanion Function({
  Value<int> Id,
  required int LedgerId,
  required String Name,
  required String Icon,
  Value<String?> Token,
  Value<DateTime?> VipExpiryDate,
  Value<DateTime> RegisterDate,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> Id,
  Value<int> LedgerId,
  Value<String> Name,
  Value<String> Icon,
  Value<String?> Token,
  Value<DateTime?> VipExpiryDate,
  Value<DateTime> RegisterDate,
});

class $$UsersTableTableManager extends RootTableManager<
    _$UserDBHelper,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableProcessedTableManager,
    $$UsersTableInsertCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableTableManager(_$UserDBHelper db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$UsersTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            Value<int> LedgerId = const Value.absent(),
            Value<String> Name = const Value.absent(),
            Value<String> Icon = const Value.absent(),
            Value<String?> Token = const Value.absent(),
            Value<DateTime?> VipExpiryDate = const Value.absent(),
            Value<DateTime> RegisterDate = const Value.absent(),
          }) =>
              UsersCompanion(
            Id: Id,
            LedgerId: LedgerId,
            Name: Name,
            Icon: Icon,
            Token: Token,
            VipExpiryDate: VipExpiryDate,
            RegisterDate: RegisterDate,
          ),
          getInsertCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            required int LedgerId,
            required String Name,
            required String Icon,
            Value<String?> Token = const Value.absent(),
            Value<DateTime?> VipExpiryDate = const Value.absent(),
            Value<DateTime> RegisterDate = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            Id: Id,
            LedgerId: LedgerId,
            Name: Name,
            Icon: Icon,
            Token: Token,
            VipExpiryDate: VipExpiryDate,
            RegisterDate: RegisterDate,
          ),
        ));
}

class $$UsersTableProcessedTableManager extends ProcessedTableManager<
    _$UserDBHelper,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableProcessedTableManager,
    $$UsersTableInsertCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableProcessedTableManager(super.$state);
}

class $$UsersTableFilterComposer
    extends FilterComposer<_$UserDBHelper, $UsersTable> {
  $$UsersTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get LedgerId => $state.composableBuilder(
      column: $state.table.LedgerId,
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

class $$UsersTableOrderingComposer
    extends OrderingComposer<_$UserDBHelper, $UsersTable> {
  $$UsersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get LedgerId => $state.composableBuilder(
      column: $state.table.LedgerId,
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

class _$UserDBHelperManager {
  final _$UserDBHelper _db;
  _$UserDBHelperManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
