import 'package:flutter/material.dart';
import 'package:quick_money_flutter/Datas/TagData.dart';

class TagUI extends StatelessWidget {
  final TagData Data;
  final VoidCallback OnPressed;
  final bool IsSelected;
  const TagUI(this.OnPressed, this.Data, {this.IsSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    var style = const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(3)), shape: WidgetStatePropertyAll(RoundedRectangleBorder()));
    if (IsSelected) {
      var theme = Theme.of(context);
      style = style.copyWith(backgroundColor: WidgetStatePropertyAll(theme.hoverColor), side: WidgetStatePropertyAll(BorderSide(color: theme.highlightColor, width: 1)));
    }
    return Padding(
      padding: const EdgeInsets.all(6),
      child: SizedBox(
        width: 68,
        height: 56,
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
              Text(
                Data.Name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
