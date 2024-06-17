import 'package:flutter/material.dart';
import 'package:quick_money_flutter/Datas/Ledger/TagData.dart';

class LedgerEntryTagUI extends StatelessWidget {
  final TagData Data;
  final VoidCallback OnPressed;
  final bool IsSelected;
  const LedgerEntryTagUI(this.OnPressed, this.Data, {this.IsSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    var style = const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.fromLTRB(2, 12, 2, 12)), shape: WidgetStatePropertyAll(RoundedRectangleBorder()));
    if (IsSelected) {
      var theme = Theme.of(context);
      style = style.copyWith(side: WidgetStatePropertyAll(BorderSide(color: theme.colorScheme.primary, width: 1)));
    }
    return Padding(
      padding: const EdgeInsets.all(1),
      child: SizedBox(
        width: 62,
        height: 48,
        child: TextButton(
          onPressed: OnPressed,
          style: style,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.home,
                size: 20,
              ),
              FittedBox(
                child: Text(
                  Data.Name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
