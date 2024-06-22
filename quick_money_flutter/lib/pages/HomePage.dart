import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';
import 'package:quick_log_money/Datas/UserData.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordPage.dart';
import 'package:quick_log_money/Utilities/LocalDB.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<LedgerProvider>(
          builder: (context, value, child) =>
              Conditional.Single(context, (context) => value.IsInited, (context) => Text(value.Ledger.Data!.Name, style: const TextStyle(fontSize: 14))),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.widgets))],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RecordPage()));
          },
          mini: false,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
          child: ListView(
        children: [
          Consumer<UserProvider>(builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value.Data.Name, style: Theme.of(context).textTheme.headlineMedium),
                  Text("ID:${value.Data.Id}", style: Theme.of(context).textTheme.labelMedium),
                  TextButton(onPressed: () {}, child: Text(value.Data.VipExpiryDate?.toString() ?? "开通vip")),
                ],
              ),
            );
          }),
          ListTile(
            title: const Text("setting"),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => print("x"),
          ),
          ListTile(
            title: const Text("setting"),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => print("x"),
          ),
          ListTile(
            title: const Text("setting"),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              LocalDB.deleteFromDisk().then((_) => print("delete local db finish"));
            },
          ),
        ],
      )),
    );
  }
}
