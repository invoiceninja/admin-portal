import 'dart:async';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/bank_account/bank_account_list_item.dart';
import 'package:invoiceninja_flutter/ui/bank_account/bank_account_presenter.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';

class BankAccountListBuilder extends StatelessWidget {
  const BankAccountListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BankAccountListVM>(
      converter: BankAccountListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.bankAccount,
            presenter: BankAccountPresenter(),
            state: viewModel.state,
            entityList: viewModel.bankAccountList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final bankAccountId = viewModel.bankAccountList[index];
              final bankAccount = viewModel.bankAccountMap[bankAccountId]!;
              final listState = state.getListState(EntityType.bankAccount);
              final isInMultiselect = listState.isInMultiselect();

              return BankAccountListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                bankAccount: bankAccount,
                isChecked:
                    isInMultiselect && listState.isSelected(bankAccount.id),
              );
            });
      },
    );
  }
}

class BankAccountListVM {
  BankAccountListVM({
    required this.state,
    required this.userCompany,
    required this.bankAccountList,
    required this.bankAccountMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static BankAccountListVM fromStore(Store<AppState> store) {
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

    return BankAccountListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.bankAccountListState,
      bankAccountList: memoizedFilteredBankAccountList(
          state.getUISelection(EntityType.bankAccount),
          state.bankAccountState.map,
          state.bankAccountState.list,
          state.bankAccountListState),
      bankAccountMap: state.bankAccountState.map,
      isLoading: state.isLoading,
      filter: state.bankAccountUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> bankAccounts,
              EntityAction action) =>
          handleBankAccountAction(context, bankAccounts, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.bankAccount) ??
              BankAccountPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortBankAccounts(field)),
      onClearMultielsect: () => store.dispatch(ClearBankAccountMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> bankAccountList;
  final BuiltMap<String, BankAccountEntity> bankAccountMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
