import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/EntryUI.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';

class EntryGroups extends StatelessWidget {
  final Map<DateTime, List<LedgerEntry>> Entries;

  const EntryGroups(this.Entries, {super.key});
  EntryGroups.List(List<LedgerEntry> list, {super.key}) : Entries = list.groupListsBy((k) => k.Date.Today());

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [for (var item in Entries.entries) _BuildGroup(context, item.key, item.value)],
    );
  }

  Widget _BuildGroup(BuildContext context, DateTime date, List<LedgerEntry> entries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(date.ToSmartString(), style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12)),
        for (var entry in entries) InkWell(onTap: () {}, child: EntryUI(entry)),
      ],
    );
  }
}
