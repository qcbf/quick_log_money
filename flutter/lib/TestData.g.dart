// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TestData.dart';

// ignore_for_file: type=lint
class $TestTableTable extends TestTable
    with TableInfo<$TestTableTable, TestTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _IdMeta = const VerificationMeta('Id');
  @override
  late final GeneratedColumn<int> Id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _MyValueMeta =
      const VerificationMeta('MyValue');
  @override
  late final GeneratedColumn<int> MyValue = GeneratedColumn<int>(
      'my_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _Value2Meta = const VerificationMeta('Value2');
  @override
  late final GeneratedColumn<int> Value2 = GeneratedColumn<int>(
      'value2', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _NameMeta = const VerificationMeta('Name');
  @override
  late final GeneratedColumn<String> Name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [Id, MyValue, Value2, Name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_table';
  @override
  VerificationContext validateIntegrity(Insertable<TestTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_IdMeta, Id.isAcceptableOrUnknown(data['id']!, _IdMeta));
    }
    if (data.containsKey('my_value')) {
      context.handle(_MyValueMeta,
          MyValue.isAcceptableOrUnknown(data['my_value']!, _MyValueMeta));
    } else if (isInserting) {
      context.missing(_MyValueMeta);
    }
    if (data.containsKey('value2')) {
      context.handle(_Value2Meta,
          Value2.isAcceptableOrUnknown(data['value2']!, _Value2Meta));
    } else if (isInserting) {
      context.missing(_Value2Meta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _NameMeta, Name.isAcceptableOrUnknown(data['name']!, _NameMeta));
    } else if (isInserting) {
      context.missing(_NameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {Id};
  @override
  TestTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestTableData(
      Id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      MyValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}my_value'])!,
      Value2: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}value2'])!,
      Name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $TestTableTable createAlias(String alias) {
    return $TestTableTable(attachedDatabase, alias);
  }
}

class TestTableData extends DataClass implements Insertable<TestTableData> {
  final int Id;
  final int MyValue;
  final int Value2;
  final String Name;
  const TestTableData(
      {required this.Id,
      required this.MyValue,
      required this.Value2,
      required this.Name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(Id);
    map['my_value'] = Variable<int>(MyValue);
    map['value2'] = Variable<int>(Value2);
    map['name'] = Variable<String>(Name);
    return map;
  }

  TestTableCompanion toCompanion(bool nullToAbsent) {
    return TestTableCompanion(
      Id: Value(Id),
      MyValue: Value(MyValue),
      Value2: Value(Value2),
      Name: Value(Name),
    );
  }

  factory TestTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestTableData(
      Id: serializer.fromJson<int>(json['Id']),
      MyValue: serializer.fromJson<int>(json['MyValue']),
      Value2: serializer.fromJson<int>(json['Value2']),
      Name: serializer.fromJson<String>(json['Name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Id': serializer.toJson<int>(Id),
      'MyValue': serializer.toJson<int>(MyValue),
      'Value2': serializer.toJson<int>(Value2),
      'Name': serializer.toJson<String>(Name),
    };
  }

  TestTableData copyWith({int? Id, int? MyValue, int? Value2, String? Name}) =>
      TestTableData(
        Id: Id ?? this.Id,
        MyValue: MyValue ?? this.MyValue,
        Value2: Value2 ?? this.Value2,
        Name: Name ?? this.Name,
      );
  @override
  String toString() {
    return (StringBuffer('TestTableData(')
          ..write('Id: $Id, ')
          ..write('MyValue: $MyValue, ')
          ..write('Value2: $Value2, ')
          ..write('Name: $Name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Id, MyValue, Value2, Name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestTableData &&
          other.Id == this.Id &&
          other.MyValue == this.MyValue &&
          other.Value2 == this.Value2 &&
          other.Name == this.Name);
}

class TestTableCompanion extends UpdateCompanion<TestTableData> {
  final Value<int> Id;
  final Value<int> MyValue;
  final Value<int> Value2;
  final Value<String> Name;
  const TestTableCompanion({
    this.Id = const Value.absent(),
    this.MyValue = const Value.absent(),
    this.Value2 = const Value.absent(),
    this.Name = const Value.absent(),
  });
  TestTableCompanion.insert({
    this.Id = const Value.absent(),
    required int MyValue,
    required int Value2,
    required String Name,
  })  : MyValue = Value(MyValue),
        Value2 = Value(Value2),
        Name = Value(Name);
  static Insertable<TestTableData> custom({
    Expression<int>? Id,
    Expression<int>? MyValue,
    Expression<int>? Value2,
    Expression<String>? Name,
  }) {
    return RawValuesInsertable({
      if (Id != null) 'id': Id,
      if (MyValue != null) 'my_value': MyValue,
      if (Value2 != null) 'value2': Value2,
      if (Name != null) 'name': Name,
    });
  }

  TestTableCompanion copyWith(
      {Value<int>? Id,
      Value<int>? MyValue,
      Value<int>? Value2,
      Value<String>? Name}) {
    return TestTableCompanion(
      Id: Id ?? this.Id,
      MyValue: MyValue ?? this.MyValue,
      Value2: Value2 ?? this.Value2,
      Name: Name ?? this.Name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Id.present) {
      map['id'] = Variable<int>(Id.value);
    }
    if (MyValue.present) {
      map['my_value'] = Variable<int>(MyValue.value);
    }
    if (Value2.present) {
      map['value2'] = Variable<int>(Value2.value);
    }
    if (Name.present) {
      map['name'] = Variable<String>(Name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestTableCompanion(')
          ..write('Id: $Id, ')
          ..write('MyValue: $MyValue, ')
          ..write('Value2: $Value2, ')
          ..write('Name: $Name')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  _$MyDatabaseManager get managers => _$MyDatabaseManager(this);
  late final $TestTableTable testTable = $TestTableTable(this);
  late final Index name =
      Index('Name', 'CREATE INDEX Name ON test_table (my_value)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [testTable, name];
}

typedef $$TestTableTableInsertCompanionBuilder = TestTableCompanion Function({
  Value<int> Id,
  required int MyValue,
  required int Value2,
  required String Name,
});
typedef $$TestTableTableUpdateCompanionBuilder = TestTableCompanion Function({
  Value<int> Id,
  Value<int> MyValue,
  Value<int> Value2,
  Value<String> Name,
});

class $$TestTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $TestTableTable,
    TestTableData,
    $$TestTableTableFilterComposer,
    $$TestTableTableOrderingComposer,
    $$TestTableTableProcessedTableManager,
    $$TestTableTableInsertCompanionBuilder,
    $$TestTableTableUpdateCompanionBuilder> {
  $$TestTableTableTableManager(_$MyDatabase db, $TestTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TestTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TestTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TestTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            Value<int> MyValue = const Value.absent(),
            Value<int> Value2 = const Value.absent(),
            Value<String> Name = const Value.absent(),
          }) =>
              TestTableCompanion(
            Id: Id,
            MyValue: MyValue,
            Value2: Value2,
            Name: Name,
          ),
          getInsertCompanionBuilder: ({
            Value<int> Id = const Value.absent(),
            required int MyValue,
            required int Value2,
            required String Name,
          }) =>
              TestTableCompanion.insert(
            Id: Id,
            MyValue: MyValue,
            Value2: Value2,
            Name: Name,
          ),
        ));
}

class $$TestTableTableProcessedTableManager extends ProcessedTableManager<
    _$MyDatabase,
    $TestTableTable,
    TestTableData,
    $$TestTableTableFilterComposer,
    $$TestTableTableOrderingComposer,
    $$TestTableTableProcessedTableManager,
    $$TestTableTableInsertCompanionBuilder,
    $$TestTableTableUpdateCompanionBuilder> {
  $$TestTableTableProcessedTableManager(super.$state);
}

class $$TestTableTableFilterComposer
    extends FilterComposer<_$MyDatabase, $TestTableTable> {
  $$TestTableTableFilterComposer(super.$state);
  ColumnFilters<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get MyValue => $state.composableBuilder(
      column: $state.table.MyValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get Value2 => $state.composableBuilder(
      column: $state.table.Value2,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get Name => $state.composableBuilder(
      column: $state.table.Name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TestTableTableOrderingComposer
    extends OrderingComposer<_$MyDatabase, $TestTableTable> {
  $$TestTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get Id => $state.composableBuilder(
      column: $state.table.Id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get MyValue => $state.composableBuilder(
      column: $state.table.MyValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get Value2 => $state.composableBuilder(
      column: $state.table.Value2,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get Name => $state.composableBuilder(
      column: $state.table.Name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$MyDatabaseManager {
  final _$MyDatabase _db;
  _$MyDatabaseManager(this._db);
  $$TestTableTableTableManager get testTable =>
      $$TestTableTableTableManager(_db, _db.testTable);
}
