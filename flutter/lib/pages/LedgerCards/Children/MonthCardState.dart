import 'package:flutter/material.dart';
import 'package:quick_log_money/pages/LedgerCards/CardStateBase.dart';

class MonthCardState extends CardStateBase {
  @override
  String get Title => "本月统计";

  @override
  double? get ContentHeight => 150;

  @override
  Widget BuildContent() {
    return const Placeholder();
  }
}
