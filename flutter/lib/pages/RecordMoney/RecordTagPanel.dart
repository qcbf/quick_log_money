import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagGroupUI.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordSaveBtn.dart';

/// 记账标签页
class RecordTagPanel extends StatelessWidget {
  const RecordTagPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const RecordSaveBtn(),
        Expanded(child: BuildTagGroup(context)),
      ],
    );
  }

  ///
  TagGroupUI BuildTagGroup(BuildContext context) {
    return TagGroupUI(
      context.read<EntryEditingProvider>().TagId,
      {for (var v in Ledger.Tag.value.TagGroups) v.Name: v.Tags.map((id) => IdTagData(id, ledgerData.AllTags[id] ?? TagData.NotFound))},
      (tagId) {
        context.read<EntryEditingProvider>().TagId = tagId;
        (context as Element).markNeedsBuild();
      },
    );
  }
}
