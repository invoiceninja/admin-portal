import 'dart:async';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/view/recurring_expense_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class RecurringExpenseViewScreen extends StatelessWidget {
  const RecurringExpenseViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  static const String route = '/recurring_expense/view';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringExpenseViewVM>(
      converter: (Store<AppState> store) {
        return RecurringExpenseViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return RecurringExpenseView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class RecurringExpenseViewVM {
  RecurringExpenseViewVM({
    @required this.state,
    @required this.recurringExpense,
    @required this.company,
    @required this.onEntityAction,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory RecurringExpenseViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final recurringExpense = state.recurringExpenseState
            .map[state.recurringExpenseUIState.selectedId] ??
        ExpenseEntity(id: state.recurringExpenseUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadRecurringExpense(
          completer: completer, recurringExpenseId: recurringExpense.id));
      return completer.future;
    }

    return RecurringExpenseViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: recurringExpense.isNew,
      recurringExpense: recurringExpense,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([recurringExpense], action, autoPop: true),
    );
  }

  final AppState state;
  final ExpenseEntity recurringExpense;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
