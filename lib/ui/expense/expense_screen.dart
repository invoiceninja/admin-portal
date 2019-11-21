import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'expense_screen_vm.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/expense';

  final ExpenseScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.expenseUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.expenseList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartExpenseMultiselect()),
      onCheckboxChanged: (value) {
        final expenses = viewModel.expenseList
            .map<ExpenseEntity>((expenseId) => viewModel.expenseMap[expenseId])
            .where((expense) => value != listUIState.isSelected(expense.id))
            .toList();

        handleExpenseAction(context, expenses, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.expenses,
        key: ValueKey(store.state.expenseListState.filterClearedAt),
        filter: state.expenseListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterExpenses(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.expenseListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterExpenses(value));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearExpenseMultiselect());
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.expenseListState.selectedIds.isEmpty
                ? null
                : () async {
                    final expenses = viewModel.expenseList
                        .map<ExpenseEntity>(
                            (expenseId) => viewModel.expenseMap[expenseId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: expenses,
                        context: context,
                        multiselect: true);
                    store.dispatch(ClearExpenseMultiselect());
                  },
          ),
      ],
      body: ExpenseListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.expense,
        onSelectedSortField: (value) => store.dispatch(SortExpenses(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.expense1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.expense2,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterExpensesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterExpensesByCustom2(value)),
        sortFields: [
          ExpenseFields.publicNotes,
          ExpenseFields.expenseDate,
          ExpenseFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterExpensesByState(state));
        },
        statuses: [
          ExpenseStatusEntity().rebuild((b) => b
            ..id = kExpenseStatusLogged
            ..name = localization.logged),
          ExpenseStatusEntity().rebuild(
            (b) => b
              ..id = kExpenseStatusPending
              ..name = localization.pending,
          ),
          ExpenseStatusEntity().rebuild(
            (b) => b
              ..id = kExpenseStatusInvoiced
              ..name = localization.invoiced,
          ),
        ],
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterExpensesByStatus(status));
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.expense)
          ? FloatingActionButton(
              heroTag: 'expense_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.expense);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newExpense,
            )
          : null,
    );
  }
}
