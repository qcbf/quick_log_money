import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';
import 'package:quick_log_money/Utilities/Utility.dart';

class RecordDescription extends StatelessWidget {
  const RecordDescription({super.key});

  @override
  Widget build(BuildContext context) =>
      Card(child: Consumer<EntryEditingProvider>(builder: (context, value, child) => _BuildDescriptionLabel(value.IsCost, context, value)));

  static Widget _BuildDescriptionLabel(bool isCost, BuildContext context, EntryEditingProvider value) {
    var baseTextStyle = Theme.of(context).textTheme.titleMedium!;
    var actionTextStyle =
        baseTextStyle.apply(color: Colors.blueGrey, fontSizeDelta: 2).copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline);
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
      child: RichText(
          text: TextSpan(style: baseTextStyle, children: [
        TextSpan(style: actionTextStyle, text: Utility.DateToString(value.Data.Date)),
        TextSpan(text: isCost ? " 花费 " : " 收入 "),
        TextSpan(style: actionTextStyle.apply(color: isCost ? Colors.red : Colors.green, fontSizeDelta: 12), text: "${value.GetMoneyString()}￥"),
        TextSpan(text: isCost ? " 用于 " : " 来自 "),
        TextSpan(style: actionTextStyle, text: value.Data.GetTagName()),
        const TextSpan(text: " 记录到 "),
        TextSpan(style: actionTextStyle, text: value.Data.GetBookName()),
      ])),
    );
  }
}
