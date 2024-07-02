import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';

class RecordSaveBtn extends StatelessWidget {
  final ButtonStyle? Style;

  const RecordSaveBtn({super.key, this.Style});

  @override
  Widget build(BuildContext context) => Consumer<EntryEditingProvider>(
      builder: (BuildContext context, EntryEditingProvider value, Widget? child) => TextButton(
            style: Style,
            onPressed: () => context.read<EntryEditingProvider>().Save().whenComplete(() => Navigator.pop(context)),
            child: Text("保存", style: TextStyle(color: value.IsIncome ? Colors.green : Colors.red)),
          ));
}
