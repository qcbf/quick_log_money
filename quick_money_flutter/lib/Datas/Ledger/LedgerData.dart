import 'package:flutter/material.dart';
import 'package:quick_money_flutter/Datas/Ledger/EntryData.dart';
import 'package:quick_money_flutter/Datas/Ledger/TagData.dart';

class LedgerData with ChangeNotifier {
  int Id;
  late String Name;
  String? Icon;
  bool IsHided = false;
  List<EntryData>? Entries;
  late List<TagData> Tags;
  late int OwnerUser;
  List<int>? MoreUsers;

  LedgerData(this.Id);
}
