import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("设置")),
      body: _BuildContent(),
    );
  }

  Widget _BuildContent() {
    return ListView(children: [
      _BuildSettingGroup(_BuildCommon()),
      _BuildSettingGroup(_BuildRecord()),
    ]);
  }

  Widget _BuildSettingGroup(List<Widget> children) {
    return Card(child: Column(children: children));
  }

  ///
  List<Widget> _BuildCommon() {
    return [
      ///
      ListTile(
          title: const Text("主题"),
          trailing: DropdownButton(
              value: 0,
              items: const [DropdownMenuItem(value: 0, child: Text("自动")), DropdownMenuItem(value: 1, child: Text("黑暗")), DropdownMenuItem(value: 2, child: Text("白色"))],
              onChanged: (value) {})),

      ///
      ListTile(
          title: const Text("语言"),
          trailing: DropdownButton(
              value: 0,
              items: const [
                DropdownMenuItem(value: 0, child: Text("中文")),
                DropdownMenuItem(value: 1, child: Text("英文")),
              ],
              onChanged: (value) {})),
      SwitchListTile(title: const Text("打开就记账"), value: Prefs.IsFirstPageToRecord.value, onChanged: (v) => setState(() => Prefs.IsFirstPageToRecord.value = v)),
      SwitchListTile(title: const Text("保存记账自动退出APP"), value: Prefs.IsRecordSaveExit.value, onChanged: (v) => setState(() => Prefs.IsRecordSaveExit.value = v)),
      ListTile(
          title: const Text("记账键盘高度"),
          trailing: SizedBox(
            width: 80,
            child: TextField(
                textAlign: TextAlign.center,
                keyboardType: Platform.isIOS ? null : TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: TextEditingController(text: Prefs.RecordKeyboardHeight.value.toString()),
                onSubmitted: (value) => Prefs.RecordKeyboardHeight.value = double.tryParse(value)?.clamp(100, 800) ?? 400),
          )),
    ];
  }

  ///
  List<Widget> _BuildRecord() {
    return [
      ///
      FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Conditional.GlobalFallback();
            return AboutListTile(
              applicationIcon: Image.asset(Def.IconPath, width: 64),
              applicationVersion: snapshot.data?.version,
              applicationName: "随手速记账",
              applicationLegalese: "qcbf@qq.com",
              child: const Text("关于"),
            );
          }),
    ];
  }
}
