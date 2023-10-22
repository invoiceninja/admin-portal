import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_selectors.dart';
import 'package:redux/redux.dart';

import 'transaction_screen.dart';

class TransactionScreenBuilder extends StatelessWidget {
  const TransactionScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionScreenVM>(
      converter: TransactionScreenVM.fromStore,
      builder: (context, vm) {
        return TransactionScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class TransactionScreenVM {
  TransactionScreenVM({
    required this.isInMultiselect,
    required this.transactionList,
    required this.userCompany,
    required this.onEntityAction,
    required this.transactionMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> transactionList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, TransactionEntity> transactionMap;

  static TransactionScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TransactionScreenVM(
      transactionMap: state.transactionState.map,
      transactionList: memoizedFilteredTransactionList(
        state.getUISelection(EntityType.transaction),
        state.transactionState.map,
        state.transactionState.list,
        state.invoiceState.map,
        state.vendorState.map,
        state.expenseState.map,
        state.expenseCategoryState.map,
        state.bankAccountState.map,
        state.transactionListState,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.transactionListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> transactions,
              EntityAction action) =>
          handleTransactionAction(context, transactions, action),
    );
  }
}
