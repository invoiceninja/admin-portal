import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/view/transaction_rule_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TransactionRuleView extends StatefulWidget {
  const TransactionRuleView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final TransactionRuleViewVM viewModel;
  final bool isFilter;

  @override
  _TransactionRuleViewState createState() => new _TransactionRuleViewState();
}

class _TransactionRuleViewState extends State<TransactionRuleView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final transactionRule = viewModel.transactionRule;
    final localization = AppLocalization.of(context)!;
    final state = viewModel.state;

    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final textStyle = TextStyle(color: textColor.withOpacity(.65));

    final transactionStats = memoizedTransactionStatsForTransactionRule(
        transactionRule.id, state.transactionState.map);

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: transactionRule,
      title: transactionRule.name,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(
        children: <Widget>[
          EntityHeader(
            entity: transactionRule,
            label: localization.total,
            value: formatNumber(transactionStats.total, context,
                currencyId: transactionStats.currencyId),
            secondLabel: localization.count,
            secondValue:
                '${transactionStats.countActive! + transactionStats.countArchived!}',
          ),
          ListDivider(),
          FieldGrid({
            localization.matchAllRules: transactionRule.matchesOnAll
                ? localization.enabled
                : localization.disabled,
            localization.autoConvert: transactionRule.autoConvert
                ? localization.enabled
                : localization.disabled,
            localization.vendor:
                state.vendorState.get(transactionRule.vendorId).name,
            localization.category:
                state.expenseCategoryState.get(transactionRule.categoryId).name,
          }),
          if (transactionRule.rules.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: 4),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    localization.field,
                    style: textStyle,
                  )),
                  Expanded(
                    child: Text(
                      localization.operator,
                      style: textStyle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      localization.value,
                      style: textStyle,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            for (var rule in transactionRule.rules)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(localization.lookup(rule.searchKey)),
                    ),
                    Expanded(
                      child: Text(localization.lookup(rule.operator)),
                    ),
                    Expanded(
                      child: Text(rule.value),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            ListDivider(),
          ],
          EntitiesListTile(
            entity: transactionRule,
            isFilter: widget.isFilter,
            entityType: EntityType.transaction,
            title: localization.transactions,
            subtitle: transactionStats.present(
                localization.active, localization.archived),
            hideNew: true,
          ),
        ],
      ),
    );
  }
}
