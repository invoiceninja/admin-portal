// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_selectors.dart';
import 'recurring_expense_screen.dart';

class RecurringExpenseScreenBuilder extends StatelessWidget {
  const RecurringExpenseScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringExpenseScreenVM>(
      converter: RecurringExpenseScreenVM.fromStore,
      builder: (context, vm) {
        return RecurringExpenseScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class RecurringExpenseScreenVM {
  RecurringExpenseScreenVM({
    required this.isInMultiselect,
    required this.recurringExpenseList,
    required this.userCompany,
    required this.onEntityAction,
    required this.recurringExpenseMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String?> recurringExpenseList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, ExpenseEntity> recurringExpenseMap;

  static RecurringExpenseScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return RecurringExpenseScreenVM(
      recurringExpenseMap: state.recurringExpenseState.map,
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
      userCompany: state.userCompany,
      isInMultiselect: state.recurringExpenseListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> recurringExpenses,
              EntityAction action) =>
          handleRecurringExpenseAction(context, recurringExpenses, action),
    );
  }
}
