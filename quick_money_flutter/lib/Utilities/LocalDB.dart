import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

late LazyBox LocalDB;

class LocalDBHelper {
  static Future Init() async {
    Hive.init((await getApplicationSupportDirectory()).path);
    LocalDB = await Hive.openLazyBox("global");
  }
}
