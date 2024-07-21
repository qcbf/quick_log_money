import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/pages/LedgerCards/Children/EveryDayEntriesState.dart';
import 'package:quick_log_money/pages/LedgerCards/Children/MonthCardState.dart';
import 'package:quick_log_money/pages/LedgerCards/Children/RecentDaysCardState.dart';

enum ELedgerCardSpace {
  None,
  Home,
  Record,
}

class CardWidget extends StatefulWidget {
  final UserCard CardData;
  const CardWidget(this.CardData, {super.key});
  @override
  // ignore: no_logic_in_create_state
  State createState() {
    String? cardName;
    String? cardParams;
    try {
      cardName = CardData.Name;
      cardParams = CardData.Params;
      return switch (cardName) {
        "RecentDays" => RecentDaysCardState(),
        "Month" => MonthCardState(),
        "EveryDayEntries" => EveryDayEntriesState(),
        _ => throw Exception("not found card $cardName"),
      };
    } catch (e) {
      throw Exception("$cardName($cardParams)\n${e.toString()}");
    }
  }
}
