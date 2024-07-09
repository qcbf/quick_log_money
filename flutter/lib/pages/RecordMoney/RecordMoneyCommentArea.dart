import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/EntryEditingProvider.dart';

class RecordMoneyCommentArea extends StatelessWidget {
  const RecordMoneyCommentArea({super.key});

  @override
  Widget build(BuildContext context) => Row(children: [
        _BuildMoney(),
        _BuildComment(context),
      ]);

  Widget _BuildMoney() => Consumer<EntryEditingProvider>(builder: (context, value, child) {
        return Text("${value.GetMoneyString()}￥",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: value.IsIncome ? Colors.green : Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ));
      });

  Padding _BuildComment(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: TextField(
          textInputAction: TextInputAction.done,
          maxLength: 500,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            hintText: "备注...",
            hintStyle: TextStyle(letterSpacing: 3),
            counterText: "",
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
          onChanged: (text) => context.read<EntryEditingProvider>().Comment = text,
        ),
      );
}
