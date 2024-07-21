import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';

class EntryUI extends StatelessWidget {
  final LedgerEntry Entry;
  const EntryUI(this.Entry, {super.key});

  @override
  Widget build(BuildContext context) {
    final tag = Ledger.ExpenseTag.value.AllTags[Entry.TagId]!;
    return SizedBox(
      height: 40,
      child: Row(children: [
        Image.asset(LedgerUtility.LedgerIconNameToAssetPath(tag.Icon), height: 30),
        const SizedBox(width: 2),
        Expanded(child: _BuildLabel(context, tag)),
        Text("${LedgerUtility.GetRealMoneyStr(Entry.IntMoney)}￥"), // 如何让这个text始终显示在最后
      ]),
    );
  }

  Widget _BuildLabel(BuildContext context, LedgerTag tag) {
    final nameUI = Text(tag.Name);
    if (Entry.Comment.isEmpty) {
      return nameUI;
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameUI,
          Flexible(child: Text(Entry.Comment, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.outline))),
        ],
      );
    }
  }
}
