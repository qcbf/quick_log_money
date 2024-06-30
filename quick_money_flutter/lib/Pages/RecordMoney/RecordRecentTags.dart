import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagListUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';

class RecordRecentTags extends StatefulWidget {
  const RecordRecentTags({super.key});

  @override
  State<RecordRecentTags> createState() => _RecordRecentTagsState();
}

class _RecordRecentTagsState extends State<RecordRecentTags> {
  ///
  late Iterable<IdTagData> _Tags = const Iterable.empty();

  @override
  Widget build(BuildContext context) {
    return Conditional.Single(
      () => LedgerProvider.Global.IsInited,
      () => ValueListenableBuilder(valueListenable: LedgerProvider.Global, builder: (context, value, child) => BuildTags()),
    );
  }

  ///
  Widget BuildTags() {
    ///首次时构建所需的数据
    if (_Tags.isEmpty) {
      final maxCount = UserPrefs.RecentTagMaxCount.value;
      final recentTags = UserPrefs.RecentTags.value;
      var allTags = LedgerProvider.Global.value.Data.AllTags;
      _Tags = recentTags.map((id) => IdTagData(id, allTags[id] ?? TagData.NotFound));
      if (_Tags.length < maxCount) {
        _Tags = _Tags.followedBy(allTags.entries.take(maxCount - _Tags.length).map((v) => IdTagData(v.key, v.value)));
      }
      context.read<EntryEditingProvider>().TagId ??= _Tags.first.Id;
    }
    return TagListUI(
      context.read<EntryEditingProvider>().TagId,
      _Tags,
      (tagId) => setState(() => context.read<EntryEditingProvider>().TagId = tagId),
      Physics: null,
    );
  }
}
