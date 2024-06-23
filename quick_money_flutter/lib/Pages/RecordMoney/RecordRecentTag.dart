import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';

class RecordRecentTag extends StatelessWidget {
  final bool _IsReverseLayout;

  const RecordRecentTag(this._IsReverseLayout, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        TagUI(const TagData(0, Name: "吃喝"), () {}),
        TagUI(const TagData(0, Name: "出去游玩"), () {}),
        TagUI(const TagData(0, Name: "房屋水电气费"), () {}),
        TagUI(const TagData(0, Name: "交通开车"), () {})
      ]),
      Row(children: [
        TagUI(const TagData(0, Name: "吃喝"), () {}),
        TagUI(const TagData(0, Name: "出去游玩"), () {}),
        TagUI(const TagData(0, Name: "房屋水电气费"), () {}),
        TagUI(const TagData(0, Name: "交通开车"), () {})
      ]),
    ]);
  }
}
