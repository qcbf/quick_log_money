import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';
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
    final ledger = context.read<LedgerProvider>().Ledger;
    return GridView.extent(
      maxCrossAxisExtent: 200,
      children: [
        Text(ledger.Data.Name),
      ],
    );
  }
}
