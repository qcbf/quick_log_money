import 'package:flutter/material.dart';

typedef ViewBuilder = Widget Function(BuildContext context);

class Conditional {
  static ViewBuilder GlobalFallback = (context) => Text("LOADING...", style: Theme.of(context).textTheme.labelSmall);

  static Widget Single(BuildContext context, bool Function(BuildContext context) condition, ViewBuilder widgetBuilder, {ViewBuilder? fallbackBuilder}) {
    if (condition(context) == true) {
      return widgetBuilder(context);
    } else {
      return fallbackBuilder?.call(context) ?? GlobalFallback(context);
    }
  }

  ///
  static Widget SwitchIndex(BuildContext context, int Function(BuildContext context) condition, List<ViewBuilder> views, {ViewBuilder? fallbackBuilder}) {
    final result = condition(context);
    if (result < 0 || result > views.length) {
      return fallbackBuilder?.call(context) ?? GlobalFallback(context);
    } else {
      return views[result](context);
    }
  }

  ///
  static Widget SwitchName(BuildContext context, String Function(BuildContext context) condition, Map<String, ViewBuilder> views,
      {ViewBuilder? fallbackBuilder}) {
    final result = condition(context);
    if (views.containsKey(result)) {
      return views[result]!(context);
    } else {
      return fallbackBuilder?.call(context) ?? GlobalFallback(context);
    }
  }
}
