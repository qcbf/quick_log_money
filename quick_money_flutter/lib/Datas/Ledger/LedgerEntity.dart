import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/EntryData.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerDao.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';

/// 账本实体事件容器
class LedgerProvider with ChangeNotifier implements ValueListenable<LedgerBase> {
  static LedgerProvider Global = LedgerProvider();
  LedgerBase<LedgerData>? _Value;

  @override
  LedgerBase<LedgerData> get value => _Value!;

  bool get IsInited => _Value != null;

  ///
  Future TryInit() async {
    await LedgerDao.InitedWating;

    // final db = await _OpenDB();
    // try {
    //   final ledgerRawData = await db.get(UserDataProvider.Global.Id);
    //   if (ledgerRawData != null) {
    //     final ledger = CreateLedgerFromData(LedgerData.fromJson(jsonDecode(ledgerRawData)));
    //     _Value = ledger;
    //     notifyListeners();
    //   }
    // } finally {
    //   db.close();
    // }
  }

  ///
  Future SetLedger(LedgerBase? newValue) async {
    // if (newValue == _Value) return;
    // print("set ledger: ${newValue?.Data.Id} ${newValue?.Data.Name} ${newValue?.Data.Type}");
    // _Value = newValue;
    // notifyListeners();
    // Dao.DB.execute("sql");
    // final db = await _OpenDB();
    // try {
    //   if (newValue == null) {
    //     await db.delete(UserDataProvider.Global.Id);
    //   } else {
    //     await db.put(UserDataProvider.Global.Id, jsonEncode(newValue.Data.toJson()));
    //   }
    // } finally {
    //   await db.close();
    // }
  }

  ///
  static LedgerBase CreateLedgerFromData(LedgerData data) {
    return switch (data.Type) {
      // 1 => LocalLedger(data),
      // 2 => ServerLedger(data),
      3 => AnonymLedger(data),
      _ => throw Exception(""),
    };
  }
}

/// 账本基类
abstract class LedgerBase<TData extends LedgerData> {
  final TData Data;
  const LedgerBase(this.Data);

  ///
  void InteractivePushEntry(EntryData data) {
    final cancelLoading = BotToast.showLoading(duration: const Duration(days: 1));
    PushEntry(data).then((_) => cancelLoading());
  }

  ///
  Future PushEntry(EntryData data) async {
    // final box = await Hive.openLazyBox("${UserDataProvider.Global.Id}.ledger.entries");
    // try {
    //   if (box.length > 9999999) {
    //     BotToast.showSimpleNotification(title: "保存失败", subTitle: "已经存在过多的本地缓存数据");
    //     return;
    //   }

    //   await box.add(data.toJson());
    //   SyncEntries();
    // } finally {
    //   await box.flush();
    //   box.close();
    // }
  }

  FutureOr SyncEntries();
}

/// 本地账本
// class LocalLedger extends LedgerBase<LedgerData> {
//   const LocalLedger(super.Data);
//   @override
//   Future PushEntry(EntryData data) {}
// }

/// 匿名账本
class AnonymLedger extends LedgerBase<LedgerData> {
  const AnonymLedger(super.Data);

  @override
  FutureOr SyncEntries() {
    BotToast.showSimpleNotification(title: "同步到临时账本", subTitle: "注意：当前是临时账号，数据存在丢失风险，请尽快登录!");
  }
}

/// 网络账本
// class ServerLedger extends LedgerBase<LedgerData> {
//   const ServerLedger(super.Data);
//   @override
//   Future PushEntry(EntryData data) {}
// }
