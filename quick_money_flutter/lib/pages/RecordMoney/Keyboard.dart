import 'package:flutter/material.dart';
import 'package:quick_money_flutter/flib/extensions_helper.dart';

enum KeyboardKey {
  N0,
  N1,
  N2,
  N3,
  N4,
  N5,
  N6,
  N7,
  N8,
  N9,
  Dot,
  Back,
  LongBack,
}

Widget NumericKeyboardKeyToWidget(KeyboardKey key) {
  if (key == KeyboardKey.Back) {
    return const Icon(Icons.keyboard_backspace);
  } else if (key == KeyboardKey.Dot) {
    return const Text(".");
  }
  return Text(key.index.toString());
}

/// 底部输入键盘数字键
class Keyboard extends StatefulWidget {
  const Keyboard({super.key});

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  String InputStr = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(InputStr),
            _KeyboardRow(KeyboardKey.N1, KeyboardKey.N2, KeyboardKey.N3),
            _KeyboardRow(KeyboardKey.N4, KeyboardKey.N5, KeyboardKey.N6),
            _KeyboardRow(KeyboardKey.N7, KeyboardKey.N8, KeyboardKey.N9),
            _KeyboardRow(KeyboardKey.Dot, KeyboardKey.N0, KeyboardKey.Back),
          ],
        ).WrapExpanded(flex: 35),
        _BuildRightMenu().WrapExpanded(flex: 10),
      ],
    );
  }

  Widget _KeyboardRow(KeyboardKey k1, KeyboardKey k2, KeyboardKey k3) {
    return Expanded(
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _NumericButton(k1),
        _NumericButton(k2),
        _NumericButton(k3),
      ]),
    );
  }

  Widget _NumericButton(KeyboardKey key) {
    var keyStr = NumericKeyboardKeyToWidget(key);
    Widget result =
        key == KeyboardKey.Back ? GestureDetector(onLongPress: () => _InputKey(KeyboardKey.LongBack), child: _NumericButtonImpl(key, keyStr)) : _NumericButtonImpl(key, keyStr);
    return Expanded(child: result);
  }

  Widget _NumericButtonImpl(KeyboardKey key, Widget keyWidget) => ElevatedButton(onPressed: () => _InputKey(key), child: keyWidget).WrapPadding(const EdgeInsets.all(3));

  Widget _BuildRightMenu() {
    const paddingValue = EdgeInsets.fromLTRB(0, 4, 0, 4);
    var styleFrom = ElevatedButton.styleFrom(padding: EdgeInsets.zero);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          style: styleFrom,
          onPressed: () {},
          child: const Text("保存", style: TextStyle(color: Colors.green)),
        ).WrapPadding(paddingValue).WrapExpanded(),
        ElevatedButton(
          style: styleFrom,
          onPressed: () {},
          child: const Text(
            "确认\n存模板",
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ).WrapPadding(paddingValue).WrapExpanded(),
        ElevatedButton(
          style: styleFrom,
          onPressed: () {},
          child: const Icon(Icons.add),
        ).WrapPadding(paddingValue).WrapExpanded(),
        ElevatedButton(
          style: styleFrom,
          onPressed: () {},
          child: const Icon(Icons.remove),
        ).WrapPadding(paddingValue).WrapExpanded(),
      ],
    );
  }

  void _InputKey(KeyboardKey key) {
    setState(() {
      if (key == KeyboardKey.Back) {
        if (InputStr.isNotEmpty) {
          InputStr = InputStr.substring(0, InputStr.length - 1);
        }
      } else if (key == KeyboardKey.LongBack) {
        InputStr = "";
      } else if (key == KeyboardKey.Dot) {
        if (InputStr.isEmpty) {
          InputStr = "0.";
        } else if (!InputStr.contains(".")) {
          InputStr += ".";
        }
      } else if (key != KeyboardKey.N0 || InputStr.isNotEmpty) {
        InputStr += key.index.toString();
      }
    });
  }
}
