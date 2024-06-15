import 'package:flutter/material.dart';

extension StringHelper on String {
  void Log() => print(this);
}

extension WidgetHelper on Widget {
  Expanded WrapExpanded({int flex = 1}) => Expanded(flex: flex, child: this);
  IntrinsicWidth WrapIntrinsicWidth({double? stepWidth, double? stepHeight}) => IntrinsicWidth(stepWidth: stepWidth, stepHeight: stepHeight, child: this);
  IntrinsicHeight WrapIntrinsicHeight() => IntrinsicHeight(child: this);
}
