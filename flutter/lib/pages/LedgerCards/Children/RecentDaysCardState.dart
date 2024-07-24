import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';
import 'package:quick_log_money/pages/LedgerCards/CardStateBase.dart';

part 'RecentDaysCardState.g.dart';

///
const RecentDaysTypeNames = ["本周", "近七天", "近十四天"];

enum ERecentDaysType {
  CurrentWeek,
  SevenDays,
  Fourteen,
}

///
@JsonSerializable()
class RecentDaysConfig implements ICardConfigurable {
  ///
  ERecentDaysType Type = ERecentDaysType.CurrentWeek;

  RecentDaysConfig();
  factory RecentDaysConfig.fromJson(Map<String, dynamic> json) => json.isEmpty ? RecentDaysConfig() : _$RecentDaysConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RecentDaysConfigToJson(this);
}

///
class RecentDaysCardState extends CardConfigStateBase<RecentDaysConfig> {
  List<(DateTime, double)> LedgerEntryMoneys = List.empty();
  double TotalMoney = 0;

  @override
  String get Title => "最近账单";
  @override
  String? get SubTitle => "${RecentDaysTypeNames[Config.Type.index]} ${TotalMoney.toInt()}￥";
  @override
  double? get ContentHeight => 120;

  @override
  RecentDaysConfig CreateConfig() {
    return RecentDaysConfig.fromJson(jsonDecode(widget.CardData.Params ?? "{}"));
  }

  @override
  Future<FutureOr> RefreshState() async {
    setState(() => IsHasData = false);
    final DateTime now = DateTime.now();
    final DateTime beginDate;
    final DateTime endDate;
    switch (Config.Type) {
      case ERecentDaysType.CurrentWeek:
        beginDate = DateTime(now.year, now.month, now.day - now.weekday + 1);
        endDate = DateTime(now.year, now.month, now.day + (7 - now.weekday), 23, 59, 59);
        break;
      case ERecentDaysType.SevenDays:
        beginDate = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
        endDate = now;
      case ERecentDaysType.Fourteen:
        beginDate = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 13));
        endDate = now;
    }

    final entries = await LedgerDB.managers.ledgerEntries.filter((f) => f.Date.isBetween(beginDate, endDate)).get();
    final Map<DateTime, double> entriesMap = Map.fromEntries(List.generate(endDate.day - beginDate.day + 1, (i) => MapEntry(beginDate.add(Duration(days: i)), 0)));
    for (var item in entries) {
      final date = item.Date;
      final v = LedgerUtility.GetRealMoney(item.IntMoney);
      entriesMap.update(date.Today(), (value) => value + v, ifAbsent: () => v);
      TotalMoney += v;
    }
    LedgerEntryMoneys = entriesMap.entries.map((e) => (e.key, e.value)).toList();
    setState(() => IsHasData = true);
  }

  ///
  @override
  Widget BuildContent() {
    final color = Theme.of(context).dividerColor;
    return BarChart(BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              tooltipMargin: 0,
              fitInsideVertically: true,
              fitInsideHorizontally: true,
              tooltipPadding: EdgeInsets.zero,
              getTooltipColor: (group) => Colors.transparent,
              getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem(rod.toY.toStringAsFixed(0), const TextStyle()),
            )),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => GetLabelText(LedgerEntryMoneys[value.toInt()].$1))),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: List.generate(
            LedgerEntryMoneys.length,
            (i) => BarChartGroupData(
                  x: i,
                  showingTooltipIndicators: [0],
                  barRods: [
                    BarChartRodData(
                      width: Config.Type == ERecentDaysType.Fourteen ? null : 25,
                      toY: LedgerEntryMoneys[i].$2,
                      color: color,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(5), bottom: Radius.zero),
                    )
                  ],
                ))));
  }

  ///
  @override
  State CreateConfigState() {
    return RecentDaysCardSettingState();
  }

  ///
  Text GetLabelText(DateTime date) {
    if (Config.Type == ERecentDaysType.CurrentWeek) {
      return Text(switch (date.weekday) {
        DateTime.monday => "周一",
        DateTime.tuesday => "周二",
        DateTime.wednesday => "周三",
        DateTime.thursday => "周四",
        DateTime.friday => "周五",
        DateTime.saturday => "周六",
        DateTime.sunday => "周日",
        _ => throw Exception(),
      });
    } else if (Config.Type == ERecentDaysType.SevenDays) {
      return Text(date.ToSmartString(isShort: true));
    } else {
      return Text(date.day.toString());
    }
  }
}

class RecentDaysCardSettingState extends CardConfigSettingStateBase<RecentDaysConfig> {
  @override
  Widget BuildContent() {
    return ListTile(
      title: const Text("显示"),
      trailing: DropdownButton(
          alignment: AlignmentDirectional.center,
          value: Config.Type,
          items: ERecentDaysType.values.map((e) => DropdownMenuItem(value: e, child: Text(RecentDaysTypeNames[e.index]))).toList(),
          onChanged: (value) => setState(() => Config.Type = value!)),
    );
  }
}
