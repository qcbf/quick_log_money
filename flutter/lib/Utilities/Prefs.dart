import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  ///
  static final PrefsItem<bool> IsFirstPageToRecord = PrefsItem("IsFirstPageToRecord", false, (name, value) => Prefs.LocalStorager.setBool(name, value));

// ======================================================================================
  static late final SharedPreferences LocalStorager;
  static int get UserId => LocalStorager.getInt("UserId") ?? 0;
  static set UserId(int v) => LocalStorager.setInt("UserId", v);
  static bool get IsNotUserId => UserId == 0;
  static void SetNotUserId() => UserId = 0;
  static Future Init() async {
    SharedPreferences.setPrefix("f.");
    LocalStorager = await SharedPreferences.getInstance();
  }
}

///
class PrefsItem<T> extends ChangeNotifier implements ValueListenable<T> {
  final String Name;
  final T DefaultValue;
  final Future<bool> Function(String name, T value) Setter;
  PrefsItem(this.Name, this.DefaultValue, this.Setter);
  bool get IsDefault => value == DefaultValue;
  @override
  T get value => Prefs.LocalStorager.get("${Prefs.UserId}.$Name") as T;
  set value(T newValue) {
    Setter("${Prefs.UserId}.$Name", newValue);
    notifyListeners();
  }
}
