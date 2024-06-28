class Prefs {
    
  String? get Name;

  ///
  Future<bool> Init() async {
    if (Name != null) {
      _LocalDB = await Hive.openBox("Prefs$Name");
      return true;
    }
    return false;
  }

  ///
  Future Close() async {
    await _LocalDB?.close();
  }
}
}
