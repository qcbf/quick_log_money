import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Utilities/LocalDB.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';
import 'package:sqlite_async/sqlite_async.dart';

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
  UserData _Data = UserData(Id: 0, RegisterDate: DateTime(0));

  ///
  UserData get Data => _Data;

  ///
  Future Login() async {
    
    await Future.delayed(Durations.short1);
  }

  ///
  Future SetData(UserData? data) async {
    if (data == null) {
      GlobalPrefs.UserUid.value = 0;
      UserPrefs.Close();
    } else {
      _Data = data;
      if (_Data.Id != GlobalPrefs.UserUid.value) {
        await LocalDB.put("User", data.ToJson());
        GlobalPrefs.UserUid.value = data.Id;
        UserPrefsDataDef.TryInit();
      } else {
        //todo: 登录错误
      }
    }
    notifyListeners();
  }
}
