import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

class DatabaseConnector {
  static LazyDatabase OpenConnection(String name) {
    return LazyDatabase(() async {
      sqlite3.tempDirectory = (await getTemporaryDirectory()).path;
      await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
      return NativeDatabase.createInBackground(File("${Def.LocalPath}$name"), isolateSetup: () async {
        open
          // ..overrideFor(OperatingSystem.windows, () => DynamicLibrary.open('sqlcipher.dll'))
          ..overrideFor(OperatingSystem.linux, () => DynamicLibrary.open('libsqlcipher.so'))
          ..overrideFor(OperatingSystem.android, openCipherOnAndroid);
      }, setup: (db) {
        final result = db.select('pragma cipher_version');
        if (result.isEmpty) {
          throw UnsupportedError('This database needs to run with SQLCipher, but that library is not available!');
        }
        db.execute("pragma key = '$name.f'");
      }).interceptWith(SqlInterceptor());
    });
  }
}

class SqlInterceptor extends QueryInterceptor {
  Future<T> _RunSql<T>(String description, FutureOr<T> Function() operation) async {
    final stopwatch = Stopwatch()..start();
    print('Running $description');

    try {
      final result = await operation();
      print(' => succeeded after ${stopwatch.elapsedMilliseconds}ms');
      return result;
    } on Object catch (e) {
      print(' => failed after ${stopwatch.elapsedMilliseconds}ms ($e)');
      rethrow;
    }
  }

  @override
  TransactionExecutor beginTransaction(QueryExecutor parent) {
    print('begin');
    return super.beginTransaction(parent);
  }

  @override
  Future<void> commitTransaction(TransactionExecutor inner) {
    return _RunSql('commit', () => inner.send());
  }

  @override
  Future<void> rollbackTransaction(TransactionExecutor inner) {
    return _RunSql('rollback', () => inner.rollback());
  }

  @override
  Future<void> runBatched(QueryExecutor executor, BatchedStatements statements) {
    return _RunSql('batch with $statements', () => executor.runBatched(statements));
  }

  @override
  Future<int> runInsert(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql('$statement with $args', () => executor.runInsert(statement, args));
  }

  @override
  Future<int> runUpdate(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql('$statement with $args', () => executor.runUpdate(statement, args));
  }

  @override
  Future<int> runDelete(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql('$statement with $args', () => executor.runDelete(statement, args));
  }

  @override
  Future<void> runCustom(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql('$statement with $args', () => executor.runCustom(statement, args));
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql('$statement with $args', () => executor.runSelect(statement, args));
  }
}
