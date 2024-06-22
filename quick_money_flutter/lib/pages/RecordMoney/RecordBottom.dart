import 'package:flutter/material.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordKeyboard.dart';

/// 底部输入区域
class RecordBottom extends StatefulWidget {
  const RecordBottom({super.key});
  @override
  State<RecordBottom> createState() => _RecordBottomState();
}

class _RecordBottomState extends State<RecordBottom> with SingleTickerProviderStateMixin {
  late TabController _TabCtrl;
  bool _IsReverseLayout = false;

  @override
  Widget build(BuildContext context) {
    var children = [
      Flexible(flex: 10, child: BuildLeftMenu()),
      Expanded(
        flex: 30,
        child: TabBarView(controller: _TabCtrl, children: [
          RecordKeyboard(IsReverseLayout: _IsReverseLayout),
          const Placeholder(),
          const Placeholder(),
        ]),
      ),
    ];
    if (_IsReverseLayout) children = children.reversed.toList();
    return Card(child: Row(children: children));
  }

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

  @override
  void dispose() {
    _TabCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _TabCtrl = TabController(length: 3, vsync: this);
  }
}
