import 'package:flutter/material.dart';
import 'package:quick_money_flutter/flib/extensions_helper.dart';
import 'package:quick_money_flutter/pages/record_money/numeric_keyboard.dart';

class RecordMoney extends StatefulWidget {
  const RecordMoney({super.key});
  @override
  State<RecordMoney> createState() => _RecordMoneyState();
}

class _RecordMoneyState extends State<RecordMoney> {
  String _title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_title.isEmpty ? "0" : _title}￥"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
      ),
      body: Column(
        children: [
          const Text("aaaaaaaaaa"),
          const Text("bbbbbbbbbbbbbbbbb"),
          const Spacer(),
          SizedBox(
            height: 220,
            child: Row(
              children: [
                BuildLeftMenu().WrapExpanded(flex: 10),
                BuildKeyboard().WrapExpanded(flex: 22),
                BuildRightMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildKeyboard() {
    return NumericKeyboard((key) {
      setState(() {
        if (key == NumericKeyboardKey.Back) {
          if (_title.isNotEmpty) {
            _title = _title.substring(0, _title.length - 1);
          }
        } else if (key == NumericKeyboardKey.LongBack) {
          _title = "";
        } else {
          var temp = _title + key.index.toString();
          if (double.tryParse(temp) != null) _title = temp;
        }
      });
    });
  }

  Widget BuildLeftMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text("Key"),
        ).WrapExpanded(),
        TextButton(
          onPressed: () {},
          child: const Text("Tag"),
        ).WrapExpanded(),
        TextButton(
          onPressed: () {},
          child: const Text("Book"),
        ).WrapExpanded(),
      ],
    );
  }

  Widget BuildRightMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text("Done"),
        ).WrapExpanded(),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Done To\nTemplate",
            style: TextStyle(fontSize: 10),
          ),
        ).WrapExpanded(),
        TextButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ).WrapExpanded(),
        TextButton(
          onPressed: () {},
          child: const Icon(Icons.remove),
        ).WrapExpanded(),
      ],
    ).WrapIntrinsicWidth();
  }
}
