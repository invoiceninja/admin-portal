// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/recurring_expense_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/recurring_expense_list_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/recurring_expense_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'recurring_expense_screen_vm.dart';

class RecurringExpenseScreen extends StatelessWidget {
  const RecurringExpenseScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/recurring_expense';

  final RecurringExpenseScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    final statuses = [
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringExpenseStatusDraft
          ..name = localization!.draft,
      ),
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringExpenseStatusPending
          ..name = localization!.pending,
      ),
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringExpenseStatusActive
          ..name = localization!.active,
      ),
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringExpenseStatusPaused
          ..name = localization!.paused,
      ),
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringExpenseStatusCompleted
          ..name = localization!.completed,
      ),
    ];

    return ListScaffold(
      entityType: EntityType.recurringExpense,
      onHamburgerLongPress: () =>
          store.dispatch(StartRecurringExpenseMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.recurringExpenseListState.filterClearedAt}__'),
        entityType: EntityType.recurringExpense,
        entityIds: viewModel.recurringExpenseList,
        filter: state.recurringExpenseListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterRecurringExpenses(value));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterRecurringExpensesByStatus(status));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterRecurringExpensesByState(state));
        },
        statuses: statuses,
      ),
      onCheckboxPressed: () {
        if (store.state.recurringExpenseListState.isInMultiselect()) {
          store.dispatch(ClearRecurringExpenseMultiselect());
        } else {
          store.dispatch(StartRecurringExpenseMultiselect());
        }
      },
      body: RecurringExpenseListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.recurringExpense,
        tableColumns: RecurringExpensePresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            RecurringExpensePresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortRecurringExpenses(value));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterRecurringExpensesByStatus(status));
        },
        sortFields: [
          RecurringExpenseFields.number,
          RecurringExpenseFields.nextSendDate,
          RecurringExpenseFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterRecurringExpensesByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.recurringExpenseListState.isInMultiselect()) {
            store.dispatch(ClearRecurringExpenseMultiselect());
          } else {
            store.dispatch(StartRecurringExpenseMultiselect());
          }
        },
        statuses: statuses,
        customValues1: company.getCustomFieldValues(CustomFieldType.expense1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.expense2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.expense3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.expense4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterRecurringExpensesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterRecurringExpensesByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterRecurringExpensesByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterRecurringExpensesByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.recurringExpense)
          ? FloatingActionButton(
              heroTag: 'recurring_expense_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.recurringExpense);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newRecurringExpense,
            )
          : null,
    );
  }
}
