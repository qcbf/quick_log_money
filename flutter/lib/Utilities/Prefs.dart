import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

late GlobalPrefsFields GlobalPrefs;
late UserPrefsFields UserPrefs;

///
class GlobalPrefsFields extends Prefs {
  ///
  late final PrefsItem<int> LoginUid = PrefsItem("LoginUid", this, 0, (name, value) => Prefs.LocalStorager.setInt(name, value));

  GlobalPrefsFields() : super("global");
}

///
class UserPrefsFields extends Prefs {
  ///
  late final PrefsItem<bool> IsFirstPageToRecord = PrefsItem("IsFirstPageToRecord", this, false, (name, value) => Prefs.LocalStorager.setBool(name, value));

  UserPrefsFields(super.Name);
}

// ======================================================

abstract class Prefs {
  static late final SharedPreferences LocalStorager;
  static Future<void> Init() async {
    LocalStorager = await SharedPreferences.getInstance();
  }

  final String Name;
  Prefs(this.Name);
}

class PrefsItem<T> extends ChangeNotifier implements ValueListenable<T> {
  final String Name;
  final Prefs Parent;
  final T DefaultValue;
  final Future<bool> Function(String name, T value) Setter;
  PrefsItem(this.Name, this.Parent, this.DefaultValue, this.Setter);
  @override
  T get value => Prefs.LocalStorager.get(Name) as T;
  bool get IsDefault => value == DefaultValue;

  set value(T newValue) {
    Setter(Name, newValue);
    notifyListeners();
  }
}
