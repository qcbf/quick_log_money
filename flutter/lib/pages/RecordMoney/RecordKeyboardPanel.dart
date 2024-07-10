import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordEntryEditingProvider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordRecentTags.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordSaveBtn.dart';

/// 底部输入键盘
class RecordKeyboardPanel extends StatelessWidget {
  final ButtonStyle _BtnStyle = const ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder()));

  const RecordKeyboardPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var children = [Expanded(flex: 35, child: _BuildLeftMenu(context)), Expanded(flex: 10, child: _BuildRightMenu())];
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 106, child: RecordRecentTags()),
        const Divider(height: 6),
        Expanded(child: Row(children: children)),
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

  Column _BuildLeftMenu(BuildContext context) {
    return Column(
      children: [
        _BuildKeyboardRow(context, _KeyboardKey.N7, _KeyboardKey.N8, _KeyboardKey.N9),
        _BuildKeyboardRow(context, _KeyboardKey.N4, _KeyboardKey.N5, _KeyboardKey.N6),
        _BuildKeyboardRow(context, _KeyboardKey.N1, _KeyboardKey.N2, _KeyboardKey.N3),
        _BuildKeyboardRow(context, _KeyboardKey.Dot, _KeyboardKey.N0, _KeyboardKey.Back),
        // _BuildComment(context),
      ],
    );
  }

  Widget _BuildNumericButton(BuildContext context, _KeyboardKey key) {
    var keyStr = _NumericKeyLabel(key);
    Widget result = key == _KeyboardKey.Back
        ? GestureDetector(onLongPress: () => _OnInputKey(context, _KeyboardKey.LongBack), child: _NumericButtonImpl(context, key, keyStr))
        : _NumericButtonImpl(context, key, keyStr);
    return Expanded(child: result);
  }

  Widget _BuildRightMenu() {
    const paddingValue = EdgeInsets.fromLTRB(0, 2, 0, 0);
    var style = _BtnStyle.copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 258,
          child: Padding(
            padding: paddingValue,
            child: Consumer<RecordEntryEditingProvider>(builder: (BuildContext context, RecordEntryEditingProvider value, Widget? child) => RecordSaveBtn(Style: style)),
          ),
        ),
        Expanded(
          flex: 80,
          child: Padding(
            padding: paddingValue,
            child: TextButton(
              style: style,
              onPressed: () {},
              child: const Text("存模板"),
            ),
          ),
        ),
        Expanded(
          flex: 120,
          child: Padding(
            padding: paddingValue,
            child: TextButton(
              style: style,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
        Expanded(
          flex: 120,
          child: Padding(
            padding: paddingValue,
            child: TextButton(
              style: style,
              onPressed: () {},
              child: const Icon(Icons.remove),
            ),
          ),
        ),
      ],
    );
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
    var data = context.read<RecordEntryEditingProvider>();

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
      data
        ..MoneyIntegerStr = newInteger
        ..MoneyDecimalStr = newDecimal
        ..Notify();
      HapticFeedback.lightImpact();
    }
  }
}

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
