import 'package:drift/drift.dart' as drift;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
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
      (context, value) => _BuildContent(context, value),
    );
  }

  Widget _BuildContent(BuildContext context, Iterable<LedgerEntry> entries) {
    final chartItems = List<int>.filled(7, 0);
    for (var item in entries) {
      chartItems[item.Date.weekday] += item.IntMoney;
    }

    final col = Theme.of(context).dividerColor;
    return SizedBox(
      height: 100,
      child: BarChart(BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipMargin: 0,
                tooltipPadding: EdgeInsets.zero,
                getTooltipColor: (group) => Colors.transparent,
                getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem("${chartItems[groupIndex]}￥", const TextStyle()),
              )),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => Text(GetWeekWord(value.toInt() + 1)))),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: List.generate(
              chartItems.length,
              (i) => BarChartGroupData(
                    x: i,
                    showingTooltipIndicators: [0],
                    barRods: [
                      BarChartRodData(
                        width: 30,
                        toY: Utility.GetRealMoney(chartItems[i]),
                        color: col,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(2.5), bottom: Radius.zero),
                      )
                    ],
                  )))),
    );
  }

  ///将数字转换为中文字符
  static String GetWeekWord(int index) => switch (index) {
        1 => "周一",
        2 => "周二",
        3 => "周三",
        4 => "周四",
        5 => "周五",
        6 => "周六",
        7 => "周日",
        _ => "X",
      };
}
