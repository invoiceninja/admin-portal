// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/recurring_expense_list_item.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/recurring_expense_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class RecurringExpenseListBuilder extends StatelessWidget {
  const RecurringExpenseListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringExpenseListVM>(
      converter: RecurringExpenseListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.recurringExpense,
            presenter: RecurringExpensePresenter(),
            state: viewModel.state,
            entityList: viewModel.recurringExpenseList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final recurringExpenseId = viewModel.recurringExpenseList[index];
              final recurringExpense =
                  viewModel.recurringExpenseMap[recurringExpenseId]!;
              final listState = state.getListState(EntityType.recurringExpense);
              final isInMultiselect = listState.isInMultiselect();

              return RecurringExpenseListItem(
                filter: viewModel.filter,
                expense: recurringExpense,
                isChecked: isInMultiselect &&
                    listState.isSelected(recurringExpense.id),
              );
            });
      },
    );
  }
}

class RecurringExpenseListVM {
  RecurringExpenseListVM({
    required this.state,
    required this.userCompany,
    required this.recurringExpenseList,
    required this.recurringExpenseMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static RecurringExpenseListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return RecurringExpenseListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.recurringExpenseListState,
      recurringExpenseList: memoizedFilteredRecurringExpenseList(
          state.getUISelection(EntityType.recurringExpense),
          state.recurringExpenseState.map,
          state.clientState.map,
          state.vendorState.map,
          state.userState.map,
          state.recurringExpenseListState,
          state.invoiceState.map,
          state.expenseCategoryState.map,
          state.staticState),
      recurringExpenseMap: state.recurringExpenseState.map,
      isLoading: state.isLoading,
      filter: state.recurringExpenseUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> recurringExpenses,
              EntityAction action) =>
          handleRecurringExpenseAction(context, recurringExpenses, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns: state.userCompany.settings
              .getTableColumns(EntityType.recurringExpense) ??
          RecurringExpensePresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortRecurringExpenses(field)),
      onClearMultielsect: () =>
          store.dispatch(ClearRecurringExpenseMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String?> recurringExpenseList;
  final BuiltMap<String, ExpenseEntity> recurringExpenseMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
