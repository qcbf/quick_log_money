import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagGroupUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';

class RecordRecentTag extends StatelessWidget {
  final bool _IsReverseLayout;

  const RecordRecentTag(this._IsReverseLayout, {super.key});

  @override
  Widget build(BuildContext context) {
    return TagGroupUI(List<TagData>.generate(8, (index) => TagData(index, Name: index == 1 ? "[$index]啊啊" : "[$index]啊啊啊啊")),
        IsReverseLayout: _IsReverseLayout);
  }
}
