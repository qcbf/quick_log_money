import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';

class TagGroupUI extends StatefulWidget {
  final List<TagData> Datas;
  final bool IsReverseLayout;
  const TagGroupUI(this.Datas, {super.key, this.IsReverseLayout = false});
  @override
  State<TagGroupUI> createState() => _TagGroupUIState();
}

class _TagGroupUIState extends State<TagGroupUI> {
  // int _SelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<EntryEditingProvider>(
        builder: (context, value, child) => const Column(children: [
              Row(
                children: [Placeholder()],
              )
            ]));
    // Align(
    //       alignment: widget.IsReverseLayout ? Alignment.centerLeft : Alignment.centerRight,
    //       child: Wrap(
    //         verticalDirection: VerticalDirection.up,
    //         textDirection: widget.IsReverseLayout ? TextDirection.ltr : TextDirection.rtl,
    //         children: List.generate(
    //           widget.Datas.length,
    //           BuildTagItem,
    //         ),
    //       ),
    //     ));
  }

  Widget BuildTagItem(index) => TagUI(widget.Datas[index], () {});
}
