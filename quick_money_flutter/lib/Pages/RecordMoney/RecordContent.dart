import 'package:flutter/material.dart';
import 'package:quick_money_flutter/Pages/RecordMoney/RecordDescription.dart';

class RecordContent extends StatelessWidget {
  final bool IsCost;
  const RecordContent(this.IsCost, {super.key});

  @override
  Widget build(BuildContext context) {
    return RecordDescription(IsCost);
  }
}
