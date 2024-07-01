import 'package:flutter/material.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerEntity.dart';
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
        Text(LedgerProvider.Global.value.Data.Name),
      ],
    );
  }
}
