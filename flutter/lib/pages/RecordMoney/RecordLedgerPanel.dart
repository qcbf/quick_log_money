import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordSaveBtn.dart';

class RecordLedgerPanel extends StatelessWidget {
  const RecordLedgerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const RecordSaveBtn(),
      Expanded(child: BuildLedgerList(context)),
    ]);
  }

  Widget BuildLedgerList(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 200,
      children: [
        Text(Ledger.Info.value.Name),
      ],
    );
  }
}
