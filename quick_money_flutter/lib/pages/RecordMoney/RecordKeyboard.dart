import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quick_money_flutter/Datas/Ledger/EntryEditingData.dart';
import 'package:quick_money_flutter/FLib/extensions_helper.dart';
import 'package:quick_money_flutter/Pages/RecordMoney/RecordRecentlyTagGroup.dart';

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

/// 底部输入键盘
class RecordKeyboard extends StatefulWidget {
  const RecordKeyboard({super.key});

  @override
  State<RecordKeyboard> createState() => _RecordKeyboardState();
}

class _RecordKeyboardState extends State<RecordKeyboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const RecordRecentlyTagGroup(),
        Expanded(
          child: Row(
            children: [
              _BuildLeftMenu().WrapExpanded(flex: 35),
              _BuildRightMenu().WrapExpanded(flex: 10),
            ],
          ),
        ),
      ],
    );
  }

  Column _BuildLeftMenu() {
    return Column(
      children: [
        _KeyboardRow(KeyboardKey.N7, KeyboardKey.N8, KeyboardKey.N9),
        _KeyboardRow(KeyboardKey.N4, KeyboardKey.N5, KeyboardKey.N6),
        _KeyboardRow(KeyboardKey.N1, KeyboardKey.N2, KeyboardKey.N3),
        _KeyboardRow(KeyboardKey.Dot, KeyboardKey.N0, KeyboardKey.Back),
        const TextField(
          textInputAction: TextInputAction.done,
          maxLength: 500,
          decoration: InputDecoration(hintText: "备注...", counterText: "", border: InputBorder.none, contentPadding: EdgeInsets.zero, isDense: true),
          style: TextStyle(fontSize: 14),
        ).WrapPadding(const EdgeInsets.only(top: 6, bottom: 6)),
      ],
    );
  }

  Widget _BuildRightMenu() {
    const paddingValue = EdgeInsets.fromLTRB(0, 4, 0, 4);
    var styleFrom = TextButton.styleFrom(padding: EdgeInsets.zero);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: TextButton(
            style: styleFrom,
            onPressed: () {},
            child: const Icon(Icons.add),
          ).WrapPadding(paddingValue),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            style: styleFrom,
            onPressed: () {},
            child: const Icon(Icons.remove),
          ).WrapPadding(paddingValue),
        ),
        TextButton(
          style: styleFrom,
          onPressed: () {},
          child: const Text("存模板"),
        ).WrapPadding(paddingValue),
        Consumer<EntryEditingData>(
            builder: (BuildContext context, EntryEditingData value, Widget? child) => Expanded(
                  flex: 2,
                  child: TextButton(
                    style: styleFrom,
                    onPressed: () {},
                    child: Text("保存", style: TextStyle(color: value.IsCost ? Colors.red : Colors.green)),
                  ).WrapPadding(paddingValue),
                )),
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
    var keyStr = _NumericKeyLabel(key);
    Widget result =
        key == KeyboardKey.Back ? GestureDetector(onLongPress: () => _OnInputKey(KeyboardKey.LongBack), child: _NumericButtonImpl(key, keyStr)) : _NumericButtonImpl(key, keyStr);
    return Expanded(child: result);
  }

  Widget _NumericButtonImpl(KeyboardKey key, Widget keyWidget) => TextButton(onPressed: () => _OnInputKey(key), child: keyWidget).WrapPadding(const EdgeInsets.all(2));

  Widget _NumericKeyLabel(KeyboardKey key) {
    const fontSize = 20.0;
    if (key == KeyboardKey.Back) {
      return const Icon(Icons.keyboard_backspace);
    } else if (key == KeyboardKey.Dot) {
      return const Text(".", style: TextStyle(fontSize: fontSize));
    }
    return Text(key.index.toString(), style: const TextStyle(fontSize: fontSize));
  }

  void _OnInputKey(KeyboardKey key) {
    var data = context.read<EntryEditingData>();

    var newInteger = data.MoneyIntegerStr;
    var newDecimal = data.MoneyDecimalStr;

    if (key == KeyboardKey.Back) {
      if (newDecimal != null) {
        newDecimal = newDecimal.isEmpty ? null : newDecimal.substring(0, newDecimal.length - 1);
      } else if (newInteger.isNotEmpty) {
        newInteger = newInteger.substring(0, newInteger.length - 1);
      }
    } else if (key == KeyboardKey.LongBack) {
      newInteger = "";
      newDecimal = null;
    } else if (key == KeyboardKey.Dot) {
      newDecimal ??= "";
    } else {
      var keyStr = key.index.toString();
      if (newDecimal != null) {
        if (newDecimal.length < 2) {
          newDecimal += keyStr;
        } else {
          newDecimal = newDecimal[0] + keyStr;
        }
      } else {
        newInteger += keyStr;
      }
    }

    if (newInteger != data.MoneyIntegerStr || newDecimal != data.MoneyDecimalStr) {
      data.MoneyIntegerStr = newInteger;
      data.MoneyDecimalStr = newDecimal;
      data.SetDirty();
      HapticFeedback.lightImpact();
    }
  }
}
