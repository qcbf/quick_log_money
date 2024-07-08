import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';
import 'package:quick_log_money/Utilities/Pages.dart';

class RecordSaveBtn extends StatelessWidget {
  final ButtonStyle? Style;

  const RecordSaveBtn({super.key, this.Style});

  @override
  Widget build(BuildContext context) => Consumer<EntryEditingProvider>(
      builder: (BuildContext context, EntryEditingProvider value, Widget? child) => TextButton(
            style: Style,
            onPressed: () async {
              final err = await context.read<EntryEditingProvider>().Save();
              if (err != null) {
                BotToast.showSimpleNotification(title: err, duration: Durations.extralong4);
                return;
              }
              if (!context.mounted) return;
              if (!await Navigator.maybePop(context)) {
                if (!context.mounted) return;
                if (kDebugMode) {
                  BotToast.showSimpleNotification(title: "Debug Only>Back Home");
                  Navigator.pushNamedAndRemoveUntil(context, Pages.Home, (route) => false);
                } else {
                  SystemNavigator.pop(animated: true);
                }
              }
              BotToast.showSimpleNotification(title: "保存成功", duration: Durations.extralong4);
            },
            child: Text("保存", style: TextStyle(color: value.IsIncome ? Colors.green : Colors.red)),
          ));
}
