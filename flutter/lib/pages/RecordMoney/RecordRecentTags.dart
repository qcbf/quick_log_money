import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagListUI.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordEntryEditingProvider.dart';

class RecordRecentTags extends StatefulWidget {
  const RecordRecentTags({super.key});

  @override
  State<RecordRecentTags> createState() => _RecordRecentTagsState();
}

class _RecordRecentTagsState extends State<RecordRecentTags> {
  @override
  Widget build(BuildContext context) {
    return ConditionalValueListener.AsyncValue(Ledger.ExpenseTag, (context, value, child) => BuildTags());
  }

  ///
  Widget BuildTags() {
    var entry = context.read<RecordEntryEditingProvider>();
    if (entry.Tag.Id == 0) {
      entry.Tag = Ledger.ExpenseTag.value.AllTags[User.RecentTags.first]!;
      Future.delayed(Durations.short1, () => entry.Notify());
    }

    return TagListUI(
      entry.Tag.Id,
      User.RecentTags.map((e) => Ledger.ExpenseTag.value.AllTags[e]!).toList().reversed,
      (tag) => setState(() => entry
        ..Tag = tag
        ..Notify()),
      Physics: null,
    );
  }
}
