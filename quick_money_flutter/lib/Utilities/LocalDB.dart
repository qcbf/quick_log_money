import 'package:path_provider/path_provider.dart';
import 'package:sqlite_async/sqlite_async.dart';

late SqliteDatabase LocalDB;
SqliteMigrations LocalDBMigrations = SqliteMigrations();

class LocalDBInitializer {
  static Future Init() async {
    final dir = (await getApplicationSupportDirectory()).path;
    LocalDB = SqliteDatabase(path: "$dir/local");
    LocalDBMigrations.migrate(LocalDB);
  }
}
