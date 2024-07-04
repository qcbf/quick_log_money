import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagListUI.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';

class RecordRecentTags extends StatefulWidget {
  const RecordRecentTags({super.key});

  @override
  State<RecordRecentTags> createState() => _RecordRecentTagsState();
}

class _RecordRecentTagsState extends State<RecordRecentTags> {
  @override
  Widget build(BuildContext context) {
    return ConditionalValueListener.AsyncValue(Ledger.Tag, (context, value, child) => BuildTags());
  }

  ///
  Widget BuildTags() {
    // ///首次时构建所需的数据
    // if (_Tags.isEmpty) {
    //   final maxCount = UserPrefs.RecentTagMaxCount.value;
    //   final recentTags = UserPrefs.RecentTags.value;
    //   var allTags = LedgerDataProvider.Global.value.AllTags;
    //   _Tags = recentTags.map((id) => IdTagData(id, allTags[id] ?? TagData.NotFound));
    //   if (_Tags.length < maxCount) {
    //     _Tags = _Tags.followedBy(allTags.entries.take(maxCount - _Tags.length).map((v) => IdTagData(v.key, v.value)));
    //   }
    //   context.read<EntryEditingProvider>().TagId ??= _Tags.first.Id;
    // }
    return TagListUI(
      context.read<EntryEditingProvider>().TagId,
      Ledger.Tag.value.RecentTags,
      (tagId) => setState(() => context.read<EntryEditingProvider>().TagId = tagId),
      Physics: null,
    );
  }
}
