import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

GlobalPrefsDef GlobalPrefs = GlobalPrefsDef();
UserPrefsDef UserPrefs = UserPrefsDef();

/// 全局所有用户首选项
class GlobalPrefsDef extends Prefs {
  /// 已经登录的uid
  late final PrefsItem<int> UserUid = PrefsItem(this, "UserUid", 0);
  @override
  String? get Name => "";
}

/// 用户首选项
class UserPrefsDef extends Prefs {
  /// 最近记账标签
  late final PrefsItem<List<int>> RecentTags = PrefsItem(this, "RecentTags", List<int>.empty());

  /// 是否首个页面打开记录账单页面
  late final PrefsItem<bool> IsFirstPageToRecord = PrefsItem(this, "IsFirstPageToRecord", false);

//========================================================================================================================
  @override
  String? get Name => GlobalPrefs.UserUid.value > 0 ? GlobalPrefs.UserUid.value.toString() : null;

  ///
  static Future<bool> TryInit() async {
    if (GlobalPrefs.UserUid.value > 0) {
      UserPrefs = UserPrefsDef();
      return UserPrefs.Init();
    }
    return false;
  }
}

abstract class Prefs {
  late final Box? _LocalDB;
  String? get Name;

  ///
  Future<bool> Init() async {
    if (Name != null) {
      _LocalDB = await Hive.openBox("Prefs$Name");
      return true;
    }
    return false;
  }

  ///
  Future Close() async {
    await _LocalDB?.close();
  }
}

class PrefsItem<T> extends ChangeNotifier implements ValueListenable<T> {
  final Prefs Parent;
  final String Name;
  T _Value;
  bool _IsInited = false;

  @override
  T get value {
    if (!_IsInited && Parent._LocalDB != null) {
      final newValue = Parent._LocalDB!.get(Name);
      if (newValue != null) _Value = newValue;
      _IsInited = true;
    }
    return _Value;
  }

  set value(T newValue) {
    _Value = newValue;
    Parent._LocalDB?.put(Name, _Value);
    notifyListeners();
  }

  PrefsItem(this.Parent, this.Name, this._Value);
}
