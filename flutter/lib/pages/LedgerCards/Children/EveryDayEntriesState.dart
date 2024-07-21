import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quick_log_money/pages/LedgerCards/CardStateBase.dart';

part 'EveryDayEntriesState.g.dart';

@JsonSerializable()
class EveryDayEntriesConfig implements ICardConfigurable {
  ///
  int DaysCount = 1;

  ///
  double ContentHeight = 200;

  EveryDayEntriesConfig();
  factory EveryDayEntriesConfig.fromJson(Map<String, dynamic> json) => json.isEmpty ? EveryDayEntriesConfig() : _$EveryDayEntriesConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$EveryDayEntriesConfigToJson(this);
}

class EveryDayEntriesState extends CardConfigStateBase<EveryDayEntriesConfig> {
  @override
  String get Title => "账本条目";

  @override
  String? get SubTitle => "${Config.DaysCount}天";

  @override
  double? get ContentHeight => Config.ContentHeight;

  @override
  Widget BuildConfig(BuildContext context, void Function(VoidCallback p1) setState, ICardConfigurable newConfig) {
    return Text("data");
  }

  @override
  Widget BuildContent() {
    
    return Text("context");
  }

  @override
  EveryDayEntriesConfig CreateConfig() {
    return EveryDayEntriesConfig.fromJson(jsonDecode(widget.CardData.Params ?? "{}"));
  }
}
