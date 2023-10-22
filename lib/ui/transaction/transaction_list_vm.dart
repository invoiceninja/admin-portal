import 'dart:async';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/transaction/transaction_list_item.dart';
import 'package:invoiceninja_flutter/ui/transaction/transaction_presenter.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';

class TransactionListBuilder extends StatelessWidget {
  const TransactionListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionListVM>(
      converter: TransactionListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.transaction,
            presenter: TransactionPresenter(),
            state: viewModel.state,
            entityList: viewModel.transactionList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final transactionId = viewModel.transactionList[index];
              final transaction = viewModel.transactionMap[transactionId]!;
              final listState = state.getListState(EntityType.transaction);
              final isInMultiselect = listState.isInMultiselect();

              return TransactionListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                transaction: transaction,
                isChecked:
                    isInMultiselect && listState.isSelected(transaction.id),
              );
            });
      },
    );
  }
}

class TransactionListVM {
  TransactionListVM({
    required this.state,
    required this.userCompany,
    required this.transactionList,
    required this.transactionMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static TransactionListVM fromStore(Store<AppState> store) {
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

    return TransactionListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.transactionListState,
      transactionList: memoizedFilteredTransactionList(
          state.getUISelection(EntityType.transaction),
          state.transactionState.map,
          state.transactionState.list,
          state.invoiceState.map,
          state.vendorState.map,
          state.expenseState.map,
          state.expenseCategoryState.map,
          state.bankAccountState.map,
          state.transactionListState),
      transactionMap: state.transactionState.map,
      isLoading: state.isLoading,
      filter: state.transactionUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> transactions,
              EntityAction action) =>
          handleTransactionAction(context, transactions, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.transaction) ??
              TransactionPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortTransactions(field)),
      onClearMultielsect: () => store.dispatch(ClearTransactionMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> transactionList;
  final BuiltMap<String, TransactionEntity> transactionMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
