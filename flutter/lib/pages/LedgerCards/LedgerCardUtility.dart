import 'package:flutter/material.dart';
import 'package:quick_log_money/pages/LedgerCards/WeekStatis.dart';

class LedgerCardUtility {
  Widget BuildLedgerCard(String name, Map<String, dynamic> param) {
    return switch (name) {
      "WeekStatis" => const WeekStatis(),
      _ => const Text("not found"),
    };
  }
}
