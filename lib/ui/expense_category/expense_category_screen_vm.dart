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
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_selectors.dart';
import 'expense_category_screen.dart';

class ExpenseCategoryScreenBuilder extends StatelessWidget {
  const ExpenseCategoryScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseCategoryScreenVM>(
      converter: ExpenseCategoryScreenVM.fromStore,
      builder: (context, vm) {
        return ExpenseCategoryScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ExpenseCategoryScreenVM {
  ExpenseCategoryScreenVM({
    required this.isInMultiselect,
    required this.expenseCategoryList,
    required this.userCompany,
    required this.onEntityAction,
    required this.expenseCategoryMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> expenseCategoryList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap;

  static ExpenseCategoryScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ExpenseCategoryScreenVM(
      expenseCategoryMap: state.expenseCategoryState.map,
      expenseCategoryList: memoizedFilteredExpenseCategoryList(
          state.getUISelection(EntityType.expenseCategory),
          state.expenseCategoryState.map,
          state.expenseCategoryState.list,
          state.expenseCategoryListState),
      userCompany: state.userCompany,
      isInMultiselect: state.expenseCategoryListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> expenseCategories,
              EntityAction action) =>
          handleExpenseCategoryAction(context, expenseCategories, action),
    );
  }
}
