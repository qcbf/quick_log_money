import 'package:flutter/material.dart';

enum NumericKeyboardKey {
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

Widget NumericKeyboardKeyToWidget(NumericKeyboardKey key) {
  if (key == NumericKeyboardKey.Back) {
    return const Icon(Icons.keyboard_backspace);
  } else if (key == NumericKeyboardKey.Dot) {
    return const Text(".");
  }
  return Text(key.index.toString());
}

class NumericKeyboard extends StatelessWidget {
  final Function(NumericKeyboardKey key) OnTap;

  const NumericKeyboard(this.OnTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _KeyboardRow(NumericKeyboardKey.N1, NumericKeyboardKey.N2, NumericKeyboardKey.N3),
        _KeyboardRow(NumericKeyboardKey.N4, NumericKeyboardKey.N5, NumericKeyboardKey.N6),
        _KeyboardRow(NumericKeyboardKey.N7, NumericKeyboardKey.N8, NumericKeyboardKey.N9),
        _KeyboardRow(NumericKeyboardKey.Back, NumericKeyboardKey.N0, NumericKeyboardKey.Dot),
      ],
    );
  }

  Widget _KeyboardRow(NumericKeyboardKey k1, NumericKeyboardKey k2, NumericKeyboardKey k3) {
    return Expanded(
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _NumericButton(k1),
        _NumericButton(k2),
        _NumericButton(k3),
      ]),
    );
  }

  Widget _NumericButton(NumericKeyboardKey key) {
    var keyStr = NumericKeyboardKeyToWidget(key);
    Widget result = key == NumericKeyboardKey.Back
        ? GestureDetector(onLongPress: () => OnTap(NumericKeyboardKey.LongBack), child: _NumericButtonImpl(key, keyStr))
        : _NumericButtonImpl(key, keyStr);
    return Expanded(child: result);
  }

  TextButton _NumericButtonImpl(NumericKeyboardKey key, Widget keyWidget) => TextButton(onPressed: () => OnTap(key), child: keyWidget);
}
