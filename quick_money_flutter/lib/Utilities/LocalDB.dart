import 'package:path_provider/path_provider.dart';
import 'package:sqlite_async/sqlite_async.dart';

late SqliteDatabase LocalDB;

class LocalDBHelper {
  static Future OpenLocalDB(String name) async {
    final dir = await getApplicationSupportDirectory();
    final magrations = SqliteMigrations()..add(SqliteMigration(1, (tx) {
      
    }));

    LocalDB = SqliteDatabase(path: "${dir.path}/$name");
    magrations.migrate(LocalDB);
  }
}
