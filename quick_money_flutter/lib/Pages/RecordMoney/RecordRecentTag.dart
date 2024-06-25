import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';

class RecordRecentTag extends StatefulWidget {
  const RecordRecentTag({super.key});

  @override
  State<RecordRecentTag> createState() => _RecordRecentTagState();
}

class _RecordRecentTagState extends State<RecordRecentTag> {
  ///
  late Iterable<IdTagData> _Tags = const Iterable.empty();

  @override
  Widget build(BuildContext context) {
    return Consumer<LedgerProvider>(builder: (context, value, child) {
      return Conditional.Single(() => value.IsInited, () => BuildTags(value));
    });
  }

  ///
  Widget BuildTags(LedgerProvider ledger) {
    ///首次时构建所需的数据
    if (_Tags.isEmpty) {
      const maxCount = 8;
      final recentTags = UserPrefs.RecentTags.value;
      var allTags = context.read<LedgerProvider>().Ledger.Data.AllTags;
      _Tags = recentTags.map((id) => IdTagData(id, allTags[id] ?? const TagData(Name: "未找到")));
      if (_Tags.length < maxCount) {
        _Tags = _Tags.followedBy(allTags.entries.take(maxCount - _Tags.length).map((v) => IdTagData(v.key, v.value)));
      }
      context.read<EntryEditingProvider>().TagId ??= _Tags.first.Id;
    }

    ///
    return Column(children: [
      Expanded(
        child: Row(children: [for (var i = _Tags.length - 1; i >= 4; i--) BuildTagUI(i)]),
      ),
      Expanded(
        child: Row(children: [for (var i = 3; i >= 0; i--) BuildTagUI(i)]),
      ),
    ]);
  }

  ///
  Widget BuildTagUI(int index) {
    final data = _Tags.elementAt(index);
    ButtonStyle? style;
    if (context.read<EntryEditingProvider>().TagId == data.Id) {
      style = ButtonStyle(side: WidgetStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.primary, width: 1)));
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: TagUI(Style: style, data.Tag, () => setState(() => context.read<EntryEditingProvider>().TagId = data.Id)),
      ),
    );
  }
}
