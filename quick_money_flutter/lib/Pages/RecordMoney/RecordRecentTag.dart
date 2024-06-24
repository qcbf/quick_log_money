import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';

class RecordRecentTag extends StatelessWidget {
  final bool _IsReverseLayout;

  const RecordRecentTag(this._IsReverseLayout, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2, children: [SizedBox(width: 100, height: 100)]);

    // return Column(children: [
    //   Row(children: [
    //     TagUI(const TagData(0, Name: "a"), () {}),
    //     TagUI(const TagData(0, Name: "a"), () {}),
    //     TagUI(const TagData(0, Name: "a"), () {}),
    //     TagUI(const TagData(0, Name: "a"), () {})
    //   ]),
    //   Row(children: [
    //     TagUI(const TagData(0, Name: "a"), () {}),
    //     TagUI(const TagData(0, Name: "a"), () {}),
    //     TagUI(const TagData(0, Name: "a"), () {}),
    //     TagUI(const TagData(0, Name: "a"), () {})
    //   ]),
    // ]);
  }
}
