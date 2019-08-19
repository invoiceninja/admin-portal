import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_vm.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class ExpenseScreen extends StatelessWidget {
  static const String route = '/expense';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBar: AppBar(
        title: ListFilter(
          key: ValueKey(store.state.expenseListState.filterClearedAt),
          entityType: EntityType.expense,
          onFilterChanged: (value) {
            store.dispatch(FilterExpenses(value));
          },
        ),
        actions: [
          ListFilterButton(
            entityType: EntityType.expense,
            onFilterPressed: (String value) {
              store.dispatch(FilterExpenses(value));
            },
          ),
        ],
      ),
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
      floatingActionButton: user.canCreate(EntityType.expense)
          ? FloatingActionButton(
              //key: Key(ExpenseKeys.expenseScreenFABKeyString),
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(EditExpense(
                    expense: ExpenseEntity(
                        company: company, uiState: store.state.uiState),
                    context: context));
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
