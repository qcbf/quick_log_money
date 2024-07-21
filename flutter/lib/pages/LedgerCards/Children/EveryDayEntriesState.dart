import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/pages/LedgerCards/CardStateBase.dart';

part 'EveryDayEntriesState.g.dart';

@JsonSerializable()
class EveryDayEntriesConfig implements ICardConfigurable {
  ///
  int DaysCount = 1;

  ///
  int ContentHeight = 200;

  EveryDayEntriesConfig();
  factory EveryDayEntriesConfig.fromJson(Map<String, dynamic> json) => json.isEmpty ? EveryDayEntriesConfig() : _$EveryDayEntriesConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$EveryDayEntriesConfigToJson(this);
}

///
class EveryDayEntriesState extends CardConfigStateBase<EveryDayEntriesConfig> {
  @override
  String get Title => "账本条目";

  @override
  String? get SubTitle => "${Config.DaysCount}天";

  @override
  double? get ContentHeight => Config.ContentHeight.toDouble();

  @override
  Widget BuildContent() {
    return const Placeholder();
  }

  @override
  State CreateConfigState() {
    return EveryDayEntriesConfigState();
  }

  @override
  EveryDayEntriesConfig CreateConfig() {
    return EveryDayEntriesConfig.fromJson(jsonDecode(widget.CardData.Params ?? "{}"));
  }
}

///
class EveryDayEntriesConfigState extends CardConfigSettingStateBase<EveryDayEntriesConfig> {
  @override
  Widget BuildContent() {
    return SettingsList(shrinkWrap: true, sections: [
      SettingsSection(tiles: [
        _BuildInputItem("显示天数", [FilteringTextInputFormatter.digitsOnly], Config.DaysCount.toString(), (value) => Config.DaysCount = int.parse(value)),
        _BuildInputItem("卡片高度", [FilteringTextInputFormatter.digitsOnly], Config.ContentHeight.toString(), (value) => Config.ContentHeight = int.parse(value)),
      ])
    ]);
  }

  ///
  SettingsTile _BuildInputItem(String name, List<TextInputFormatter>? formatter, String initialValue, Function(String v) onChanged) {
    return SettingsTile(
      title: Text(name),
      trailing: SizedBox(
          width: 100,
          child: TextFormField(
            inputFormatters: formatter,
            initialValue: initialValue,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
          )),
    );
  }
}
