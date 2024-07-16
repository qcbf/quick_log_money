// import 'package:flutter/material.dart';
// import 'package:quick_log_money/CommonWidgets/Conditional.dart';
// import 'package:quick_log_money/Database/LedgerDB.dart';
// import 'package:quick_log_money/Utilities/Utility.dart';

// class RecordDescription extends StatelessWidget {
//   const RecordDescription({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: LedgerDB.managers.ledgerEntries.get(limit: 100),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Conditional.GlobalFallback();
//           return ListView.builder(
//             reverse: true,
//             itemBuilder: (context, index) {
//               final data = snapshot.data![index];
//               return Text("${Utility.DateToString(data.Date)} 花费 ${data.IntMoney} 用于 ${Ledger.ExpenseTag.value.AllTags[data.TagId]!.Name} ${data.Comment}");
//             },
//             itemCount: snapshot.data!.length,
//           );
//         });
//   }
// }
