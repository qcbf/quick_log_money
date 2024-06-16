import 'package:flutter/material.dart';

extension StringHelper on String {
  void Log() => print(this);
}

extension WidgetHelper on Widget {
  Expanded WrapExpanded({int flex = 1}) => Expanded(flex: flex, child: this);
  Padding WrapPadding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);
  Center WrapCenter({double? widthFactor, double? heightFactor}) => Center(widthFactor: widthFactor, heightFactor: heightFactor, child: this);
  IntrinsicWidth WrapIntrinsicWidth({double? stepWidth, double? stepHeight}) => IntrinsicWidth(stepWidth: stepWidth, stepHeight: stepHeight, child: this);
  IntrinsicHeight WrapIntrinsicHeight() => IntrinsicHeight(child: this);
}
