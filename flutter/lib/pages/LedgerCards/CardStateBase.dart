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
    setState(() => IsHasData = true);
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
      InkWell(onTap: OnClickSetting, child: const Icon(Icons.more_horiz, color: Colors.grey))
    ]);
  }

  @protected
  void OnClickSetting() {
    showModalBottomSheet(isScrollControlled: true, context: context, builder: (_) => CardSetting(this));
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
  State CreateConfigState();
}

///账本卡片的设置面板
class CardSetting extends StatefulWidget {
  final CardStateBase Card;
  const CardSetting(this.Card, {super.key});
  @override
  State createState() {
    // ignore: no_logic_in_create_state
    return Card is CardConfigStateBase ? (Card as CardConfigStateBase).CreateConfigState() : CardSettingState();
  }
}

/// 基础设置UI
class CardSettingState extends State<CardSetting> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(child: Text("${widget.Card.Title}设置")),
          _BuildContent(),
          BuildBottomButtons(),
        ]),
      ),
    );
  }

  @protected
  Widget _BuildContent() {
    return const SizedBox(height: 10);
  }

  @protected
  Widget BuildBottomButtons() {
    return TextButton(
      onPressed: () {},
      onLongPress: () => widget.Card.Delete().whenComplete(() {
        Navigator.pop(context);
        BotToast.showText(text: "${widget.Card.Title} 删除还没做!");
      }),
      child: const Text("删除卡片(长按)"),
    );
  }
}

///存在卡片配置的设置UI
abstract class CardConfigSettingStateBase<T extends ICardConfigurable> extends CardSettingState {
  late final T Config;

  @override
  void initState() {
    Config = (widget.Card as CardConfigStateBase<T>).CreateConfig();
    super.initState();
  }

  @override
  Widget _BuildContent() => BuildContent();
  @protected
  Widget BuildContent();

  @override
  Widget BuildBottomButtons() {
    return Row(children: [
      Expanded(child: super.BuildBottomButtons()),
      const SizedBox(width: 8),
      Expanded(child: TextButton(onPressed: SaveConfig, child: const Text("保存"))),
    ]);
  }

  @protected
  Future SaveConfig() async {
    Navigator.pop(context);
    final configCard = widget.Card as CardConfigStateBase;
    configCard.Config = Config;
    await UserDB.managers.userCards.filter((f) => f.Id(configCard.widget.CardData.Id)).update((o) => o(Params: drift.Value(jsonEncode(Config.toJson()))));
    await widget.Card.RefreshState();
  }
}
