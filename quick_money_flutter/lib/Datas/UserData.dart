import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Utilities/LocalDB.dart';

part "UserData.g.dart";

@JsonSerializable(anyMap: true)
class UserData {
  final int Id;
  final String Name;
  final String? Token;
  final String? Icon;
  final DateTime? VipExpiryDate;
  final DateTime RegisterDate;

  const UserData({required this.Id, this.Name = "", required this.RegisterDate, this.Token, this.Icon, this.VipExpiryDate});

  factory UserData.FromJson(Map json) => _$UserDataFromJson(json);
  Map<String, dynamic> ToJson() => _$UserDataToJson(this);
}

class UserProvider with ChangeNotifier {
  ///
  static bool get IsLogined => LocalDB.containsKey("User");
  UserData _Data = UserData(Id: 0, RegisterDate: DateTime(0));

  UserProvider() {
    if (IsLogined) {
      LocalDB.get("User").then((json) {
        print("$json");
        SetData(UserData.FromJson(json!));
      });
    }
  }

  ///
  UserData get Data => _Data;

  ///
  Future Login() async {
    await Future.delayed(Durations.short1);
  }

  ///
  Future SetData(UserData data) async {
    _Data = data;
    await LocalDB.put("User", data.ToJson());
    notifyListeners();
  }
}
