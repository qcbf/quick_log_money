import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quick_log_money/CommonWidgets/Conditional.dart';
import 'package:quick_log_money/Database/UserDB.dart';

abstract class ICardable {
  final UserCard CardData;
  ICardable(this.CardData);
}

class LedgerCard<T> extends StatefulWidget {
  final Future<T> FutureValue;
  final String Title;
  final Widget Function(BuildContext context, T value) ChildBuilder;
  final Widget? SettingPanel;
  const LedgerCard(this.Title, this.FutureValue, this.ChildBuilder, {super.key, this.SettingPanel});
  // if (SettingPanel != null) {
  //   Setting = OverlayEntry(builder: (context) {
  //     return Material(
  //         color: Colors.black.withAlpha(200),
  //         child: Padding(padding: const EdgeInsets.all(8), child: Column(children: [_BuildSettingHead(), SettingPanel]))).animate().fadeIn();
  //   });
  // }
  @override
  State<LedgerCard<T>> createState() => _LedgerCardState<T>();
}

class _LedgerCardState<T> extends State<LedgerCard<T>> {
  late final OverlayEntry? _Setting;
  bool _IsCloseSetting = false;

  @override
  void initState() {
    _Setting = widget.SettingPanel == null
        ? null
        : OverlayEntry(builder: (context) {
            return Animate(
              key: ValueKey(_IsCloseSetting),
              effects: [FadeEffect(duration: Durations.short3, begin: _IsCloseSetting ? 1 : 0, end: _IsCloseSetting ? 0 : 1)],
              onComplete: (controller) {
                if (_IsCloseSetting) {
                  _Setting!.remove();
                }
              },
              child: Material(
                  color: Colors.black.withAlpha(200),
                  child: Padding(padding: const EdgeInsets.all(8), child: Column(children: [_BuildSettingHead(context), widget.SettingPanel!]))),
            );
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text(widget.Title, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14), textAlign: TextAlign.left));

    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _Setting == null
            ? Center(child: title)
            : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                title,
                InkWell(
                  onTap: () {
                    _IsCloseSetting = false;
                    Overlay.of(context).insert(_Setting!);
                  },
                  child: const Icon(Icons.more_horiz, color: Colors.grey),
                ),
              ]),
        const Divider(height: 1),
        FutureBuilder(
            future: widget.FutureValue, builder: (context, snapshot) => snapshot.hasData ? widget.ChildBuilder(context, snapshot.data as T) : Conditional.GlobalFallback()),
      ]),
    ));
  }

  Widget _BuildSettingHead(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          onPressed: () {
            _IsCloseSetting = true;
            (context as StatefulElement).markNeedsBuild();
          },
          icon: const Icon(Icons.keyboard_backspace)),
      IconButton(
          onPressed: () {
            _IsCloseSetting = true;
            (context as StatefulElement).markNeedsBuild();
            (this.context as StatefulElement).markNeedsBuild();
          },
          icon: const Icon(Icons.check)),
    ]);
  }
}
