import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
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
    return ConditionalValueListener.AsyncValue(
      Ledger.ExpenseTag,
      (context, value, child) {
        var entry = context.read<RecordEntryEditingProvider>();
        if (entry.Tag.Id == 0) {
          entry.Tag = Ledger.ExpenseTag.value.AllTags[User.RecentTags.firstOrNull] ?? _CreateEmptyTagData();
        }
        return BuildTags(User.RecentTags.map((e) => Ledger.ExpenseTag.value.AllTags[e]!).toList().reversed);
      },
      Fallback: () => BuildTags(List<LedgerTag>.filled(8, _CreateEmptyTagData())),
    );
  }

  ///
  LedgerTag _CreateEmptyTagData() => const LedgerTag(Id: 0, Group: "", Name: "...", Icon: "");

  ///
  Widget BuildTags(Iterable<LedgerTag> Tags) {
    return Wrap(
      children: [for (var tag in Tags) BuildTag(context, tag)],
    );
  }

  ///
  Widget BuildTag(BuildContext context, LedgerTag tagData) {
    var entry = context.read<RecordEntryEditingProvider>();
    final isSelected = tagData.Id == entry.Tag.Id;
    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: TagUI(
          BtnStyle: isSelected ? ButtonStyle(side: WidgetStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.primary, width: 1))) : null,
          ContentColor: isSelected ? Colors.blue : null,
          tagData,
          () {
            setState(() {
              entry
                ..Tag = tagData
                ..Notify();
            });
          },
        ),
      ),
    );
  }
}
