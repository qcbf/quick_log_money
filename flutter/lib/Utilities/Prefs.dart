import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  ///
  static final PrefsItem<bool> IsFirstPageToRecord = PrefsItem("IsFirstPageToRecord", false, (name, value) async => await Prefs.LocalStorager.setBool(name, value));

// ======================================================================================
  static late final SharedPreferences LocalStorager;

  static String get UserToken => LocalStorager.getString("Token") ?? "";
  static set UserToken(String v) => LocalStorager.setString("Token", v);

  static bool get IsLogined => UserToken.isNotEmpty;

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
  T get value => Prefs.LocalStorager.get("${User.Id}.$Name") as T? ?? DefaultValue;
  set value(T newValue) {
    Setter("${User.Id}.$Name", newValue).then((value) => notifyListeners());
  }
}
