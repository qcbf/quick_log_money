import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagListUI.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';

/// 标签组
class TagGroupUI extends StatelessWidget {
  ///
  final Map<String, Iterable<LedgerTag>> TagGroupDatas;
  final void Function(LedgerTag tagId) OnSelectTagHandler;
  final int? SelectTagId;

  const TagGroupUI(this.SelectTagId, this.TagGroupDatas, this.OnSelectTagHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [for (var tagGroup in TagGroupDatas.entries) BuildTagGroup(context, tagGroup.key, tagGroup.value)],
    );
  }

  ///
  Widget BuildTagGroup(BuildContext context, String groupName, Iterable<LedgerTag> tags) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(groupName, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline, height: 2)),
        TagListUI(SelectTagId, tags, OnSelectTagHandler, Physics: const NeverScrollableScrollPhysics()),
      ]),
    );
  }
}
