// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/expense_category/view/expense_category_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseCategoryView extends StatefulWidget {
  const ExpenseCategoryView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final ExpenseCategoryViewVM viewModel;
  final bool isFilter;

  @override
  _ExpenseCategoryViewState createState() => new _ExpenseCategoryViewState();
}

class _ExpenseCategoryViewState extends State<ExpenseCategoryView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final expenseCategory = viewModel.expenseCategory;
    final localization = AppLocalization.of(context)!;
    final amount = memoizedCalculateExpenseCategoryAmount(
        expenseCategory.id, viewModel.state.expenseState.map);

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: expenseCategory,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(
        children: <Widget>[
          EntityHeader(
              entity: expenseCategory,
              label: localization.total,
              value: formatNumber(amount, context)),
          ListDivider(),
          EntitiesListTile(
            entity: expenseCategory,
            isFilter: widget.isFilter,
            entityType: EntityType.expense,
            title: localization.expenses,
            subtitle: memoizedExpenseStatsForExpenseCategory(
                    expenseCategory.id, state.expenseState.map)
                .present(localization.active, localization.archived),
          ),
          if (state.company.isModuleEnabled(EntityType.transaction))
            EntitiesListTile(
              entity: expenseCategory,
              isFilter: widget.isFilter,
              entityType: EntityType.transaction,
              title: localization.transactions,
              subtitle: memoizedTransactionStatsForExpenseCategory(
                      expenseCategory.id, state.transactionState.map)
                  .present(localization.active, localization.archived),
            ),
        ],
      ),
    );
  }
}
