import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/UserDB.dart';

class CardBase<T extends CardBaseState> extends StatefulWidget {
  final T Function() CardStateBuilder;
  final UserCard CardData;
  const CardBase(this.CardData, this.CardStateBuilder, {super.key});
  @override
  // ignore: no_logic_in_create_state
  T createState() => CardStateBuilder();
}

abstract class CardBaseState extends State<CardBase> {
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
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Text(SubTitle == null ? Title : "$Title($SubTitle)",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14), textAlign: TextAlign.left)));
  }

  ///
  @protected
  Widget BuildContent();
}

///
abstract class ICardConfigurable {
  Map<String, dynamic> toJson();
}

///
abstract class CardBaseConfigState<T extends ICardConfigurable> extends CardBaseState {
  late T Config = CreateConfig();

  @protected
  T CreateConfig();

  @override
  Widget BuildTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      super.BuildTitle(),
      InkWell(
        onTap: () => showModalBottomSheet(context: context, builder: (_) => CardSetting(this)),
        child: const Icon(Icons.more_horiz, color: Colors.grey),
      ),
    ]);
  }

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

///
class CardSetting<T extends ICardConfigurable> extends StatefulWidget {
  final CardBaseConfigState Card;
  const CardSetting(this.Card, {super.key});
  @override
  State<CardSetting> createState() => _CardSettingState<T>();
}

class _CardSettingState<T extends ICardConfigurable> extends State<CardSetting> {
  late final T NewConfig;

  @override
  void initState() {
    NewConfig = widget.Card.CreateConfig() as T;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Center(child: Text("${widget.Card.Title}设置")),
        widget.Card.BuildConfig(context, setState, NewConfig),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.Card.SaveConfig(NewConfig);
            },
            child: const Text("保存"))
      ]),
    );
  }
}
