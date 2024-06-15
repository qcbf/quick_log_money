import 'package:flutter/material.dart';
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
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          const Text("aaaaaaaaaa"),
          const Text("bbbbbbbbbbbbbbbbb"),
          const Spacer(),
          IntrinsicHeight(
            child: Row(
              children: [
                BuildLeftMenu(),
                BuildKeyboard(),
                BuildRightMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildKeyboard() {
    return Expanded(
      child: NumericKeyboard((key, keyStr) {
        setState(() {
          if (key == NumericKeyboardKey.Back) {
            if (_title.isNotEmpty) {
              _title = _title.substring(0, _title.length - 1);
            }
          } else if (key == NumericKeyboardKey.LongBack) {
            _title = "";
          } else {
            var temp = _title + keyStr;
            if (double.tryParse(temp) != null) _title = temp;
          }
        });
      }),
    );
  }

  Widget BuildLeftMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text("Key"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Tag"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Book"),
        ),
      ],
    );
  }

  Widget BuildRightMenu() {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text("Done"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Done To\nTemplate",
            style: TextStyle(fontSize: 10),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        TextButton(
          onPressed: () {},
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
