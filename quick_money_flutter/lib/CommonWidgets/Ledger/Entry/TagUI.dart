import 'package:flutter/material.dart';
import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';

class TagUI extends StatelessWidget {
  final TagData Data;
  final VoidCallback OnPressed;
  final ButtonStyle? Style;

  const TagUI(this.Data, this.OnPressed, {super.key, this.Style});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: SizedBox(
          height: 38,
          child: TextButton(
            onPressed: OnPressed,
            style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 10)), shape: WidgetStatePropertyAll(RoundedRectangleBorder()))
                .merge(Style),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Icon(Icons.apple, size: 18),
              FittedBox(child: Text(Data.Name, style: const TextStyle(fontSize: 12))),
            ]),
          ),
        ),
      ),
    );
  }
}
