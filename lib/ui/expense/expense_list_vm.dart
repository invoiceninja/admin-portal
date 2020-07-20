import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
import 'package:redux/redux.dart';

class ExpenseListBuilder extends StatelessWidget {
  const ExpenseListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseListVM>(
      converter: ExpenseListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.expense,
            presenter: ExpensePresenter(),
            state: viewModel.state,
            entityList: viewModel.expenseList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final expenseId = viewModel.expenseList[index];
              final expense = viewModel.expenseMap[expenseId];
              final client = viewModel.state.clientState.map[expense.clientId];
              final vendor = viewModel.state.vendorState.map[expense.vendorId];
              final state = viewModel.state;
              final listUIState = state.getListState(EntityType.expense);
              final isInMultiselect = listUIState.isInMultiselect();

              return ExpenseListItem(
                userCompany: viewModel.state.userCompany,
                filter: viewModel.filter,
                expense: expense,
                client: client,
                vendor: vendor,
                isChecked:
                    isInMultiselect && listUIState.isSelected(expense.id),
              );
            });
      },
    );
  }
}

class ExpenseListVM {
  ExpenseListVM({
    @required this.state,
    @required this.user,
    @required this.expenseList,
    @required this.expenseMap,
    @required this.filter,
    @required this.isLoading,
    @required this.listState,
    @required this.onRefreshed,
    @required this.tableColumns,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortColumn,
  });

  static ExpenseListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return ExpenseListVM(
      state: state,
      user: state.user,
      listState: state.expenseListState,
      expenseList: memoizedFilteredExpenseList(
          state.expenseState.map,
          state.clientState.map,
          state.vendorState.map,
          state.userState.map,
          state.expenseState.list,
          state.expenseListState),
      expenseMap: state.expenseState.map,
      isLoading: state.isLoading,
      filter: state.expenseUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.expenseListState.filterEntityId,
          entityType: state.expenseListState.filterEntityType),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.expense) ??
              ExpensePresenter.getAllTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortExpenses(field)),
    );
  }

  final AppState state;
  final UserEntity user;
  final List<String> expenseList;
  final BuiltMap<String, ExpenseEntity> expenseMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
}
