import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/UserDB.dart';
import 'package:quick_log_money/pages/LedgerCards/CardWidget.dart';

///账本卡片基类
abstract class CardStateBase extends State<CardWidget> {
  ///
  bool IsHasData = false;

  ///
  @protected
  String get Title;

  ///
  @protected
  String? get SubTitle => null;

  ///
  double? get ContentHeight => null;

  ///
  @override
  void initState() {
    RefreshState();
    super.initState();
  }

  ///
  @protected
  FutureOr RefreshState() {
    IsHasData = true;
  }

  @protected
  Future Delete() async {}

  ///
  @override
  Widget build(BuildContext context) {
    var content = Conditional.Single(() => IsHasData, () => BuildContent());
    final contentHeight = ContentHeight;
    if (contentHeight != null) {
      content = SizedBox(height: contentHeight, child: content);
    }

    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        BuildTitle(),
        const Divider(height: 1),
        content,
      ]),
    ));
  }

  ///
  @protected
  Widget BuildTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(SubTitle == null ? Title : "$Title($SubTitle)", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14), textAlign: TextAlign.left),
      InkWell(onTap: () => showModalBottomSheet(context: context, builder: (_) => CardSetting(this)), child: const Icon(Icons.more_horiz, color: Colors.grey))
    ]);
  }

  ///
  @protected
  Widget BuildContent();
}

///账本卡片的配置数据类型
abstract class ICardConfigurable {
  Map<String, dynamic> toJson();
}

///账本卡片存在配置文件
abstract class CardConfigStateBase<T extends ICardConfigurable> extends CardStateBase {
  late T Config = CreateConfig();

  @protected
  T CreateConfig();

  @protected
  Widget BuildConfig(BuildContext context, void Function(VoidCallback) setState, T newConfig);

  @protected
  Future SaveConfig(T newConfig) async {
    Config = newConfig;
    await UserDB.managers.userCards.filter((f) => f.Id(widget.CardData.Id)).update((o) => o(Params: drift.Value(jsonEncode(newConfig.toJson()))));
    await RefreshState();
    (context as StatefulElement).markNeedsBuild();
  }
}

///账本卡片的设置面板
class CardSetting extends StatefulWidget {
  final CardStateBase Card;
  const CardSetting(this.Card, {super.key});
  @override
  State<CardSetting> createState() => _CardSettingState();
}

class _CardSettingState extends State<CardSetting> {
  late final ICardConfigurable? NewConfig;

  @override
  void initState() {
    if (widget.Card is CardConfigStateBase) {
      NewConfig = (widget.Card as CardConfigStateBase).CreateConfig();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Center(child: Text("${widget.Card.Title}设置")),
        if (widget.Card is CardConfigStateBase) (widget.Card as CardConfigStateBase).BuildConfig(context, setState, NewConfig!) else const SizedBox(height: 10),
        _BuildBottomButtons(),
      ]),
    );
  }

  Widget _BuildBottomButtons() {
    return Row(children: [
      Expanded(
        child: TextButton(
          onPressed: () {},
          onLongPress: () => widget.Card.Delete().whenComplete(() {
            Navigator.pop(context);
            BotToast.showText(text: "${widget.Card.Title}卡片已经删除");
          }),
          child: const Text("删除卡片(长按)"),
        ),
      ),
      if (widget.Card is CardConfigStateBase) ...[
        const SizedBox(width: 8),
        Expanded(
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                (widget.Card as CardConfigStateBase).SaveConfig(NewConfig!);
              },
              child: const Text("保存")),
        ),
      ]
    ]);
  }
}
