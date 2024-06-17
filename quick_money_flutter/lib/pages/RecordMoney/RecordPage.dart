import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_money_flutter/Datas/MoneyLogData.dart';
import 'package:quick_money_flutter/FLib/extensions_helper.dart';
import 'package:quick_money_flutter/Pages/RecordMoney/RecordBottom.dart';
import 'package:quick_money_flutter/Pages/RecordMoney/RecordDescription.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoneyLogData(),
      child: _RecordPageContent(key: key),
    );
  }
}

class _RecordPageContent extends StatefulWidget {
  const _RecordPageContent({super.key});
  @override
  State<_RecordPageContent> createState() => _RecordPageContentState();
}

class _RecordPageContentState extends State<_RecordPageContent> with SingleTickerProviderStateMixin {
  late TabController _TabCtrl;

  @override
  void initState() {
    super.initState();
    _TabCtrl = TabController(length: 2, vsync: this);
    _TabCtrl.addListener(() {
      if (_TabCtrl.indexIsChanging) SetIsCost(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _TabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(controller: _TabCtrl, onTap: (value) => SetIsCost(context), tabs: const [Tab(text: "支出"), Tab(text: "收入")]),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(onHorizontalDragEnd: _GestureSwipe, child: const RecordDescription()).WrapExpanded(),
          const SizedBox(height: 400, child: RecordBottom()),
        ],
      ),
    );
  }

  /// 设置是否消费记账
  void SetIsCost(BuildContext context) {
    var data = context.read<MoneyLogData>();
    data.IsCost = _TabCtrl.index == 0;
    data.SetDirty();
  }

  /// 左右滑动
  void _GestureSwipe(details) {
    var newIndex = _TabCtrl.index;
    var factor = 10;
    if (details.primaryVelocity! > factor) {
      newIndex += 1;
    } else if (details.primaryVelocity! < -factor) {
      newIndex -= 1;
    }
    _TabCtrl.animateTo(newIndex % _TabCtrl.length);
  }
}
