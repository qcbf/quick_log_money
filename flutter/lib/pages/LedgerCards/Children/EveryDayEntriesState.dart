import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/EntryGroups.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';
import 'package:quick_log_money/pages/LedgerCards/CardStateBase.dart';

part 'EveryDayEntriesState.g.dart';

@JsonSerializable()
class EveryDayEntriesConfig implements ICardConfigurable {
  ///
  int DaysCount = 3;

  ///
  int ContentHeight = 0;

  EveryDayEntriesConfig();
  factory EveryDayEntriesConfig.fromJson(Map<String, dynamic> json) => json.isEmpty ? EveryDayEntriesConfig() : _$EveryDayEntriesConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$EveryDayEntriesConfigToJson(this);
}

///
class EveryDayEntriesState extends CardConfigStateBase<EveryDayEntriesConfig> {
  late Stream<List<LedgerEntry>> Entries;

  @override
  String get Title => "账本条目";

  @override
  double? get ContentHeight => Config.ContentHeight == 0 ? null : Config.ContentHeight.toDouble();

  @override
  FutureOr RefreshState() async {
    Entries = LedgerDB.managers.ledgerEntries
        .filter((f) => f.Date.isAfter(DateTime.now().Today().subtract(Duration(days: Config.DaysCount - 1))))
        .orderBy((o) => o.Date.desc())
        .watch();
    setState(() => IsHasData = true);
  }

  @override
  Widget BuildContent() {
    return StreamBuilder(
      stream: Entries,
      builder: (context, snapshot) {
        if (snapshot.data?.isEmpty != false) return const Center(child: Text("暂无记录..."));
        return EntryGroups.List(snapshot.data!);
      },
    );
  }

  @override
  Widget BuildHeadTitle() {
    return StreamBuilder(
        stream: Entries,
        builder: (context, v) {
          var totalMoney = v.data?.fold(0, (previousValue, element) => previousValue + element.IntMoney) ?? 0;
          return Text("$Title (近${Config.DaysCount}天 ${LedgerUtility.GetRealMoneyStr(totalMoney)}￥)");
        });
  }

  @override
  State CreateConfigState() {
    return EveryDayEntriesSettingState();
  }

  @override
  EveryDayEntriesConfig CreateConfig() {
    return EveryDayEntriesConfig.fromJson(jsonDecode(widget.CardData.Params ?? "{}"));
  }
}

///
class EveryDayEntriesSettingState extends CardConfigSettingStateBase<EveryDayEntriesConfig> {
  @override
  Widget BuildContent() {
    return Column(children: [
      ListTile(
        title: const Text("显示天数"),
        trailing: SizedBox(
            width: 60,
            child: _BuildNumberInput([FilteringTextInputFormatter.digitsOnly], Config.DaysCount.toString(), (value) => Config.DaysCount = int.parse(value), maxLength: 2)),
      ),
      ListTile(
        title: const Text("卡片高度"),
        trailing: _BuildContentHeight(),
      )
    ]);
  }

  ///
  Widget _BuildContentHeight() {
    final isAutoHeight = Config.ContentHeight == 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isAutoHeight)
          SizedBox(
              width: 60,
              child: _BuildNumberInput(
                [FilteringTextInputFormatter.digitsOnly],
                Config.ContentHeight.toString(),
                (v) => Config.ContentHeight = int.parse(v),
              )),
        const Text("自动"),
        Switch(value: isAutoHeight, onChanged: (v) => setState(() => Config.ContentHeight = v ? 0 : 200)),
      ],
    );
  }

  ///
  Widget _BuildNumberInput(List<TextInputFormatter>? formatter, String initialValue, Function(String v) onChanged, {int maxLength = 4}) {
    return TextFormField(
      maxLength: maxLength,
      inputFormatters: formatter,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(isDense: true, counterText: ""),
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }
}
