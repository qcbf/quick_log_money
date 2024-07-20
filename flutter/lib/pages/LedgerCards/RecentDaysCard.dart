import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';
import 'package:quick_log_money/pages/LedgerCards/CardBase.dart';

part 'RecentDaysCard.g.dart';

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
class RecentDaysCardState extends CardBaseConfigState<RecentDaysConfig> {
  List<(DateTime, double)> LedgerEntryMoneys = List.empty();

  @override
  String get Title => "最近账单";
  @override
  String? get SubTitle => RecentDaysTypeNames[Config.Type.index];
  @override
  double? get ContentHeight => 120;

  @override
  RecentDaysConfig CreateConfig() {
    return RecentDaysConfig.fromJson(jsonDecode(widget.CardData.Params ?? "{}"));
  }

  @override
  FutureOr RefreshState() {
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
    LedgerDB.managers.ledgerEntries.filter((f) => f.Date.isBetween(beginDate, endDate)).get().then((value) {
      final Map<DateTime, double> entriesMap = Map.fromEntries(List.generate(endDate.day - beginDate.day + 1, (i) => MapEntry(beginDate.add(Duration(days: i)), 0)));
      for (var item in value) {
        final date = item.Date;
        final key = DateTime(date.year, date.month, date.day);
        final v = LedgerUtility.GetRealMoney(item.IntMoney);
        entriesMap.update(key, (value) => value + v, ifAbsent: () => v);
      }
      LedgerEntryMoneys = entriesMap.entries.map((e) => (e.key, e.value)).toList();
      setState(() => IsHasData = true);
    });
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
              getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem("${rod.toY.ToSmartString()}￥", const TextStyle()),
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
  Widget BuildConfig(BuildContext context, void Function(VoidCallback) setState, RecentDaysConfig Config) {
    return SettingsList(shrinkWrap: true, sections: [
      SettingsSection(tiles: [
        SettingsTile(
          title: const Text("显示"),
          trailing: DropdownButton(
              alignment: AlignmentDirectional.center,
              value: Config.Type,
              items: ERecentDaysType.values.map((e) => DropdownMenuItem(value: e, child: Text(RecentDaysTypeNames[e.index]))).toList(),
              onChanged: (value) => setState(() => Config.Type = value!)),
        ),
      ])
    ]);
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




/*





*/

///最近天数统计
// class RecentDaysCardObsolete extends StatelessWidget implements IConfigCardable<RecentDaysConfig> {
//   @override
//   UserCard CardData;
//   RecentDaysCardObsolete(this.CardData, {super.key});

//   void UpdateCardData(UserCard cardData) {
//     CardData = cardData;
//   }

//   @override
//   Widget BuildConfigPanel(RecentDaysConfig newConfig, SetStateCallback setState) {
//     return SettingsList(shrinkWrap: true, sections: [
//       SettingsSection(tiles: [
//         SettingsTile(
//           title: const Text("显示"),
//           trailing: DropdownButton(
//               alignment: AlignmentDirectional.center,
//               value: newConfig.Type,
//               items: ERecentDaysType.values.map((e) => DropdownMenuItem(value: e, child: Text(RecentDaysTypeNames[e.index]))).toList(),
//               onChanged: (value) => setState(() => newConfig.Type = value!)),
//         ),
//       ])
//     ]);
//   }

//   @override
//   RecentDaysConfig CreateConfig() {
//     return RecentDaysConfig.fromJson(jsonDecode(CardData.Params ?? "{}"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cfg = CreateConfig();
//     log("config: ${cfg.toJson()}");
//     DateTime now = DateTime.now();
//     DateTime beginDate = DateTime(now.year, now.month, now.day - now.weekday + 1);
//     DateTime endDate = DateTime(now.year, now.month, now.day + (7 - now.weekday), 23, 59, 59);
//     return LedgerCardContainer(
//       this,
//       "最近账单",
//       SubTitle: RecentDaysTypeNames[cfg.Type.index],
//       LedgerDB.managers.ledgerEntries.filter((f) => f.Date.isBetween(beginDate, endDate)).get(),
//       (context, value) => _BuildContent(context, value),
//     );
//   }


// }
