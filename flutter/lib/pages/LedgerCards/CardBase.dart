import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/UserDB.dart';

abstract class ICardable {
  final UserCard CardData;
  ICardable(this.CardData);
}

class LedgerCard<T> extends StatelessWidget {
  final Future<T> FutureValue;
  final String Title;
  final Widget Function(BuildContext context, T value) ChildBuilder;
  final Widget? Setting;
  const LedgerCard(this.Title, this.FutureValue, this.ChildBuilder, {super.key, this.Setting});
  @override
  Widget build(BuildContext context) {
    final title = Text(Title, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 11), textAlign: TextAlign.left);
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Setting != null
            ? title
            : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                title,
                IconButton(
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.more_horiz, size: 16),
                  onPressed: () {},
                )
              ]),
        const Divider(height: 1),
        FutureBuilder(future: FutureValue, builder: (context, snapshot) => snapshot.hasData ? ChildBuilder(context, snapshot.data as T) : Conditional.GlobalFallback()),
      ]),
    ));
  }
}
