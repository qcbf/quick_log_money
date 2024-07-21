import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/pages/LedgerCards/CardWidget.dart';

class CardList extends StatefulWidget {
  final ELedgerCardSpace Space;
  const CardList(this.Space, {super.key});
  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  Iterable<UserCard>? Cards;

  @override
  void initState() {
    UserDB.managers.userCards.filter((f) => f.Uid(User.Info.Id) & f.Place(widget.Space)).get().then((value) => setState(() => Cards = [
          ...value,
          UserCard(Id: 1, Uid: User.Info.Id, Place: ELedgerCardSpace.Record, Name: "RecentDays"),
          UserCard(Id: 1, Uid: User.Info.Id, Place: ELedgerCardSpace.Record, Name: "EveryDayEntries"),
          UserCard(Id: 1, Uid: User.Info.Id, Place: ELedgerCardSpace.Record, Name: "Month"),
        ]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Conditional.Single(() => Cards != null, () {
      return ListView(children: [for (var card in Cards!) CardWidget(card)]);
    });
  }
}
