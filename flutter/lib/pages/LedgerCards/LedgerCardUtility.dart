import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/pages/LedgerCards/WeekStatisCard.dart';

enum ELedgerCardSpace {
  None,
  Home,
  Record,
}

class LedgerCardUtility {
  static Widget BuildLedgerCard(UserCard card) {
    return switch (card.Name) {
      "WeekStatis" => WeekStatisCard(card),
      _ => Text("not found card ${card.Name}"),
    };
  }
}
