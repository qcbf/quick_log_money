import 'package:flutter/material.dart';

class UserData {
  int Id = 0;
  String Token = "";
  String? Name;
  String? Icon;
  DateTime? VipExpiryDate;
  DateTime RegisterDate = DateTime.now();
}

class UserDataProvider with ChangeNotifier {
  UserData? Data;
}
