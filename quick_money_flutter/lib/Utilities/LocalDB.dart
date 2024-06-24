import 'package:hive/hive.dart';

late LazyBox LocalDB;

class LocalDBHelper {
  static Future OpenLocalDB(String dir) async {
    Hive.init(dir);
    LocalDB = await Hive.openLazyBox("data");
  }
}
