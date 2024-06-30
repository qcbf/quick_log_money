import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Datas/UserData.dart';
import 'package:quick_log_money/Utilities/Pages.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';
import 'package:quick_log_money/Utilities/Utility.dart';

///抽屉菜单
class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      BuildUserInfo(),
      BuildFirstPageToRecord(),
      BuildLogout(context),
    ]));
  }

  ///
  Widget BuildUserInfo() {
    return ValueListenableBuilder(
        valueListenable: UserDataProvider.Global,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value.Name, style: Theme.of(context).textTheme.headlineMedium),
                Text("ID:${value.Id}", style: Theme.of(context).textTheme.labelMedium),
                Conditional.SwitchIndex(() {
                  if (value.Token == null) {
                    return 0;
                  } else if (value.VipExpiryDate == null) {
                    return 1;
                  }
                  return 2;
                }, [
                  () => TextButton(onPressed: () {}, child: const Text("注册正式用户")),
                  () => TextButton(onPressed: () {}, child: const Text("开通vip")),
                  () => TextButton(onPressed: () {}, child: Text("Vip${Utility.DateToString(value.VipExpiryDate!)}到期")),
                ]),
              ],
            ),
          );
        });
  }

  ///
  ListTile BuildFirstPageToRecord() {
    return ListTile(
      leading: const Icon(Icons.settings),
      title: const Text("first page to record"),
      trailing: ValueListenableBuilder(
          valueListenable: UserPrefs.IsFirstPageToRecord,
          builder: (context, value, child) {
            return Switch(
                value: value,
                onChanged: (value) {
                  UserPrefs.IsFirstPageToRecord.value = value;
                });
          }),
    );
  }

  ///
  Widget BuildLogout(BuildContext context) {
    return ListTile(
      title: const Text("注销登录"),
      leading: const Icon(Icons.settings),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final cancel = BotToast.showLoading();
        Navigator.pushNamedAndRemoveUntil(context, Pages.Login, (_) => false);
        await UserDataProvider.Global.SetValue(null);
        cancel();
      },
    );
  }
}
