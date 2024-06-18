import 'package:flutter/material.dart';
import 'package:quick_money_flutter/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_money_flutter/Datas/Ledger/Entry/TagData.dart';

class TagGroupUI extends StatefulWidget {
  final List<TagData> Datas;
  const TagGroupUI(this.Datas, {super.key});
  @override
  State<TagGroupUI> createState() => _TagGroupUIState();
}

class _TagGroupUIState extends State<TagGroupUI> {
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

  Widget BuildTagItem(index) => TagUI(() {
        setState(() {
          _SelectedIndex = index;
        });
      }, widget.Datas[index], IsSelected: _SelectedIndex == index);
}
