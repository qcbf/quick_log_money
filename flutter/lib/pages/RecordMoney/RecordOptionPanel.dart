import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Pages/RecordMoney/RecordEntryEditingProvider.dart';
import 'package:quick_log_money/Utilities/Utility.dart';

class RecordOptionPanel extends StatelessWidget {
  const RecordOptionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Consumer<RecordEntryEditingProvider>(builder: (context, value, child) {
        return Column(
          children: [
            _BuildMoney(context, value),
            _BuildBottom(context, value),
          ],
        );
      }),
    );
  }

  ///
  Widget _BuildMoney(BuildContext context, RecordEntryEditingProvider value) {
    final text = "￥${value.MoneyCalc.GetResultStr()}";

    if (value.MoneyCalc.IsHasOperator) {
      final moneyCalcStr = value.MoneyCalc.toString();
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(child: FittedBox(child: Text(moneyCalcStr))),
        Text(text, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: value.IsIncome ? Colors.green : Colors.red, fontSize: moneyCalcStr.length > 10 ? 18 : 24)),
      ]);
    } else {
      return Text(text, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: value.IsIncome ? Colors.green : Colors.red, fontSize: 24));
    }
  }

  ///
  Row _BuildBottom(BuildContext context, RecordEntryEditingProvider value) {
    const space = 4.0;
    return Row(children: [
      _BuildDateBtn(context, value),
      const SizedBox(width: space),
      _BuildLocationBtn(context, value),
      const SizedBox(width: space),
      _BuildImageBtn(),
      Flexible(child: _BuildComment(context)),
    ]);
  }

  ///
  Widget _BuildImageBtn() => _BuildBtn("图片", () {});

  ///
  Widget _BuildLocationBtn(BuildContext context, RecordEntryEditingProvider value) {
    return _BuildBtn("位置", () async {});
  }

  ///
  Widget _BuildDateBtn(BuildContext context, RecordEntryEditingProvider value) {
    return _BuildBtn(Utility.DateToString(value.Date), () async {
      final date = await showDatePicker(context: context, firstDate: DateTime(1970), lastDate: DateTime.now().add(const Duration(days: 366 * 2)), initialDate: value.Date);
      if (date != null) {
        value.Date = date;
        value.Notify();
      }
    });
  }

  static Widget _BuildBtn(String text, VoidCallback onPressed) {
    return SizedBox(height: 26, child: TextButton(onPressed: onPressed, style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(0))), child: Text(text)));
  }

  ///
  Padding _BuildComment(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: TextField(
          textInputAction: TextInputAction.done,
          maxLength: 256,
          style: const TextStyle(fontSize: 13),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 6, top: 0, bottom: 0),
            hintText: "......点击输入备注",
            hintStyle: TextStyle(fontSize: 13),
            hintTextDirection: TextDirection.rtl,
            counterText: "",
            border: InputBorder.none,
            isDense: true,
          ),
          onChanged: (text) => context.read<RecordEntryEditingProvider>().Comment = text,
        ),
      );
}
