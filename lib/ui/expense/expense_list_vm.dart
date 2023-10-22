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
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_item.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseListBuilder extends StatelessWidget {
  const ExpenseListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseListVM>(
      converter: ExpenseListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.expense,
            presenter: ExpensePresenter(),
            state: viewModel.state,
            entityList: viewModel.expenseList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final expenseId = viewModel.expenseList[index];
              final expense = viewModel.expenseMap[expenseId]!;
              final state = viewModel.state;
              final listUIState = state.getListState(EntityType.expense);

              return ExpenseListItem(
                filter: viewModel.filter,
                expense: expense,
                isChecked: listUIState.isSelected(expense.id),
                showCheckbox: listUIState.isInMultiselect(),
              );
            });
      },
    );
  }
}

class ExpenseListVM {
  ExpenseListVM({
    required this.state,
    required this.user,
    required this.expenseList,
    required this.expenseMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static ExpenseListVM fromStore(Store<AppState> store) {
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

    return ExpenseListVM(
      state: state,
      user: state.user,
      listState: state.expenseListState,
      expenseList: memoizedFilteredExpenseList(
          state.getUISelection(EntityType.expense),
          state.expenseState.map,
          state.clientState.map,
          state.vendorState.map,
          state.userState.map,
          state.expenseListState,
          state.invoiceState.map,
          state.expenseCategoryState.map,
          state.staticState),
      expenseMap: state.expenseState.map,
      isLoading: state.isLoading,
      filter: state.expenseUIState.listUIState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.expense) ??
              ExpensePresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortExpenses(field)),
      onClearMultielsect: () => store.dispatch(ClearExpenseMultiselect()),
    );
  }

  final AppState state;
  final UserEntity? user;
  final List<String?> expenseList;
  final BuiltMap<String, ExpenseEntity> expenseMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
