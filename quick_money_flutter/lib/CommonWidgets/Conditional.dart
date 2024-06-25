import 'package:flutter/material.dart';

typedef ViewBuilderContext = Widget Function(BuildContext context);
typedef ViewBuilder = Widget Function();

class Conditional {
  static ViewBuilder GlobalFallback = () => const Text("LOADING...");

  ///
  static Widget Single(bool Function() condition, ViewBuilder widgetBuilder, {ViewBuilder? fallbackBuilder}) {
    if (condition() == true) {
      return widgetBuilder();
    } else {
      return fallbackBuilder?.call() ?? GlobalFallback();
    }
  }

  ///
  static Widget SingleContext(
      BuildContext context, bool Function(BuildContext context) condition, ViewBuilderContext widgetBuilder,
      {ViewBuilderContext? fallbackBuilder}) {
    if (condition(context) == true) {
      return widgetBuilder(context);
    } else {
      return fallbackBuilder?.call(context) ?? GlobalFallback();
    }
  }

  ///
  static Widget SwitchIndexContext(
      BuildContext context, int Function(BuildContext context) condition, List<ViewBuilderContext> views,
      {ViewBuilderContext? fallbackBuilder}) {
    final result = condition(context);
    if (result < 0 || result > views.length) {
      return fallbackBuilder?.call(context) ?? GlobalFallback();
    } else {
      return views[result](context);
    }
  }

  ///
  static Widget SwitchNameContext(
      BuildContext context, String Function(BuildContext context) condition, Map<String, ViewBuilderContext> views,
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
