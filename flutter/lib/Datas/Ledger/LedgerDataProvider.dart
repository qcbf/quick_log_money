import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerDao.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';
import 'package:quick_log_money/Datas/UserData.dart';

/// 账本实体事件容器
class LedgerDataProvider with ChangeNotifier implements ValueListenable<LedgerData> {
  static LedgerDataProvider Global = LedgerDataProvider();
  LedgerData? _Value;

  bool get IsInited => _Value != null;

  @override
  LedgerData get value => _Value!;

  ///
  Future Init() async {
    if (UserDataProvider.Global.value.Id == 0) return;
    await LedgerDao.InitedWating;
    final ledgerJson = await LedgerDao.GetLedger(UserDataProvider.Global.value.LedgerId);
    if (ledgerJson != null) {
      SetValue(LedgerData.fromJson(ledgerJson));
    }
  }

  ///
  Future SetValue(LedgerData? newValue) async {
    if (newValue?.Id == _Value?.Id) return;
    print("set ledger: ${newValue?.Id} ${newValue?.Name} ${newValue?.Type}");
    _Value = newValue;
    notifyListeners();
    if (UserDataProvider.Global.value.LedgerId != _Value?.Id) {
      await UserDataProvider.Global.SetValue(UserDataProvider.Global.value.copyWith.LedgerId(_Value?.Id ?? 0));
    }
  }

  Future Create(LedgerData data) async {
    var ledgerData = await LedgerData.CreateFromTemplate(UserDataProvider.Global.Id, Name: "临时账本");
    ledgerData = ledgerData.copyWith(Id: await LedgerDao.AddLedger(ledgerData.toJson()));
  }
}
