import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:quick_log_money/Datas/UserData.dart';

// GlobalPrefsDataDef GlobalPrefs = GlobalPrefsDataDef();
UserPrefsDataDef UserPrefs = UserPrefsDataDef();

// /// 全局所有用户首选项
// class GlobalPrefsDataDef extends Prefs {
//   /// 已经登录的uid
//   late final PrefsItem<int> UserUid = PrefsItem(this, "UserUid", 0);
//   @override
//   String? get Name => "static";
// }

/// 用户首选项
class UserPrefsDataDef extends Prefs {
  /// 最近记账标签
  late final PrefsItem<List<int>> RecentTags = PrefsItem(this, "RecentTags", List<int>.empty());

  /// 最近记账标签最大数量
  late final PrefsItem<int> RecentTagMaxCount = PrefsItem(this, "RecentTagMaxCount", 8);

  /// 是否首个页面打开记录账单页面
  late final PrefsItem<bool> IsFirstPageToRecord = PrefsItem(this, "IsFirstPageToRecord", false);

//========================================================================================================================
  @override
  String? get Name => UserDataProvider.Global.Id > 0 ? UserDataProvider.Global.Id.toString() : null;

  ///
  static Future<bool> TryInit() async {
    if (UserDataProvider.Global.Id > 0) {
      UserPrefs = UserPrefsDataDef();
      return UserPrefs.Init();
    }
    return false;
  }
}

/// 首选项容器
abstract class Prefs {
  late final Box? DB;
  String? get Name;

  ///
  Future<bool> Init() async {
    if (Name != null) {
      DB = await Hive.openBox("$Name.Prefs");
      return true;
    }
    return false;
  }

  ///
  Future Close() async {
    await DB?.close();
  }
}

/// 首选项每个项目
class PrefsItem<T> extends ChangeNotifier implements ValueListenable<T> {
  final Prefs Parent;
  final String Name;
  T _Value;
  bool _IsInited = false;

  @override
  T get value {
    if (!_IsInited && Parent.DB != null) {
      final newValue = Parent.DB!.get(Name);
      if (newValue != null) _Value = newValue;
      _IsInited = true;
    }
    return _Value;
  }

  set value(T newValue) {
    if (_Value == newValue) return;
    _Value = newValue;
    Parent.DB?.put(Name, _Value);
    notifyListeners();
  }

  PrefsItem(this.Parent, this.Name, this._Value);
}
