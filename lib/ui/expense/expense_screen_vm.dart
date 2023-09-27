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
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'expense_screen.dart';

class ExpenseScreenBuilder extends StatelessWidget {
  const ExpenseScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseScreenVM>(
      converter: ExpenseScreenVM.fromStore,
      builder: (context, vm) {
        return ExpenseScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ExpenseScreenVM {
  ExpenseScreenVM({
    required this.isInMultiselect,
    required this.expenseList,
    required this.userCompany,
    required this.expenseMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String?> expenseList;
  final BuiltMap<String, ExpenseEntity> expenseMap;

  static ExpenseScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ExpenseScreenVM(
      expenseMap: state.expenseState.map,
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
      userCompany: state.userCompany,
      isInMultiselect: state.expenseListState.isInMultiselect(),
    );
  }
}
