import 'package:collection/collection.dart';
import 'package:d_chart/d_chart.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';
import 'package:quick_log_money/pages/LedgerCards/CardBase.dart';

///最近天数统计
class RecentDaysCard extends StatelessWidget implements ICardable {
  @override
  final UserCard CardData;

  const RecentDaysCard(this.CardData, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime beginDate = DateTime(now.year, now.month, now.day - now.weekday + 1);
    DateTime endDate = DateTime(now.year, now.month, now.day + (7 - now.weekday), 23, 59, 59);
    return LedgerCard(
      "本周",
      LedgerDB.managers.ledgerEntries.filter((f) => f.Date.isBetween(beginDate, endDate)).get(),
      (context, value) => _BuildContent(value),
    );
  }

  Widget _BuildContent(Iterable<LedgerEntry> entries) {
    final map = entries.groupFoldBy<int, int>((e) => e.Date.weekday, (last, now) => (last ?? 0) + now.IntMoney);
    return SizedBox(
        height: 80,
        child: DChartBarO(groupList: [
          OrdinalGroup(
            id: "",
            data: map.entries.map((e) => OrdinalData(domain: "周${e.key}", measure: Utility.IntMoneyToNumber(e.value))).toList(),
          )
        ]));
  }
}
