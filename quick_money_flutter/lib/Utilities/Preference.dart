import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Utilities/LocalDB.dart';

part 'Preference.g.dart';

late Preference GlobalPreference;

@JsonSerializable()
class Preference {
  @JsonKey(defaultValue: false)
  bool IsFirstPageIsRecord;

  Preference({required this.IsFirstPageIsRecord});

  static Future InitGlobal() async {
    GlobalPreference = Preference.FromJson(await LocalDB.get("Preference") ?? {});
  }

  static Future SaveGlobal() async {
    LocalDB.put("Preference", GlobalPreference.ToJson());
  }

  Map<String, dynamic> ToJson() => _$PreferenceToJson(this);
  factory Preference.FromJson(Map<String, dynamic> json) => _$PreferenceFromJson(json);
}
