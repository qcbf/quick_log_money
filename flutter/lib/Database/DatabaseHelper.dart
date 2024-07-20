import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';

class DatabaseHelper {
  static LazyDatabase OpenConnection(String name) {
    return LazyDatabase(() async {
      await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
      return NativeDatabase.createInBackground(File("${Def.LocalPath}$name"), isolateSetup: () async {
        open
          // ..overrideFor(OperatingSystem.windows, () => DynamicLibrary.open("sqlcipher.dll"))
          ..overrideFor(OperatingSystem.linux, () => DynamicLibrary.open("libsqlcipher.so"))
          ..overrideFor(OperatingSystem.android, openCipherOnAndroid);
      }, setup: (db) {
        final result = db.select("pragma cipher_version");
        if (result.isEmpty) {
          throw UnsupportedError("This database needs to run with SQLCipher, but that library is not available!");
        }
        db.execute("pragma key = \"$name.f\"");
      }).interceptWith(_SqlInterceptor());
    });
  }

  ///
  static bool? IsResetDatabase;
  static Future DebugTryResetDatabase(GeneratedDatabase db) async {
    if (kDebugMode) {
      if (IsResetDatabase == null) {
        var f = File("${Def.LocalPath}.\$del");
        if (IsResetDatabase = f.existsSync()) {
          f.renameSync("${Def.LocalPath}__used.\$del");
        }
      }
      if (IsResetDatabase == true) {
        final m = Migrator(db);
        for (final table in db.allTables) {
          await m.deleteTable(table.actualTableName);
          await m.createTable(table);
        }
      }
    }
  }
}

class _SqlInterceptor extends QueryInterceptor {
  Future<T> _RunSql<T>(String description, FutureOr<T> Function() operation) async {
    final stopwatch = Stopwatch()..start();
    try {
      final result = await operation();
      log(" Sql: $description => succeeded  ${stopwatch.elapsedMilliseconds}ms");
      return result;
    } on Object catch (e) {
      log(" Sql: $description => failed ${stopwatch.elapsedMilliseconds}ms ($e)");
      rethrow;
    }
  }

  @override
  TransactionExecutor beginTransaction(QueryExecutor parent) {
    log(" Transaction Begin");
    return super.beginTransaction(parent);
  }

  @override
  Future<void> commitTransaction(TransactionExecutor inner) {
    return _RunSql(" Transaction End commit", () => inner.send());
  }

  @override
  Future<void> rollbackTransaction(TransactionExecutor inner) {
    return _RunSql(" Transaction Rollback", () => inner.rollback());
  }

  @override
  Future<void> runBatched(QueryExecutor executor, BatchedStatements statements) {
    return _RunSql(" batch args: $statements", () => executor.runBatched(statements));
  }

  @override
  Future<int> runInsert(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql("$statement args: $args", () => executor.runInsert(statement, args));
  }

  @override
  Future<int> runUpdate(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql("$statement args: $args", () => executor.runUpdate(statement, args));
  }

  @override
  Future<int> runDelete(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql("$statement args: $args", () => executor.runDelete(statement, args));
  }

  @override
  Future<void> runCustom(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql("$statement args: $args", () => executor.runCustom(statement, args));
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(QueryExecutor executor, String statement, List<Object?> args) {
    return _RunSql("$statement args: $args", () => executor.runSelect(statement, args));
  }
}
