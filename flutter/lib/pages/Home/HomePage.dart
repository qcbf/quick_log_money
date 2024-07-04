import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Pages.dart';
import 'DrawerMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildTop(),
      floatingActionButton: BuildFloatingBottom(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: DrawerMenu(context: context),
    );
  }

  ///
  Padding BuildFloatingBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, Pages.Record);
        },
        mini: false,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  ///
  PreferredSizeWidget BuildTop() {
    return AppBar(
      centerTitle: true,
      title: ConditionalValueListener.AsyncValue(Ledger.Info, (context, value, child) => Text(value.Name, style: const TextStyle(fontSize: 14))),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.widgets))],
    );
  }
}
