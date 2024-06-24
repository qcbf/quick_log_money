import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

late Preference GlobalPreference;

class Preference {
  late Box DB;

  /// 是否首个页面打开记录账单页面
  late final PreferenceItem<bool> IsFirstPageToRecord = PreferenceItem(this, "IsFirstPageToRecord", false);

  /// 最近记账标签
  late final PreferenceItem<List<int>> RecentTags = PreferenceItem(this, "RecentTags", List<int>.empty());

  Preference._(this.DB);

  static Future Create(String name) async {
    final db = await Hive.openBox("Preference$name");
    return Preference._(db);
  }
}

class PreferenceItem<T> extends ChangeNotifier implements ValueListenable<T> {
  final Preference Parent;
  final String Name;
  T _Value;
  bool _IsInited = false;

  @override
  T get value {
    if (!_IsInited) {
      final newValue = Parent.DB.get(Name);
      if (newValue != null) _Value = newValue;
      _IsInited = true;
    }
    return _Value;
  }

  set value(T newValue) {
    _Value = newValue;
    Parent.DB.put(Name, _Value);
    notifyListeners();
  }

  PreferenceItem(this.Parent, this.Name, this._Value);
}
