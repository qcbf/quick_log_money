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
      });
    });
  }
}
