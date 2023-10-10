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
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_list_item.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseCategoryListBuilder extends StatelessWidget {
  const ExpenseCategoryListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseCategoryListVM>(
      converter: ExpenseCategoryListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.expenseCategory,
            presenter: ExpenseCategoryPresenter(),
            state: viewModel.state,
            entityList: viewModel.expenseCategoryList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final expenseCategoryId = viewModel.expenseCategoryList[index];
              final expenseCategory =
                  viewModel.expenseCategoryMap[expenseCategoryId]!;
              final listState = state.getListState(EntityType.expenseCategory);
              final isInMultiselect = listState.isInMultiselect();

              return ExpenseCategoryListItem(
                filter: viewModel.filter,
                expenseCategory: expenseCategory,
                isChecked:
                    isInMultiselect && listState.isSelected(expenseCategory.id),
              );
            });
      },
    );
  }
}

class ExpenseCategoryListVM {
  ExpenseCategoryListVM({
    required this.state,
    required this.userCompany,
    required this.expenseCategoryList,
    required this.expenseCategoryMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static ExpenseCategoryListVM fromStore(Store<AppState> store) {
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

    return ExpenseCategoryListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.expenseCategoryListState,
      expenseCategoryList: memoizedFilteredExpenseCategoryList(
          state.getUISelection(EntityType.expenseCategory),
          state.expenseCategoryState.map,
          state.expenseCategoryState.list,
          state.expenseCategoryListState),
      expenseCategoryMap: state.expenseCategoryState.map,
      isLoading: state.isLoading,
      filter: state.expenseCategoryUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> expenseCategories,
              EntityAction action) =>
          handleExpenseCategoryAction(context, expenseCategories, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns: state.userCompany.settings
              .getTableColumns(EntityType.expenseCategory) ??
          ExpenseCategoryPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortExpenseCategories(field)),
      onClearMultielsect: () =>
          store.dispatch(ClearExpenseCategoryMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> expenseCategoryList;
  final BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
