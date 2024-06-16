import 'package:flutter/material.dart';

class BookData with ChangeNotifier {
  int Id;
  late String Name;
  String? Icon;
  bool IsHided = false;
  late int OwnerUser;
  List<int>? MoreUsers;
  BookData(this.Id);
}
