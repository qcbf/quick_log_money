import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';

class TagUI extends StatelessWidget {
  final LedgerTag Data;
  final VoidCallback OnPressed;
  final ButtonStyle? BtnStyle;
  final Color? ContentColor;

  const TagUI(this.Data, this.OnPressed, {super.key, this.BtnStyle, this.ContentColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: OnPressed,
      style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10, horizontal: 2)), shape: WidgetStatePropertyAll(RoundedRectangleBorder()))
          .merge(BtnStyle),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Icon(
          const IconData(59261, fontFamily: "Ledger"),
          size: 18,
          color: ContentColor,
        ),
        FittedBox(child: Text(Data.Name, style: const TextStyle(fontSize: 12).copyWith(color: ContentColor))),
      ]),
    );
  }
}
