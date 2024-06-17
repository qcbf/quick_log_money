import 'package:flutter/material.dart';
import 'package:quick_money_flutter/Pages/RecordMoney/RecordKeyboard.dart';

/// 底部输入区域
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
    return Card(
      child: Row(
        children: [
          Expanded(child: BuildLeftMenu()),
          // TabBarView(controller: _TabCtrl, children: const [
          //   RecordKeyboard(),
          //   Text("2"),
          //   Text("3"),
          // ]),
        ],
      ),
    );
  }

  Widget BuildLeftMenu() {
    return Column(
      children: [
        Text("data"),
        TabBar(controller: _TabCtrl, tabs: const [
          Tab(text: "记账"),
          Tab(text: "类别"),
          Tab(text: "账本"),
        ]),
      ],
    );
  }
}
