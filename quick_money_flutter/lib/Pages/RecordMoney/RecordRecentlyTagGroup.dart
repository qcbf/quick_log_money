import 'package:flutter/material.dart';
import 'package:quick_money_flutter/CommonWidgets/TagGroupUI.dart';
import 'package:quick_money_flutter/Datas/TagData.dart';

class RecordRecentlyTagGroup extends StatelessWidget {
  const RecordRecentlyTagGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      child: Column(
        children: [
          Text(
            "最近使用",
            style: TextStyle(fontSize: 12, color: Theme.of(context).dividerColor),
          ),
          TagGroupUI(List<TagData>.generate(12, (index) => TagData(index, Name: index == 1 ? "啊啊" : "啊啊啊啊啊"))),
        ],
      ),
    );
  }
}
