import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quick_log_money/Utilities/AsyncValue.dart';

typedef ViewBuilderContext = Widget Function(BuildContext context);
typedef ViewBuilder = Widget Function();
typedef ConditionBuilder = bool Function();

///
class Conditional {
  static ViewBuilder GlobalFallback = () => const Center(child: Text("LOADING...", style: TextStyle(fontSize: 10)));

  ///
  static Widget Single(ConditionBuilder condition, ViewBuilder builder, {ViewBuilder? fallbackBuilder}) {
    if (condition() == true) {
      return builder();
    } else {
      return fallbackBuilder?.call() ?? GlobalFallback();
    }
  }

  ///
  static Widget SingleContext(BuildContext context, bool Function(BuildContext context) condition, ViewBuilderContext builder, {ViewBuilderContext? fallbackBuilder}) {
    if (condition(context) == true) {
      return builder(context);
    } else {
      return fallbackBuilder?.call(context) ?? GlobalFallback();
    }
  }

  ///
  static Widget SwitchIndexContext(BuildContext context, int Function(BuildContext context) condition, List<ViewBuilderContext> views, {ViewBuilderContext? fallbackBuilder}) {
    final result = condition(context);
    if (result < 0 || result > views.length) {
      return fallbackBuilder?.call(context) ?? GlobalFallback();
    } else {
      return views[result](context);
    }
  }

  ///
  static Widget SwitchNameContext(BuildContext context, String Function(BuildContext context) condition, Map<String, ViewBuilderContext> views,
      {ViewBuilderContext? fallbackBuilder}) {
    final result = condition(context);
    if (views.containsKey(result)) {
      return views[result]!(context);
    } else {
      return fallbackBuilder?.call(context) ?? GlobalFallback();
    }
  }

  ///
  static Widget SwitchIndex(int Function() condition, List<ViewBuilder> views, {ViewBuilder? fallbackBuilder}) {
    final result = condition();
    if (result < 0 || result > views.length) {
      return fallbackBuilder?.call() ?? GlobalFallback();
    } else {
      return views[result]();
    }
  }

  ///
  static Widget SwitchName(String Function() condition, Map<String, ViewBuilder> views, {ViewBuilder? fallbackBuilder}) {
    final result = condition();
    if (views.containsKey(result)) {
      return views[result]!();
    } else {
      return fallbackBuilder?.call() ?? GlobalFallback();
    }
  }
}

///条件事件监听器
class ConditionalValueListener<T> extends StatefulWidget {
  final ValueListenable<T> Listenable;
  final Object? Condition;
  final ValueWidgetBuilder<T> Builder;
  final ViewBuilder? Fallback;
  final Widget? child;

  const ConditionalValueListener(this.Listenable, this.Condition, this.Builder, {super.key, this.child, this.Fallback});
  const ConditionalValueListener.AsyncValue(this.Listenable, this.Builder, {this.Condition, super.key, this.child, this.Fallback});

  @override
  State<ConditionalValueListener<T>> createState() => _ConditionalValueListenerState<T>();
}

class _ConditionalValueListenerState<T> extends State<ConditionalValueListener<T>> {
  late T value;
  late bool IsInited = false;

  bool CheckCondition() => (widget.Condition as Function?)?.call() ?? (widget.Listenable as AsyncValue? ?? widget.Condition as AsyncValue?)?.IsHasValue == true;

  @override
  void initState() {
    super.initState();
    widget.Listenable.addListener(_OnValueChangeEvent);
    if (CheckCondition()) {
      value = widget.Listenable.value;
      IsInited = true;
    }
  }

  @override
  void dispose() {
    widget.Listenable.removeListener(_OnValueChangeEvent);
    super.dispose();
  }

  @override
  void didUpdateWidget(ConditionalValueListener<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.Listenable != widget.Listenable) {
      oldWidget.Listenable.removeListener(_OnValueChangeEvent);
      value = widget.Listenable.value;
      widget.Listenable.addListener(_OnValueChangeEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (CheckCondition()) {
      if (!IsInited) {
        IsInited = true;
        value = widget.Listenable.value;
      }
      return widget.Builder(context, value, widget.child);
    } else {
      return (widget.Fallback ?? Conditional.GlobalFallback)();
    }
  }

  void _OnValueChangeEvent() {
    if (mounted) setState(() => value = widget.Listenable.value);
  }
}
