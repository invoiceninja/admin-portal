import 'dart:async';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/transaction/view/transaction_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TransactionViewScreen extends StatelessWidget {
  const TransactionViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  static const String route = '/transaction/view';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionViewVM>(
      converter: (Store<AppState> store) {
        return TransactionViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return TransactionView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class TransactionViewVM {
  TransactionViewVM({
    @required this.state,
    @required this.transaction,
    @required this.company,
    @required this.onEntityAction,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onConvertToPayment,
    @required this.onConvertToExpense,
  });

  factory TransactionViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final transaction =
        state.transactionState.map[state.transactionUIState.selectedId] ??
            TransactionEntity(id: state.transactionUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(
          LoadTransaction(completer: completer, transactionId: transaction.id));
      return completer.future;
    }

    return TransactionViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: transaction.isNew,
      transaction: transaction,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([transaction], action, autoPop: true),
      onConvertToPayment: (context, transactionId, invoiceIds) {
        store.dispatch(
          ConvertTransactionToPaymentRequest(
              snackBarCompleter<Null>(
                  context, AppLocalization.of(context).convertedTransaction),
              transactionId,
              invoiceIds),
        );
      },
      onConvertToExpense: (context, transactionId, vendorId, categoryId) {
        store.dispatch(
          ConvertTransactionToExpenseRequest(
            snackBarCompleter<Null>(
                context, AppLocalization.of(context).convertedTransaction),
            transactionId,
            vendorId,
            categoryId,
          ),
        );
      },
    );
  }

  final AppState state;
  final TransactionEntity transaction;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, String, List<String>) onConvertToPayment;
  final Function(BuildContext, String, String, String) onConvertToExpense;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
