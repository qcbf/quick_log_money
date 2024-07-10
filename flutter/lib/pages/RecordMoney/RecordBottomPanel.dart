import 'package:flutter/material.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordKeyboardPanel.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordLedgerPanel.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordTagPanel.dart';
import 'package:quick_log_money/pages/RecordMoney/RecordOptionPanel.dart';

/// 底部输入区域
class RecordBottomPanel extends StatefulWidget {
  const RecordBottomPanel({super.key});
  @override
  State<RecordBottomPanel> createState() => _RecordBottomPanelState();
}

class _RecordBottomPanelState extends State<RecordBottomPanel> with SingleTickerProviderStateMixin {
  late TabController _TabCtrl;
  bool _IsReverseLayout = false;

  @override
  Widget build(BuildContext context) {
    var contents = [
      Flexible(flex: 8, child: BuildLeftMenu()),
      Expanded(flex: 30, child: BuildRightContent()),
    ];
    if (_IsReverseLayout) contents = contents.reversed.toList();
    return Card(
        child: Column(
      children: [
        const RecordOptionPanel(),
        const Divider(height: 6, endIndent: 2, indent: 2),
        Expanded(child: Row(children: contents)),
      ],
    ));
  }

  /// 左边菜单，记账，类别什么的
  Widget BuildLeftMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                _IsReverseLayout = !_IsReverseLayout;
              });
            },
            child: Icon(_IsReverseLayout ? Icons.keyboard_double_arrow_left : Icons.keyboard_double_arrow_right)),
        Expanded(
          child: RotatedBox(
            quarterTurns: 1,
            child: TabBar(
                dividerHeight: 0,
                indicator: BoxDecoration(
                    border: _IsReverseLayout
                        ? Border(top: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 4))
                        : Border(bottom: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 4))),
                controller: _TabCtrl,
                tabs: const [
                  SizedBox(height: double.infinity, child: RotatedBox(quarterTurns: -1, child: Tab(text: "记账"))),
                  SizedBox(height: double.infinity, child: RotatedBox(quarterTurns: -1, child: Tab(text: "类别"))),
                  SizedBox(height: double.infinity, child: RotatedBox(quarterTurns: -1, child: Tab(text: "账本"))),
                ]),
          ),
        ),
      ],
    );
  }

  /// 右边每个分类的内容
  Widget BuildRightContent() {
    return TabBarView(controller: _TabCtrl, children: const [
      RecordKeyboardPanel(),
      RecordTagPanel(),
      RecordLedgerPanel(),
    ]);
  }

  @override
  void dispose() {
    _TabCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _TabCtrl = TabController(length: 3, vsync: this, animationDuration: Durations.short2);
  }
}
