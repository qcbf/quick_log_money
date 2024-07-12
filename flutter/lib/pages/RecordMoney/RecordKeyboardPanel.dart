import 'package:flutter/material.dart';
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
    var children = [Expanded(flex: 35, child: _BuildLeftMenu(context)), Expanded(flex: 10, child: _BuildRightMenu(context))];
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const RecordRecentTags(),
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

  Widget _BuildRightMenu(BuildContext context) {
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
              onPressed: () => _OnInputKey(context, _KeyboardKey.CalcAdd),
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
              onPressed: () => _OnInputKey(context, _KeyboardKey.CalcSub),
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
    var entry = context.read<RecordEntryEditingProvider>();
    if (key == _KeyboardKey.LongBack) {
      entry.MoneyCalc.Clear();
      entry.Notify();
      return;
    }

    var endIndex = entry.MoneyCalc.Values.length - 1;
    final calc = entry.MoneyCalc.Values[endIndex];
    if (calc is ECalcOperator) {
      if (key == _KeyboardKey.CalcAdd) {
        entry.MoneyCalc.Values[endIndex] = ECalcOperator.Add;
        entry.Notify();
      } else if (key == _KeyboardKey.CalcSub) {
        entry.MoneyCalc.Values[endIndex] = ECalcOperator.Sub;
        entry.Notify();
      } else if (key == _KeyboardKey.Back) {
        entry.MoneyCalc.Values.removeAt(endIndex);
        entry.Notify();
      } else {
        entry.MoneyCalc.Values.add(CalcNumeric(IntegerStr: key.index.toString()));
        entry.Notify();
      }
    } else {
      final numeric = calc as CalcNumeric;
      if (key == _KeyboardKey.Back) {
        if (numeric.DecimalStr != null) {
          numeric.DecimalStr = numeric.DecimalStr!.isEmpty ? null : numeric.DecimalStr!.substring(0, numeric.DecimalStr!.length - 1);
          entry.Notify();
        } else if (numeric.IntegerStr.isNotEmpty) {
          numeric.IntegerStr = numeric.IntegerStr.substring(0, numeric.IntegerStr.length - 1);
          entry.Notify();
        } else if (entry.MoneyCalc.Values.length > 1) {
          entry.MoneyCalc.Values.removeAt(endIndex);
          entry.Notify();
        }
      } else if (key == _KeyboardKey.Dot) {
        numeric.DecimalStr ??= "";
        entry.Notify();
      } else if (key == _KeyboardKey.CalcAdd) {
        entry.MoneyCalc.Values.add(ECalcOperator.Add);
        entry.Notify();
      } else if (key == _KeyboardKey.CalcSub) {
        entry.MoneyCalc.Values.add(ECalcOperator.Sub);
        entry.Notify();
      } else {
        var keyStr = key.index.toString();
        if (numeric.DecimalStr != null) {
          if (numeric.DecimalStr!.length < 2) {
            numeric.DecimalStr = numeric.DecimalStr! + keyStr;
            entry.Notify();
          } else {
            numeric.DecimalStr = numeric.DecimalStr![0] + keyStr;
            entry.Notify();
          }
        } else {
          if (key != _KeyboardKey.N0 || numeric.IntegerStr.isNotEmpty) {
            numeric.IntegerStr += keyStr;
            entry.Notify();
          }
        }
      }
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
  CalcAdd,
  CalcSub,
}
