import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_money_flutter/Datas/Ledger/Entry/EntryData.dart';
import 'package:quick_money_flutter/Datas/Ledger/Entry/TagData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LedgerData {
  int Id = 0;
  String? Name;
  String? Icon;
  bool IsHided = false;
  List<EntryData> Entries = List.empty();
  List<TagData> Tags = List.empty();
  late int OwnerUser;
  List<int>? MoreUsers;
}

class LedgerProvider with ChangeNotifier {
  LedgerData? Data;

  Future LoadDefault() async {
    final local = await SharedPreferences.getInstance();
    final json = local.getString("DefaultLedger");
    if (json == null) {
    } else {
      Data = jsonDecode(json);
    }
  }
}
