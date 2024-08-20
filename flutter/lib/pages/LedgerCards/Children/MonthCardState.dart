import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';
import 'package:quick_log_money/pages/LedgerCards/CardStateBase.dart';

class MonthCardState extends CardStateBase {
  ///
  List<double> EveryDayMoneys = List.empty();

  ///
  late Stream<List<drift.TypedResult>> DBStream;

  ///
  double TotalMoney = 0;

  @override
  String get Title => "本月统计";

  @override
  double? get ContentHeight => 120;

  @override
  Future<FutureOr> RefreshState() async {
    final nowDate = DateTime.now();
    EveryDayMoneys = List.filled(DateTime(nowDate.year, nowDate.month + 2, 0).day, 0);
    DBStream = (LedgerDB.selectOnly(LedgerDB.ledgerEntries)
          ..addColumns([LedgerDB.ledgerEntries.IntMoney, LedgerDB.ledgerEntries.Date])
          ..where(LedgerDB.ledgerEntries.Date.isBiggerThanValue(DateTime(nowDate.year, nowDate.month))))
        .watch();
    super.RefreshState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DBStream, builder: (context, snapshot) => BuildContainer(BuildHeadbar, snapshot.hasData ? () => _BuildContent(snapshot.data!) : Conditional.GlobalFallback));
  }

  Widget _BuildContent(List<drift.TypedResult> data) {
    final color = Theme.of(context).dividerColor;
    final nowDate = DateTime.now();
    const leftTitleCount = 4;
    TotalMoney = 0;
    EveryDayMoneys.fillRange(0, EveryDayMoneys.length, 0);
    for (var entry in data) {
      var money = LedgerUtility.GetRealMoney(entry.read(LedgerDB.ledgerEntries.IntMoney)!);
      TotalMoney += money;
      EveryDayMoneys[entry.read(LedgerDB.ledgerEntries.Date)!.day] += money;
    }

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

  @override
  Widget BuildHeadTitle() {
    return Text("$Title (${TotalMoney.ToSmartString()}￥)");
  }
}
