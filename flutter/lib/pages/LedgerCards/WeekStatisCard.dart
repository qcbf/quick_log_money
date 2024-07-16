import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/pages/LedgerCards/CardBase.dart';

class WeekStatisCard extends StatelessWidget with CardBase {
  const WeekStatisCard({super.key});

  @override
  Widget build(BuildContext context) {
    final nowDate = DateTime.now();
    final fromDate = nowDate.subtract(Duration(days: nowDate.weekday - 1));
    return FutureBuilder(
        future: LedgerDB.managers.ledgerEntries.filter((f) => f.Date.isBetween(fromDate, fromDate.add(const Duration(days: 6)))).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Conditional.GlobalFallback();
          return Container();
        });
  }
}
