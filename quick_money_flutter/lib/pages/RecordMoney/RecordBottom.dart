import 'package:flutter/material.dart';
import 'package:quick_money_flutter/flib/extensions_helper.dart';
import 'package:quick_money_flutter/pages/RecordMoney/Keyboard.dart';

/// 底部输入键盘
class RecordBottom extends StatefulWidget {
  const RecordBottom({super.key});
  @override
  State<RecordBottom> createState() => _RecordBottomState();
}

class _RecordBottomState extends State<RecordBottom> with SingleTickerProviderStateMixin {
  late TabController _TabCtrl;

  @override
  void initState() {
    super.initState();
    _TabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _TabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(Theme.of(context).canvasColor.value + 0x18181818),
      child: Row(
        children: [
          BuildLeftMenu().WrapExpanded(flex: 10),
          TabBarView(controller: _TabCtrl, children: const [
            Keyboard(),
            Text("2"),
            Text("3"),
          ]).WrapExpanded(flex: 30),
        ],
      ),
    );
  }

  Widget BuildLeftMenu() {
    return RotatedBox(
      quarterTurns: 1,
      child: TabBar(controller: _TabCtrl, tabs: const [
        SizedBox(height: double.infinity, child: RotatedBox(quarterTurns: -1, child: Tab(text: "记账"))),
        SizedBox(height: double.infinity, child: RotatedBox(quarterTurns: -1, child: Tab(text: "分类"))),
        SizedBox(height: double.infinity, child: RotatedBox(quarterTurns: -1, child: Tab(text: "账本"))),
      ]),
    );
  }
}
