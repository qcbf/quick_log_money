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
}

String NumericKeyboardKeyToString(NumericKeyboardKey key) {
  if (key == NumericKeyboardKey.Back) {
    return "⬅";
  } else if (key == NumericKeyboardKey.Dot) {
    return ".";
  }
  return key.index.toString();
}

class NumericKeyboard extends StatelessWidget {
  final Function(NumericKeyboardKey, String) OnTap;
  const NumericKeyboard(this.OnTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          NumericButton(NumericKeyboardKey.N1),
          NumericButton(NumericKeyboardKey.N2),
          NumericButton(NumericKeyboardKey.N3),
        ]),
        TableRow(children: [
          NumericButton(NumericKeyboardKey.N4),
          NumericButton(NumericKeyboardKey.N5),
          NumericButton(NumericKeyboardKey.N6),
        ]),
        TableRow(children: [
          NumericButton(NumericKeyboardKey.N7),
          NumericButton(NumericKeyboardKey.N8),
          NumericButton(NumericKeyboardKey.N9),
        ]),
        TableRow(children: [
          NumericButton(NumericKeyboardKey.Back),
          NumericButton(NumericKeyboardKey.N0),
          NumericButton(NumericKeyboardKey.Dot),
        ]),
      ],
    );
  }

  TextButton NumericButton(NumericKeyboardKey key) {
    var keyStr = NumericKeyboardKeyToString(key);
    return TextButton(onPressed: () => OnTap(key, keyStr), child: Text(keyStr));
  }
}
