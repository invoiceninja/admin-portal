import 'dart:async';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';

class ExpenseListBuilder extends StatelessWidget {
  const ExpenseListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseListVM>(
      converter: ExpenseListVM.fromStore,
      builder: (context, viewModel) {
        return ExpenseList(
          viewModel: viewModel,
        );
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
    @required this.isLoaded,
    @required this.onExpenseTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
  });

  static ExpenseListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadExpenses(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return ExpenseListVM(
      state: state,
      user: state.user,
      listState: state.expenseListState,
      expenseList: memoizedFilteredExpenseList(state.expenseState.map,
          state.clientState.map, state.vendorState.map,
          state.expenseState.list, state.expenseListState),
      expenseMap: state.expenseState.map,
      isLoading: state.isLoading,
      isLoaded: state.expenseState.isLoaded,
      filter: state.expenseUIState.listUIState.filter,
      onClearEntityFilterPressed: () =>
          store.dispatch(FilterExpensesByEntity()),
      onViewEntityFilterPressed: (BuildContext context) {
        switch (state.expenseListState.filterEntityType) {
          case EntityType.client:
            store.dispatch(ViewClient(
                clientId: state.expenseListState.filterEntityId,
                context: context));
            break;
          case EntityType.vendor:
            store.dispatch(ViewVendor(
                vendorId: state.expenseListState.filterEntityId,
                context: context));
            break;
        }
      },
      onExpenseTap: (context, expense) {
        store.dispatch(ViewExpense(expenseId: expense.id, context: context));
      },
      onEntityAction:
          (BuildContext context, BaseEntity expense, EntityAction action) =>
              handleExpenseAction(context, expense, action),
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final AppState state;
  final UserEntity user;
  final List<int> expenseList;
  final BuiltMap<int, ExpenseEntity> expenseMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ExpenseEntity) onExpenseTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, ExpenseEntity, EntityAction) onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
}
