import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/pages/LedgerCards/CardBase.dart';

class WeekStatisCard extends StatelessWidget implements ICardable {
  @override
  final UserCard CardData;

  const WeekStatisCard(this.CardData, {super.key});

  @override
  Widget build(BuildContext context) {
    final nowDate = DateTime.now();
    final fromDate = nowDate.subtract(Duration(days: nowDate.weekday - 1));
    return LedgerCard(
      "本周",
      LedgerDB.managers.ledgerEntries.filter((f) => f.Date.isBetween(fromDate, fromDate.add(const Duration(days: 6)))).get(),
      (context, value) {
        return Column(
          children: [
            Row(children: [for (var i = 0; i < 7; i++) const Text("99\t\t\t\t\t")]),
            Row(children: [for (var i = 0; i < 7; i++) Text("周${i + 1}\t\t\t")]),
          ],
        );
      },
    );
  }
}
