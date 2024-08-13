import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordEntryEditingProvider.dart';
import 'package:quick_log_money/Utilities/Pages.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';
import 'package:quick_log_money/pages/RecordMoney/RecordSaveProvider.dart';

class RecordSaveBtn extends StatelessWidget {
  final ButtonStyle? Style;

  const RecordSaveBtn({super.key, this.Style});

  @override
  Widget build(BuildContext context) => Consumer<RecordEntryEditingProvider>(builder: (BuildContext context, RecordEntryEditingProvider value, Widget? child) {
        return TextButton(
          style: Style,
          onPressed: () async {
            final err = await context.read<RecordEntryEditingProvider>().Save();
            if (err != null) {
              BotToast.showSimpleNotification(title: err, duration: Durations.extralong4);
              return;
            }
            if (!context.mounted) return;
            context.read<RecordSaveProvider>().IsSaved = true;
            BotToast.showSimpleNotification(title: "保存成功", duration: Durations.extralong4);
            if (Prefs.IsRecordSaveExit.value) {
              if (Platform.isIOS) {
                SystemChannels.platform.invokeMethod<void>("SystemNavigator.pop");
              } else {
                SystemNavigator.pop(animated: true);
              }
            } else {
              Pages.PopOrHome(context);
            }
          },
          child: Text("保存", style: TextStyle(color: value.IsIncome ? Colors.green : Colors.red)),
        );
      });
}
