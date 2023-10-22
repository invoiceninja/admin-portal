import 'dart:async';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/transaction_rule_list_item.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/transaction_rule_presenter.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';

class TransactionRuleListBuilder extends StatelessWidget {
  const TransactionRuleListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionRuleListVM>(
      converter: TransactionRuleListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.transactionRule,
            presenter: TransactionRulePresenter(),
            state: viewModel.state,
            entityList: viewModel.transactionRuleList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final transactionRuleId = viewModel.transactionRuleList[index];
              final transactionRule =
                  viewModel.transactionRuleMap[transactionRuleId]!;
              final listState = state.getListState(EntityType.transactionRule);
              final isInMultiselect = listState.isInMultiselect();

              return TransactionRuleListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                transactionRule: transactionRule,
                isChecked:
                    isInMultiselect && listState.isSelected(transactionRule.id),
              );
            });
      },
    );
  }
}

class TransactionRuleListVM {
  TransactionRuleListVM({
    required this.state,
    required this.userCompany,
    required this.transactionRuleList,
    required this.transactionRuleMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static TransactionRuleListVM fromStore(Store<AppState> store) {
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

    return TransactionRuleListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.transactionRuleListState,
      transactionRuleList: memoizedFilteredTransactionRuleList(
          state.getUISelection(EntityType.transactionRule),
          state.transactionRuleState.map,
          state.transactionRuleState.list,
          state.transactionRuleListState),
      transactionRuleMap: state.transactionRuleState.map,
      isLoading: state.isLoading,
      filter: state.transactionRuleUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> transactionRules,
              EntityAction action) =>
          handleTransactionRuleAction(context, transactionRules, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns: state.userCompany.settings
              .getTableColumns(EntityType.transactionRule) ??
          TransactionRulePresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortTransactionRules(field)),
      onClearMultielsect: () =>
          store.dispatch(ClearTransactionRuleMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> transactionRuleList;
  final BuiltMap<String?, TransactionRuleEntity?> transactionRuleMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
