import 'package:flutter/material.dart';
import 'package:quick_money_flutter/flib/extensions_helper.dart';
import 'package:quick_money_flutter/pages/RecordMoney/RecordBottom.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TabBar(tabs: [Tab(text: "支出"), Tab(text: "收入")]),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
        ),
        body: Column(
          children: [
            TabBarView(children: [
              Text("花费 ${"_Description".isEmpty ? "0" : "_Description"} ￥").WrapCenter(),
              Text("收入 ${"_Description".isEmpty ? "0" : "_Description"} ￥").WrapCenter(),
            ]).WrapExpanded(),
            const Spacer(),
            const SizedBox(height: 225, child: RecordBottom()),
          ],
        ),
      ),
    );
  }
}
