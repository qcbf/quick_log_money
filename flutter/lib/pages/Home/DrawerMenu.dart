import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/Utilities/CommonIcons.dart';
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
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _BuildUserInfo(),
        const SizedBox(height: 10),

        ///
        ListTile(
            leading: const Icon(CommonIcons.Ledger),
            title: const Text("账本"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Ledger.Info.value.Name),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {}),

        ///
        ListTile(
          leading: const Icon(Icons.search),
          title: const Text("搜索账单"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),

        ///
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("设置"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, Pages.Setting),
        ),
      ]),
    ));
  }

  ///
  Widget _BuildUserInfo() {
    return ListTile(
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(User.Info.Name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(width: 2),
          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 18, child: Icon(CommonIcons.Vip, color: 1 == 2 ? Colors.blue : Colors.grey)),
            Text(User.Id.toString(), style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 10)),
          ]),
        ],
      ),
    );
  }

  ///
  ListTile _BuildFirstPageToRecord() {
    return ListTile(
      leading: const Icon(Icons.settings),
      title: const Text("首次打开记账"),
      trailing: ValueListenableBuilder(
          valueListenable: Prefs.IsFirstPageToRecord,
          builder: (context, value, child) {
            return Switch(
                value: value,
                onChanged: (value) {
                  Prefs.IsFirstPageToRecord.value = value;
                });
          }),
    );
  }

  ///
  Widget _BuildLogout(BuildContext context) {
    return ListTile(
      title: const Text("注销登录"),
      leading: const Icon(Icons.settings),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final cancel = BotToast.showLoading();
        Navigator.pushNamedAndRemoveUntil(context, Pages.Login, (_) => false);
        await UserDBHelper.Loginout();
        cancel();
      },
    );
  }
}
