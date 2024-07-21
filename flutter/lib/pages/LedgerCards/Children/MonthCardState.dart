import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';
import 'package:quick_log_money/pages/LedgerCards/CardStateBase.dart';

class MonthCardState extends CardStateBase {
  ///
  List<double> EveryDayMoneys = List.empty();

  ///
  double TotalMoney = 0;

  @override
  String get Title => "本月统计";

  @override
  String? get SubTitle => "${TotalMoney.toInt()}￥";

  @override
  double? get ContentHeight => 120;

  @override
  Future<FutureOr> RefreshState() async {
    final nowDate = DateTime.now();
    EveryDayMoneys = List.filled(DateTime(nowDate.year, nowDate.month + 2, 0).day, 0);
    final entries = await (LedgerDB.selectOnly(LedgerDB.ledgerEntries)
          ..addColumns([LedgerDB.ledgerEntries.IntMoney, LedgerDB.ledgerEntries.Date])
          ..where(LedgerDB.ledgerEntries.Date.isBiggerThanValue(DateTime(nowDate.year, nowDate.month))))
        .get();
    for (var entry in entries) {
      var money = LedgerUtility.GetRealMoney(entry.read(LedgerDB.ledgerEntries.IntMoney)!);
      TotalMoney += money;
      EveryDayMoneys[entry.read(LedgerDB.ledgerEntries.Date)!.day] += money;
    }
    setState(() => IsHasData = true);
  }

  @override
  Widget BuildContent() {
    // TotalMoney = 0;
    // for (var i = 0; i < EveryDayMoneys.length; i++) {
    //   EveryDayMoneys[i] = math.Random().nextInt(100000).toDouble();
    //   TotalMoney += EveryDayMoneys[i];
    // }

    final color = Theme.of(context).dividerColor;
    final nowDate = DateTime.now();

    const leftTitleCount = 4;
    final maxMoney = EveryDayMoneys.max;
    final moneyInterval = maxMoney / leftTitleCount;

    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [for (int i = leftTitleCount; i > 0; i--) Text(LedgerUtility.GetHumanMoney(moneyInterval * i))],
        ),
        Flexible(
          child: LineChart(LineChartData(
            borderData: FlBorderData(show: false),
            lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  fitInsideVertically: true,
                  fitInsideHorizontally: true,
                  getTooltipItems: (touchedSpots) => [
                    for (var item in touchedSpots)
                      LineTooltipItem("${DateTime(nowDate.year, nowDate.month, item.x.toInt()).ToSmartString()} ${item.y.ToSmartString()}￥", const TextStyle())
                  ],
                )),
            titlesData: const FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(color: color, spots: [
                for (var i = 0; i < EveryDayMoneys.length; i++) FlSpot((i + 1).toDouble(), EveryDayMoneys[i]),
              ])
            ],
          )),
        ),
      ],
    );
  }
}
