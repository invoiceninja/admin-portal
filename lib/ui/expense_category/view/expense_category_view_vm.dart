// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_screen.dart';
import 'package:invoiceninja_flutter/ui/expense_category/view/expense_category_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseCategoryViewScreen extends StatelessWidget {
  const ExpenseCategoryViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsExpenseCategoryView';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseCategoryViewVM>(
      converter: (Store<AppState> store) {
        return ExpenseCategoryViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ExpenseCategoryView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class ExpenseCategoryViewVM {
  ExpenseCategoryViewVM({
    required this.state,
    required this.expenseCategory,
    required this.company,
    required this.onEntityAction,
    required this.onBackPressed,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
  });

  factory ExpenseCategoryViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final expenseCategory = state.expenseCategoryState
            .map[state.expenseCategoryUIState.selectedId] ??
        ExpenseCategoryEntity(id: state.expenseCategoryUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadExpenseCategory(
          completer: completer, expenseCategoryId: expenseCategory.id));
      return completer.future;
    }

    return ExpenseCategoryViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: expenseCategory.isNew,
      expenseCategory: expenseCategory,
      onBackPressed: () =>
          store.dispatch(UpdateCurrentRoute(ExpenseCategoryScreen.route)),
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([expenseCategory], action, autoPop: true),
    );
  }

  final AppState state;
  final ExpenseCategoryEntity expenseCategory;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
