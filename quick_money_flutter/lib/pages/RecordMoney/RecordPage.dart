import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_money_flutter/Datas/MoneyLogData.dart';
import 'package:quick_money_flutter/FLib/extensions_helper.dart';
import 'package:quick_money_flutter/Pages/RecordMoney/RecordBottom.dart';
import 'package:quick_money_flutter/Pages/RecordMoney/RecordContent.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoneyLogData(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:  TabBar(onTap: (value) => print(value),tabs: const [Tab(text: "支出"), Tab(text: "收入")]),
            actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
          ),
          body: Column(
            children: [
              const TabBarView(children: [
                RecordContent(true),
                RecordContent(false),
              ]).WrapExpanded(),
              const Spacer(),
              const SizedBox(height: 225, child: RecordBottom()),
            ],
          ),
        ),
      ),
    );
  }
}
