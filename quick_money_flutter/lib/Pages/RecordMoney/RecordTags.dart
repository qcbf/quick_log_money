import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagGroupData.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';

class RecordTags extends StatefulWidget {
  const RecordTags({super.key});

  @override
  State<RecordTags> createState() => _RecordTagsState();
}

class _RecordTagsState extends State<RecordTags> {
  @override
  Widget build(BuildContext context) {
    // ignore_for_file: all
    // todo: 这里LedgerProvider.Ledger是但是很快的异步加载，有极小概率0.01秒切到这个页面那么可能就是null，如果后面出现问题到时候再套一层异步等待.
    final ledgerData = context.read<LedgerProvider>().Ledger.Data;
    return ListView(
      children: [for (var tagGroupData in ledgerData.TagGroups) BuildTagGroup(ledgerData.AllTags, tagGroupData)],
    );
  }

  ///
  Widget BuildTagGroup(Map<int, TagData> allTags, TagGroupData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(data.Name, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline, height: 2)),
        GridView.extent(
          maxCrossAxisExtent: 80,
          crossAxisSpacing: 3,
          mainAxisSpacing: 6,
          childAspectRatio: 1.3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [for (var tagId in data.Tags) BuildTag(allTags, tagId)],
        ),
      ]),
    );
  }

  Widget BuildTag(Map<int, TagData> allTags, int tagId) => TagUI(allTags[tagId] ?? TagData.NotFound, () {});
}
