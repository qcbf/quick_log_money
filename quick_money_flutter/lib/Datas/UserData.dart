import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_money_flutter/Utilities/LocalDB.dart';

part "UserData.g.dart";

@JsonSerializable()
class UserData {
  int Id = 0;
  String? Token;
  String? Name;
  String? Icon;
  DateTime? VipExpiryDate;
  DateTime RegisterDate = DateTime.now();

  UserData();

  Map<String, dynamic> ToJson() => _$UserDataToJson(this);
  factory UserData.FromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}

class UserProvider with ChangeNotifier {
  UserData? _Data;

  ///
  UserData? get Data => _Data;

  ///
  static bool IsLogined = LocalDB.containsKey("User");

  UserProvider() {
    if (IsLogined) {
      LocalDB.get("User").then((json) {
        SetData(UserData.FromJson(jsonDecode(json)));
      });
    }
  }

  ///
  void SetData(UserData data) {
    _Data = data;
    notifyListeners();
  }

  ///
  Future Login() async {
    await Future.delayed(Durations.short1);
  }
}
