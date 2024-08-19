import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordEntryEditingProvider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordRecentTags.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordSaveBtn.dart';
import 'package:quick_log_money/Utilities/Pages.dart';

/// 底部输入键盘
class RecordKeyboardPanel extends StatelessWidget {
  final ButtonStyle _BtnStyle = const ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder()));

  const RecordKeyboardPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var children = [Expanded(flex: 35, child: _BuildLeftMenu(context)), Expanded(flex: 10, child: _BuildRightMenu(context))];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
    final entry = context.read<RecordEntryEditingProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 220,
          child: Padding(
            padding: paddingValue,
            child: Consumer<RecordEntryEditingProvider>(builder: (BuildContext context, RecordEntryEditingProvider value, Widget? child) => RecordSaveBtn(Style: style)),
          ),
        ),
        if (entry.Id != null)
          Expanded(
            flex: 100,
            child: Padding(
              padding: paddingValue,
              child: TextButton(
                style: style,
                onPressed: () => _OnClickDelete(context, false),
                onLongPress: () => _OnClickDelete(context, true),
                child: const Icon(Icons.delete_forever),
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
      entry.SetState(() => entry.MoneyCalc.Clear());
      return;
    }

    var endIndex = entry.MoneyCalc.Values.length - 1;
    final calc = entry.MoneyCalc.Values[endIndex];
    if (calc is ECalcOperator) {
      if (key == _KeyboardKey.CalcAdd) {
        entry.SetState(() => entry.MoneyCalc.Values[endIndex] = ECalcOperator.Add);
      } else if (key == _KeyboardKey.CalcSub) {
        entry.SetState(() => entry.MoneyCalc.Values[endIndex] = ECalcOperator.Sub);
      } else if (key == _KeyboardKey.Back) {
        entry.SetState(() => entry.MoneyCalc.Values.removeAt(endIndex));
      } else {
        entry.SetState(() => entry.MoneyCalc.Values.add(CalcNumeric(IntegerStr: key.index.toString())));
      }
    } else {
      final numeric = calc as CalcNumeric;
      if (key == _KeyboardKey.Back) {
        if (numeric.DecimalStr != null) {
          entry.SetState(() => numeric.DecimalStr = numeric.DecimalStr!.isEmpty ? null : numeric.DecimalStr!.substring(0, numeric.DecimalStr!.length - 1));
        } else if (numeric.IntegerStr.isNotEmpty && (entry.MoneyCalc.Values.length == 1 || numeric.IntegerStr.length > 1)) {
          entry.SetState(() => numeric.IntegerStr = numeric.IntegerStr.substring(0, numeric.IntegerStr.length - 1));
        } else if (entry.MoneyCalc.Values.length > 1) {
          entry.SetState(() => entry.MoneyCalc.Values.removeAt(endIndex));
        }
      } else if (key == _KeyboardKey.Dot) {
        entry.SetState(() => numeric.DecimalStr ??= "");
      } else if (key == _KeyboardKey.CalcAdd) {
        entry.SetState(() => entry.MoneyCalc.Values.add(ECalcOperator.Add));
      } else if (key == _KeyboardKey.CalcSub) {
        entry.SetState(() => entry.MoneyCalc.Values.add(ECalcOperator.Sub));
      } else {
        var keyStr = key.index.toString();
        if (numeric.DecimalStr != null) {
          if (numeric.DecimalStr!.length < 2) {
            entry.SetState(() => numeric.DecimalStr = numeric.DecimalStr! + keyStr);
          } else {
            entry.SetState(() => numeric.DecimalStr = numeric.DecimalStr![0] + keyStr);
          }
        } else {
          if (key != _KeyboardKey.N0 || numeric.IntegerStr.isNotEmpty) {
            entry.SetState(() => numeric.IntegerStr += keyStr);
          }
        }
      }
    }
  }

  void _OnClickDelete(BuildContext context, bool isLongPress) {
    if (!isLongPress) {
      BotToast.showSimpleNotification(title: "长按删除这条账单", align: Alignment.bottomCenter);
      return;
    }
    context.read<RecordEntryEditingProvider>().Delete();

    Pages.PopOrHome(context);
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
