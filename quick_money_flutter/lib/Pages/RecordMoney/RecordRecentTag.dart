import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';

class RecordRecentTag extends StatelessWidget {
  final bool _IsReverseLayout;

  const RecordRecentTag(this._IsReverseLayout, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Row(children: [
          BuildTagUI(const TagData(0, Name: "a")),
          BuildTagUI(const TagData(0, Name: "a")),
          BuildTagUI(const TagData(0, Name: "a")),
          BuildTagUI(const TagData(0, Name: "a")),
        ]),
      ),
      Expanded(
        child: Row(children: [
          BuildTagUI(const TagData(0, Name: "a")),
          BuildTagUI(const TagData(0, Name: "a")),
          BuildTagUI(const TagData(0, Name: "a")),
          BuildTagUI(const TagData(0, Name: "a")),
        ]),
      ),
    ]);
  }

  Widget BuildTagUI(TagData data) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: TagUI(data, () {}),
        ),
      );
}
