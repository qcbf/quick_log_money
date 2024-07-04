import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';

class TagUI extends StatelessWidget {
  final LedgerTag Data;
  final VoidCallback OnPressed;
  final ButtonStyle? Style;

  const TagUI(this.Data, this.OnPressed, {super.key, this.Style});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: OnPressed,
      style:
          const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 10)), shape: WidgetStatePropertyAll(RoundedRectangleBorder())).merge(Style),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        const Icon(IconData(59261, fontFamily: "Ledger"), size: 18),
        FittedBox(child: Text(Data.Name, style: const TextStyle(fontSize: 12))),
      ]),
    );
  }
}
