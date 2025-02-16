import 'package:flutter/material.dart';
import 'package:quick_log_money/CommonWidgets/Ledger/Entry/TagUI.dart';
import 'package:quick_log_money/Database/LedgerDB.dart';

///
class TagListUI extends StatelessWidget {
  ///
  final Iterable<LedgerTag> Tags;
  final void Function(LedgerTag tagId) OnSelectTagHandler;
  final int? SelectTagId;
  final ScrollPhysics? Physics;

  const TagListUI(this.SelectTagId, this.Tags, this.OnSelectTagHandler, {super.key, this.Physics});

  @override
  Widget build(BuildContext context) => GridView.extent(
        maxCrossAxisExtent: 80,
        childAspectRatio: 1.45,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        shrinkWrap: true,
        physics: Physics,
        children: [for (var tag in Tags) BuildTag(context, tag)],
      );

  ///
  Widget BuildTag(BuildContext context, LedgerTag tag) => TagUI(
        BtnStyle: tag.Id == SelectTagId ? ButtonStyle(side: WidgetStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.primary, width: 1))) : null,
        ContentColor: tag.Id == SelectTagId ? Colors.blue : null,
        tag,
        () => OnSelectTagHandler(tag),
      );
}
