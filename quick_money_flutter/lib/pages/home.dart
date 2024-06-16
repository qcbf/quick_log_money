import 'package:flutter/material.dart';
import 'package:quick_money_flutter/Pages/RecordMoney/RecordPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RecordPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "notify",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.widgets))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RecordPage()));
        },
        mini: false,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
          child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("user name"),
            accountEmail: Text("email"),
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
            onTap: () => print("x"),
          ),
          ListTile(
            title: const Text("setting"),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => print("x"),
          ),
        ],
      )),
    );
  }
}
