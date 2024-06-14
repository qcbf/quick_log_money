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
        title: Text(_title),
      ),
      body: NumericKeyboard((key) {
        setState(() {
          if (key == NumericKeyboardKey.Back) {
            if (_title.isNotEmpty) {
              _title = _title.substring(0, _title.length - 1);
            }
          } else {
            _title += key.toString();
          }
        });
      }),
    );
  }
}
