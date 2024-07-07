import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            onPressed: () => context.read<EntryEditingProvider>().Save().whenComplete(() async {
              if (!await Navigator.maybePop(context)) {
                if (!context.mounted) return;
                if (kDebugMode) {
                  BotToast.showSimpleNotification(title: "Debug Only>Back Home");
                  Navigator.pushNamedAndRemoveUntil(context, Pages.Home, (route) => false);
                } else {
                  exit(0);
                }
              }
            }),
            child: Text("保存", style: TextStyle(color: value.IsIncome ? Colors.green : Colors.red)),
          ));
}
