import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_money_flutter/Datas/Ledger/Entry/EntryEditingData.dart';
import 'package:quick_money_flutter/FLib/extensions_helper.dart';

class RecordDescription extends StatelessWidget {
  const RecordDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: Consumer<EntryEditingData>(builder: (context, value, child) => _BuildDescriptionLabel(value.IsCost, context, value)));
  }

  static Widget _BuildDescriptionLabel(bool isCost, BuildContext context, EntryEditingData value) {
    var baseTextStyle = Theme.of(context).textTheme.titleMedium!;
    var actionTextStyle = baseTextStyle.apply(color: Colors.blueGrey, fontSizeDelta: 2).copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline);
    return RichText(
        text: TextSpan(style: baseTextStyle, children: [
      TextSpan(style: actionTextStyle, text: value.GetDateTime()),
      TextSpan(text: isCost ? " 花费 " : " 收入 "),
      TextSpan(style: actionTextStyle.apply(color: isCost ? Colors.red : Colors.green, fontSizeDelta: 12), text: "${value.GetMoneyString()}￥"),
      TextSpan(text: isCost ? " 用于 " : " 来自 "),
      TextSpan(style: actionTextStyle, text: value.GetTagName()),
      const TextSpan(text: " 记录到 "),
      TextSpan(style: actionTextStyle, text: value.GetBookName()),
    ])).WrapPadding(const EdgeInsets.fromLTRB(22, 10, 22, 10));
  }
}
