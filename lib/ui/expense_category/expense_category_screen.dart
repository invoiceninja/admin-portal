// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_list_vm.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'expense_category_screen_vm.dart';

class ExpenseCategoryScreen extends StatelessWidget {
  const ExpenseCategoryScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsExpenseCategories';

  final ExpenseCategoryScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.expenseCategory,
      onHamburgerLongPress: () =>
          store.dispatch(StartExpenseCategoryMultiselect()),
      onCancelSettingsSection: kSettingsExpenses,
      onCheckboxPressed: () {
        if (store.state.expenseCategoryListState.isInMultiselect()) {
          store.dispatch(ClearExpenseCategoryMultiselect());
        } else {
          store.dispatch(StartExpenseCategoryMultiselect());
        }
      },
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.expenseCategoryListState.filterClearedAt}__'),
        entityType: EntityType.expenseCategory,
        entityIds: viewModel.expenseCategoryList,
        filter: state.expenseCategoryListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterExpenseCategories(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterExpenseCategoriesByState(state));
        },
      ),
      body: ExpenseCategoryListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.expenseCategory,
        tableColumns: ExpenseCategoryPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            ExpenseCategoryPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortExpenseCategories(value));
        },
        sortFields: [
          ExpenseCategoryFields.name,
          EntityFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterExpenseCategoriesByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.expenseCategoryListState.isInMultiselect()) {
            store.dispatch(ClearExpenseCategoryMultiselect());
          } else {
            store.dispatch(StartExpenseCategoryMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterExpenseCategoriesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterExpenseCategoriesByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterExpenseCategoriesByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterExpenseCategoriesByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.expenseCategory)
          ? FloatingActionButton(
              heroTag: 'expense_category_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.expenseCategory);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newExpenseCategory,
            )
          : null,
    );
  }
}
