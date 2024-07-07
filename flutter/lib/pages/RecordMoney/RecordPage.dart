import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordBottomPanel.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordDescription.dart';
import 'package:quick_log_money/Utilities/Pages.dart';

/// 账单记录页面
class RecordPage extends StatelessWidget {
  const RecordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => EntryEditingProvider(), child: _RecordPageContent(key: key));
  }
}

///记录页面实际内容ui
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: SizedBox(
            width: kToolbarHeight,
            child: IconButton(
                onPressed: () async {
                  if (!await Navigator.maybePop(context)) {
                    if (kDebugMode) {
                      BotToast.showSimpleNotification(title: "Debug Only>Back Home");
                      if (!mounted) return;
                      Navigator.pushNamedAndRemoveUntil(context, Pages.Home, (route) => false);
                    } else {
                      exit(0);
                    }
                  }
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          title: TabBar(controller: _TabCtrl, onTap: (value) => SetIsCost(context), tabs: const [Tab(text: "支出"), Tab(text: "收入")]),
          actions: [SizedBox(height: kToolbarHeight, width: kToolbarHeight, child: IconButton(onPressed: () {}, icon: const Icon(Icons.settings)))],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: GestureDetector(onHorizontalDragEnd: _GestureSwipe, child: const RecordDescription())),
            const SizedBox(height: 350, child: RecordBottomPanel()),
          ],
        ),
      );

  /// 设置是否消费记账
  void SetIsCost(BuildContext context) {
    var data = context.read<EntryEditingProvider>();
    data.IsIncome = _TabCtrl.index == 1;
    data.Notify();
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
