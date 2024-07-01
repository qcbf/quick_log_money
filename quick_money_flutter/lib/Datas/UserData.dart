import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';

part "UserData.g.dart";

/// 用户数据
@JsonSerializable(anyMap: true)
class UserData {
  final int Id;
  final int LedgerId;
  final String Name;
  final String? Token;
  final String? Icon;
  final DateTime? VipExpiryDate;
  final DateTime RegisterDate;

  const UserData(
      {required this.Id,
      this.LedgerId = 0,
      this.Name = "",
      required this.RegisterDate,
      this.Token,
      this.Icon,
      this.VipExpiryDate});

  factory UserData.FromJson(Map json) => _$UserDataFromJson(json);
  Map<String, dynamic> ToJson() => _$UserDataToJson(this);
}

/// 用户数据提供者
class UserDataProvider with ChangeNotifier implements ValueListenable<UserData> {
  ///
  static final UserDataProvider Global = UserDataProvider();

  ///
  UserData _Value = UserData(Id: 0, RegisterDate: DateTime(0));

  ///
  int get Id => _Value.Id;

  ///
  @override
  UserData get value => _Value;

  ///
  Future Init() async {
    final db = await _OpenDB();
    _Value = UserData.FromJson(db.getAt(0));
  }

  ///获取本地数据库
  Future<Box> _OpenDB() async {
    return await Hive.openBox("~");
  }

  ///登录
  Future Login() async {
    await Future.delayed(Durations.short1);
  }

  ///
  Future SetValue(UserData? val) async {
    print("Set User: ${val?.ToJson()}");
    if (val == null) {
      UserPrefs.Close();
      _Value = UserData(Id: 0, RegisterDate: DateTime(0));
    } else {
      _Value = val;
      UserPrefsDataDef.TryInit();
    }
    final db = await _OpenDB();
    db.putAt(0, _Value.ToJson());
    await db.close();
    notifyListeners();
  }
}
