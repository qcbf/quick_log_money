import 'package:json_annotation/json_annotation.dart';
import 'package:quick_money_flutter/Utilities/LocalDB.dart';

part 'Preference.g.dart';

@JsonSerializable(checked: true)
class Preference {
  static late Preference Global;

  bool IsFirstPageIsRecord = false;

  Preference();

  static Future InitGlobal() async {
    Global = Preference.FromJson(await LocalDB.get("Preference") ?? {});
  }

  static Future SaveGlobal() async {
    LocalDB.put("Preference", Global.ToJson());
  }

  Map<String, dynamic> ToJson() => _$PreferenceToJson(this);
  factory Preference.FromJson(Map<String, dynamic> json) => _$PreferenceFromJson(json);
}
