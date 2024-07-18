import 'package:flutter/material.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Utilities/Utility.dart';

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
      style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 1, vertical: 1)), shape: WidgetStatePropertyAll(RoundedRectangleBorder()))
          .merge(BtnStyle),
      child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Image.asset(LedgerUtility.LedgerIconNameToAssetPath(Data.Icon), height: 20, excludeFromSemantics: true, errorBuilder: (a, b, c) => const Icon(Icons.sync, size: 18)),
        FittedBox(child: Text(Data.Name, style: const TextStyle(fontSize: 12).copyWith(color: ContentColor))),
      ]),
    );
  }
}
