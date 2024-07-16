import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/pages/LedgerCards/LedgerCardUtility.dart';

class CardList extends StatefulWidget {
  final ELedgerCardSpace Space;
  const CardList(this.Space, {super.key});
  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  List<UserCard>? Cards;

  @override
  void initState() {
    UserDB.managers.userCards.filter((f) => f.Uid(User.Info.Id) & f.Place(widget.Space)).get().then((value) => setState(() => Cards = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Conditional.Single(() => Cards != null, () {
      return ListView(children: [for (var card in Cards!) LedgerCardUtility.BuildLedgerCard(card)]);
    });
  }
}
