import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordRecentTag.dart';

enum _KeyboardKey {
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
class RecordKeyboard extends StatelessWidget {
  final bool IsReverseLayout;
  const RecordKeyboard({this.IsReverseLayout = false, super.key});

  final ButtonStyle _BtnStyle = const ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder()));

  @override
  Widget build(BuildContext context) {
    var children = [Expanded(flex: 35, child: _BuildLeftMenu(context)), Expanded(flex: 10, child: _BuildRightMenu())];
    // if (IsReverseLayout) children = children.reversed.toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Flexible(flex: 10, child: RecordRecentTag()),
        Expanded(flex: 25, child: Row(children: children)),
      ],
    );
  }

  Column _BuildLeftMenu(BuildContext context) {
    return Column(
      children: [
        _BuildComment(),
        _BuildKeyboardRow(context, _KeyboardKey.N7, _KeyboardKey.N8, _KeyboardKey.N9),
        _BuildKeyboardRow(context, _KeyboardKey.N4, _KeyboardKey.N5, _KeyboardKey.N6),
        _BuildKeyboardRow(context, _KeyboardKey.N1, _KeyboardKey.N2, _KeyboardKey.N3),
        _BuildKeyboardRow(context, _KeyboardKey.Dot, _KeyboardKey.N0, _KeyboardKey.Back),
      ],
    );
  }

  Padding _BuildComment() {
    return const Padding(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      child: TextField(
        textInputAction: TextInputAction.done,
        maxLength: 500,
        decoration: InputDecoration(
            hintText: "备注...",
            hintStyle: TextStyle(letterSpacing: 3),
            counterText: "",
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _BuildRightMenu() {
    const paddingValue = EdgeInsets.fromLTRB(0, 2, 0, 0);
    var styleFrom = _BtnStyle.copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: paddingValue,
            child: TextButton(
              style: styleFrom,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: paddingValue,
            child: TextButton(
              style: styleFrom,
              onPressed: () {},
              child: const Icon(Icons.remove),
            ),
          ),
        ),
        Padding(
          padding: paddingValue,
          child: TextButton(
            style: styleFrom,
            onPressed: () {},
            child: const Text("存模板"),
          ),
        ),
        Consumer<EntryEditingProvider>(
            builder: (BuildContext context, EntryEditingProvider value, Widget? child) => Expanded(
                  flex: 2,
                  child: Padding(
                    padding: paddingValue,
                    child: TextButton(
                      style: styleFrom,
                      onPressed: () {},
                      child: Text("保存", style: TextStyle(color: value.IsIncome ? Colors.green : Colors.red)),
                    ),
                  ),
                )),
      ],
    );
  }

  Widget _BuildKeyboardRow(BuildContext context, _KeyboardKey k1, _KeyboardKey k2, _KeyboardKey k3) {
    return Expanded(
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _BuildNumericButton(context, k1),
        _BuildNumericButton(context, k2),
        _BuildNumericButton(context, k3),
      ]),
    );
  }

  Widget _BuildNumericButton(BuildContext context, _KeyboardKey key) {
    var keyStr = _NumericKeyLabel(key);
    Widget result = key == _KeyboardKey.Back
        ? GestureDetector(onLongPress: () => _OnInputKey(context, _KeyboardKey.LongBack), child: _NumericButtonImpl(context, key, keyStr))
        : _NumericButtonImpl(context, key, keyStr);
    return Expanded(child: result);
  }

  Widget _NumericButtonImpl(BuildContext context, _KeyboardKey key, Widget keyWidget) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 2, 0),
        child: TextButton(
          style: _BtnStyle,
          onPressed: () => _OnInputKey(context, key),
          child: keyWidget,
        ),
      );

  Widget _NumericKeyLabel(_KeyboardKey key) {
    const fontSize = 20.0;
    if (key == _KeyboardKey.Back) {
      return const Icon(Icons.keyboard_backspace);
    } else if (key == _KeyboardKey.Dot) {
      return const Text(".", style: TextStyle(fontSize: fontSize));
    }
    return Text(key.index.toString(), style: const TextStyle(fontSize: fontSize));
  }

  void _OnInputKey(BuildContext context, _KeyboardKey key) {
    var data = context.read<EntryEditingProvider>();

    var newInteger = data.MoneyIntegerStr;
    var newDecimal = data.MoneyDecimalStr;

    if (key == _KeyboardKey.Back) {
      if (newDecimal != null) {
        newDecimal = newDecimal.isEmpty ? null : newDecimal.substring(0, newDecimal.length - 1);
      } else if (newInteger.isNotEmpty) {
        newInteger = newInteger.substring(0, newInteger.length - 1);
      }
    } else if (key == _KeyboardKey.LongBack) {
      newInteger = "";
      newDecimal = null;
    } else if (key == _KeyboardKey.Dot) {
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
        if (key != _KeyboardKey.N0 || newInteger.isNotEmpty) newInteger += keyStr;
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
