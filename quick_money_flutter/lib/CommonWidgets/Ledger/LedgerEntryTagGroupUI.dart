import 'package:flutter/material.dart';
import 'package:quick_money_flutter/CommonWidgets/Ledger/LedgerEntryTagUI.dart';
import 'package:quick_money_flutter/Datas/Ledger/TagData.dart';

class LedgerEntryTagGroupUI extends StatefulWidget {
  final List<TagData> Datas;
  const LedgerEntryTagGroupUI(this.Datas, {super.key});
  @override
  State<LedgerEntryTagGroupUI> createState() => _LedgerEntryTagGroupUIState();
}

class _LedgerEntryTagGroupUIState extends State<LedgerEntryTagGroupUI> {
  int _SelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.Datas.length,
        BuildTagItem,
      ),
    );
  }

  Widget BuildTagItem(index) => LedgerEntryTagUI(() {
        setState(() {
          _SelectedIndex = index;
        });
      }, widget.Datas[index], IsSelected: _SelectedIndex == index);
}
