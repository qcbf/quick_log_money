import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/pages/LedgerCards/RecentDaysCard.dart';

enum ELedgerCardSpace {
  None,
  Home,
  Record,
}

class LedgerCardUtility {
  static Widget BuildLedgerCard(UserCard card) {
    String? cardName;
    String? cardParams;
    try {
      cardName = card.Name;
      cardParams = card.Params;
      return switch (cardName) {
        "WeekStatis" => RecentDaysCard(card),
        _ => Text("not found card ${card.Name}"),
      };
    } catch (e) {
      return Text("$cardName($cardParams)\n${e.toString()}");
    }
  }
  
  
}
