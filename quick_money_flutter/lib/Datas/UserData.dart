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
  final String Name;
  final String? Token;
  final String? Icon;
  final DateTime? VipExpiryDate;
  final DateTime RegisterDate;
  final int LedgerId;

  const UserData(
      {required this.Id,
      this.Name = "",
      this.LedgerId = 0,
      required this.RegisterDate,
      this.Token,
      this.Icon,
      this.VipExpiryDate});

  factory UserData.FromJson(Map json) => _$UserDataFromJson(json);
  Map<String, dynamic> ToJson() => _$UserDataToJson(this);
}

/// 用户数据提供者
class UserDataProvider with ChangeNotifier implements ValueListenable<UserData> {
  static final UserDataProvider Global = UserDataProvider();
  int Id = 0;
  UserData _Value = UserData(Id: 0, RegisterDate: DateTime(0));

  @override
  UserData get value => _Value;

  ///
  Future Init() async {
    final db = await _OpenDB();
    try {
      Id = await db.get("Id", defaultValue: 0);
      db.get("Data").then((dataJson) {
        if (dataJson != null) SetValue(UserData.FromJson(dataJson));
      });
    } finally {
      db.close();
    }
  }

  ///获取本地数据库
  Future<LazyBox> _OpenDB() async {
    return await Hive.openLazyBox("~");
  }

  ///登录
  Future Login() async {
    await Future.delayed(Durations.short1);
  }

  ///
  Future SetValue(UserData? val) async {
    if (val == null) {
      Id = 0;
      UserPrefs.Close();
      _Value = UserData(Id: 0, RegisterDate: DateTime(0));
    } else {
      if (Id != val.Id) {
        _Value = val;
        Id = val.Id;
        final db = await _OpenDB();
        await db.putAll({"Id": Id, "Data": val.ToJson()});
        await db.close();
        UserPrefsDataDef.TryInit();
      } else {
        //todo: 登录错误
      }
    }
    notifyListeners();
  }
}
