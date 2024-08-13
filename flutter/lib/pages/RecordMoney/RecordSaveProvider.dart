import 'package:flutter/material.dart';

class RecordSaveProvider with ChangeNotifier {
  bool _IsSaved = false;

  bool get IsSaved => _IsSaved;
  set IsSaved(bool value) {
    _IsSaved = value;
    notifyListeners();
  }
}
