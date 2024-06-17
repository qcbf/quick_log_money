import 'package:flutter/material.dart';
import 'package:quick_money_flutter/CommonWidgets/TagGroupUI.dart';
import 'package:quick_money_flutter/Datas/TagData.dart';

class RecordRecentlyTagGroup extends StatelessWidget {
  const RecordRecentlyTagGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return TagGroupUI(List<TagData>.generate(8, (index) => TagData(index, Name: index == 1 ? "啊啊" : "啊啊啊啊$index")));
  }
}
