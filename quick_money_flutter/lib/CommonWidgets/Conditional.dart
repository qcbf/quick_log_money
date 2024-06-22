import 'package:flutter/material.dart';

/// Conditional rendering class
class Conditional {
  static Widget Function(BuildContext context) GlobalFallback = (context) => Text("LOADING...", style: Theme.of(context).textTheme.labelSmall);

  static Widget Single(BuildContext context, bool Function(BuildContext context) conditionBuilder, Widget Function(BuildContext context) widgetBuilder,
      {Widget Function(BuildContext context)? fallbackBuilder}) {
    if (conditionBuilder(context) == true) {
      return widgetBuilder(context);
    } else {
      return fallbackBuilder?.call(context) ?? GlobalFallback(context);
    }
  }

  // static List<Widget> list({
  //   required BuildContext context,
  //   required bool Function(BuildContext context) conditionBuilder,
  //   required List<Widget> Function(BuildContext context) widgetBuilder,
  //   List<Widget> Function(BuildContext context)? fallbackBuilder,
  // }) {
  //   if (conditionBuilder(context) == true) {
  //     return widgetBuilder(context);
  //   } else {
  //     return fallbackBuilder?.call(context) ?? [];
  //   }
  // }
}
