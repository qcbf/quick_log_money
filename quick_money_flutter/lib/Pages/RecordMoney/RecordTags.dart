import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagGroupUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';

/// 记账标签页
class RecordTags extends StatelessWidget {
  const RecordTags({super.key});

  @override
  Widget build(BuildContext context) {
    final ledgerData = context.read<LedgerProvider>().Ledger.Data;
    return TagGroupUI(
      context.read<EntryEditingProvider>().TagId,
      {for (var v in ledgerData.TagGroups) v.Name: v.Tags.map((id) => IdTagData(id, ledgerData.AllTags[id] ?? TagData.NotFound))},
      (tagId) {
        context.read<EntryEditingProvider>().TagId = tagId;
        (context as Element).markNeedsBuild();
      },
    );
  }
}
