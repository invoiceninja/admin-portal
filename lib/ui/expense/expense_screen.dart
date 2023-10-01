// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_vm.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_presenter.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'expense_screen_vm.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({
    Key? key,
    required this.viewModel,
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

    final statuses = [
      ExpenseStatusEntity().rebuild((b) => b
        ..id = kExpenseStatusLogged
        ..name = localization!.logged),
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kExpenseStatusPending
          ..name = localization!.pending,
      ),
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kExpenseStatusInvoiced
          ..name = localization!.invoiced,
      ),
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kExpenseStatusPaid
          ..name = localization!.paid,
      ),
      ExpenseStatusEntity().rebuild(
        (b) => b
          ..id = kExpenseStatusUnpaid
          ..name = localization!.unpaid,
      ),
    ];

    return ListScaffold(
      entityType: EntityType.expense,
      onHamburgerLongPress: () => store.dispatch(StartExpenseMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.expenseListState.filterClearedAt}__'),
        entityType: EntityType.expense,
        entityIds: viewModel.expenseList,
        filter: state.expenseListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterExpenses(value));
        },
        statuses: statuses,
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterExpensesByState(state));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterExpensesByStatus(status as ExpenseStatusEntity));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.expenseListState.isInMultiselect()) {
          store.dispatch(ClearExpenseMultiselect());
        } else {
          store.dispatch(StartExpenseMultiselect());
        }
      },
      body: ExpenseListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.expense,
        iconButtons: [
          IconButton(
              icon: Icon(getEntityIcon(EntityType.settings)),
              onPressed: () {
                store.dispatch(ViewSettings(
                  section: kSettingsExpenses,
                  company: state.company,
                ));
              })
        ],
        tableColumns: ExpensePresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            ExpensePresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) => store.dispatch(SortExpenses(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.expense1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.expense2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.expense3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.expense4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterExpensesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterExpensesByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterExpensesByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterExpensesByCustom4(value)),
        sortFields: [
          ExpenseFields.number,
          ExpenseFields.expenseDate,
          ExpenseFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterExpensesByState(state));
        },
        statuses: statuses,
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterExpensesByStatus(status as ExpenseStatusEntity));
        },
        onCheckboxPressed: () {
          if (store.state.expenseListState.isInMultiselect()) {
            store.dispatch(ClearExpenseMultiselect());
          } else {
            store.dispatch(StartExpenseMultiselect());
          }
        },
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.expense)
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
              tooltip: localization!.newExpense,
            )
          : null,
    );
  }
}
