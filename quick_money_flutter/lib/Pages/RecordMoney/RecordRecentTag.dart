import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';
import 'package:quick_log_money/Utilities/Preference.dart';

class RecordRecentTag extends StatefulWidget {
  const RecordRecentTag({super.key});

  @override
  State<RecordRecentTag> createState() => _RecordRecentTagState();
}

class _RecordRecentTagState extends State<RecordRecentTag> {
  @override
  Widget build(BuildContext context) {
    // final tags = context.read<LedgerProvider>().Ledger.Data.Tags.entries.take(10).map((v) => v.value);
    // final recentTags = GlobalPreference.RecentTags.value;
    // for (var i = 0; i < recentTags.length; i++) {
      
    // }
    // var tags = List<TagData>.generate(8, (index) {
    //   recentTags[1];
    // });

    // if (tags.length < 8) {

    // }
// if (recentTags)

    return Column(children: [
      Expanded(
        child: Row(children: [
          BuildTagUI(const TagData(0, Name: "a1")),
          BuildTagUI(const TagData(0, Name: "a2")),
          BuildTagUI(const TagData(0, Name: "a3")),
          BuildTagUI(const TagData(0, Name: "a4")),
        ]),
      ),
      Expanded(
        child: Row(children: [
          BuildTagUI(const TagData(0, Name: "a5")),
          BuildTagUI(const TagData(0, Name: "a6")),
          BuildTagUI(const TagData(0, Name: "a7")),
          BuildTagUI(const TagData(0, Name: "a8")),
        ]),
      ),
    ]);
  }

  Widget BuildTagUI(TagData data) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: TagUI(data, () {
            context.read<EntryEditingProvider>().TagId = data.Id;
            print("Select Tag ${data.Id}|${data.Name}");
          }),
        ),
      );
}
