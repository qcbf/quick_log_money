import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';

class RecordDescription extends StatelessWidget {
  const RecordDescription({super.key});

  @override
  Widget build(BuildContext context) {
    print(LedgerDB);
    return FutureBuilder(
        future: LedgerDB.managers.ledgerEntries.get(limit: 100),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Conditional.GlobalFallback();
          return ListView.builder(
            reverse: true,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              return Text("${Utility.DateToString(data.Date)} 花费 ${data.IntMoney} 用于 ${Ledger.Tag.value.AllTags[data.TagId]!.Name} ${data.Comment}");
            },
            itemCount: snapshot.data!.length,
          );
        });
    // return ConditionalValueListener.AsyncValue(
    //     Ledger.Tag,
    //     (context, value, child) =>
    //         Card(child: Consumer<RecordEntryEditingProvider>(builder: (context, value, child) => _BuildDescriptionLabel(value.IsIncome, context, value))));
  }

  // static Widget _BuildDescriptionLabel(bool IsIncome, BuildContext context, RecordEntryEditingProvider value) {
  //   var baseTextStyle = Theme.of(context).textTheme.titleMedium!;
  //   var actionTextStyle = baseTextStyle.apply(color: Colors.blueGrey, fontSizeDelta: 2).copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline);
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
  //     child: RichText(
  //         text: TextSpan(style: baseTextStyle, children: [
  //       TextSpan(style: actionTextStyle, text: Utility.DateToString(value.Date)),
  //       TextSpan(text: IsIncome ? " 收入 " : " 花费 "),
  //       TextSpan(style: actionTextStyle.apply(color: IsIncome ? Colors.green : Colors.red, fontSizeDelta: 12), text: "${value.GetMoneyString()}￥"),
  //       TextSpan(text: IsIncome ? " 来自 " : " 用于 "),
  //       TextSpan(style: actionTextStyle, text: value.Tag.Name),
  //       const TextSpan(text: " 记录到 "),
  //       TextSpan(style: actionTextStyle, text: Ledger.Info.value.Name),
  //     ])),
  //   );
  // }
}
