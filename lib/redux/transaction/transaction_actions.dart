import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';

class ViewTransactionList implements PersistUI {
  ViewTransactionList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewTransaction implements PersistUI, PersistPrefs {
  ViewTransaction({
    required this.transactionId,
    this.force = false,
  });

  final String? transactionId;
  final bool force;
}

class EditTransaction implements PersistUI, PersistPrefs {
  EditTransaction(
      {required this.transaction,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final TransactionEntity transaction;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateTransaction implements PersistUI {
  UpdateTransaction(this.transaction);

  final TransactionEntity transaction;
}

class LoadTransaction {
  LoadTransaction({this.completer, this.transactionId});

  final Completer? completer;
  final String? transactionId;
}

class LoadTransactionActivity {
  LoadTransactionActivity({this.completer, this.transactionId});

  final Completer? completer;
  final String? transactionId;
}

class LoadTransactions {
  LoadTransactions({this.completer, this.page = 1});

  final Completer? completer;
  final int page;
}

class LoadTransactionRequest implements StartLoading {}

class LoadTransactionFailure implements StopLoading {
  LoadTransactionFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTransactionFailure{error: $error}';
  }
}

class LoadTransactionSuccess implements StopLoading, PersistData {
  LoadTransactionSuccess(this.transaction);

  final TransactionEntity transaction;

  @override
  String toString() {
    return 'LoadTransactionSuccess{transaction: $transaction}';
  }
}

class LoadTransactionsRequest implements StartLoading {}

class LoadTransactionsFailure implements StopLoading {
  LoadTransactionsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTransactionsFailure{error: $error}';
  }
}

class LoadTransactionsSuccess implements StopLoading {
  LoadTransactionsSuccess(this.transactions);

  final BuiltList<TransactionEntity> transactions;

  @override
  String toString() {
    return 'LoadTransactionsSuccess{transactions: $transactions}';
  }
}

class SaveTransactionRequest implements StartSaving {
  SaveTransactionRequest({this.completer, this.transaction});

  final Completer? completer;
  final TransactionEntity? transaction;
}

class SaveTransactionSuccess implements StopSaving, PersistData, PersistUI {
  SaveTransactionSuccess(this.transaction);

  final TransactionEntity transaction;
}

class AddTransactionSuccess implements StopSaving, PersistData, PersistUI {
  AddTransactionSuccess(this.transaction);

  final TransactionEntity transaction;
}

class SaveTransactionFailure implements StopSaving {
  SaveTransactionFailure(this.error);

  final Object error;
}

class ArchiveTransactionsRequest implements StartSaving {
  ArchiveTransactionsRequest(this.completer, this.transactionIds);

  final Completer completer;
  final List<String> transactionIds;
}

class ArchiveTransactionsSuccess implements StopSaving, PersistData {
  ArchiveTransactionsSuccess(this.transactions);

  final List<TransactionEntity> transactions;
}

class ArchiveTransactionsFailure implements StopSaving {
  ArchiveTransactionsFailure(this.transactions);

  final List<TransactionEntity?> transactions;
}

class DeleteTransactionsRequest implements StartSaving {
  DeleteTransactionsRequest(this.completer, this.transactionIds);

  final Completer completer;
  final List<String> transactionIds;
}

class DeleteTransactionsSuccess implements StopSaving, PersistData {
  DeleteTransactionsSuccess(this.transactions);

  final List<TransactionEntity> transactions;
}

class DeleteTransactionsFailure implements StopSaving {
  DeleteTransactionsFailure(this.transactions);

  final List<TransactionEntity?> transactions;
}

class RestoreTransactionsRequest implements StartSaving {
  RestoreTransactionsRequest(this.completer, this.transactionIds);

  final Completer completer;
  final List<String> transactionIds;
}

class RestoreTransactionsSuccess implements StopSaving, PersistData {
  RestoreTransactionsSuccess(this.transactions);

  final List<TransactionEntity> transactions;
}

class RestoreTransactionsFailure implements StopSaving {
  RestoreTransactionsFailure(this.transactions);

  final List<TransactionEntity?> transactions;
}

class ConvertTransactionToPaymentRequest implements StartSaving {
  ConvertTransactionToPaymentRequest(
    this.completer,
    this.transactionId,
    this.invoiceIds,
  );

  final Completer completer;
  final String? transactionId;
  final List<String> invoiceIds;
}

class ConvertTransactionToPaymentSuccess implements StopSaving, PersistData {
  ConvertTransactionToPaymentSuccess(this.transaction);

  final TransactionEntity transaction;
}

class ConvertTransactionToPaymentFailure implements StopSaving {
  ConvertTransactionToPaymentFailure(this.error);

  final dynamic error;
}

class LinkTransactionToPaymentRequest implements StartSaving {
  LinkTransactionToPaymentRequest(
    this.completer,
    this.transactionId,
    this.paymentId,
  );

  final Completer completer;
  final String? transactionId;
  final String paymentId;
}

class LinkTransactionToPaymentSuccess implements StopSaving, PersistData {
  LinkTransactionToPaymentSuccess(this.transaction);

  final TransactionEntity transaction;
}

class LinkTransactionToPaymentFailure implements StopSaving {
  LinkTransactionToPaymentFailure(this.error);

  final dynamic error;
}

class UnlinkTransactionsRequest implements StartSaving {
  UnlinkTransactionsRequest(
    this.completer,
    this.transactionIds,
  );

  final Completer completer;
  final List<String> transactionIds;
}

class UnlinkTransactionsSuccess implements StopSaving, PersistData {
  UnlinkTransactionsSuccess(this.transactions);

  final BuiltList<TransactionEntity> transactions;
}

class UnlinkTransactionsFailure implements StopSaving {
  UnlinkTransactionsFailure(this.error);

  final dynamic error;
}

class LinkTransactionToExpenseRequest implements StartSaving {
  LinkTransactionToExpenseRequest(
    this.completer,
    this.transactionId,
    this.expenseId,
  );

  final Completer completer;
  final String? transactionId;
  final String expenseId;
}

class LinkTransactionToExpenseSuccess implements StopSaving, PersistData {
  LinkTransactionToExpenseSuccess(this.transaction);

  final TransactionEntity transaction;
}

class LinkTransactionToExpenseFailure implements StopSaving {
  LinkTransactionToExpenseFailure(this.error);

  final dynamic error;
}

class ConvertTransactionsToExpensesRequest implements StartSaving {
  ConvertTransactionsToExpensesRequest(
    this.completer,
    this.transactionIds,
    this.vendorId,
    this.categoryId,
  );

  final Completer completer;
  final List<String> transactionIds;
  final String vendorId;
  final String categoryId;
}

class ConvertTransactionsToExpensesSuccess implements StopSaving, PersistData {
  ConvertTransactionsToExpensesSuccess(this.transactions);

  final BuiltList<TransactionEntity> transactions;
}

class ConvertTransactionsToExpensesFailure implements StopSaving {
  ConvertTransactionsToExpensesFailure(this.error);

  final dynamic error;
}

class ConvertTransactionsRequest implements StartSaving {
  ConvertTransactionsRequest(this.completer, this.transactionIds);

  final Completer completer;
  final List<String> transactionIds;
}

class ConvertTransactionsSuccess implements StopSaving, PersistData {
  ConvertTransactionsSuccess(this.transactions);

  final BuiltList<TransactionEntity> transactions;
}

class ConvertTransactionsFailure implements StopSaving {
  ConvertTransactionsFailure(this.error);

  final dynamic error;
}

class FilterTransactions implements PersistUI {
  FilterTransactions(this.filter);

  final String? filter;
}

class SortTransactions implements PersistUI, PersistPrefs {
  SortTransactions(this.field);

  final String field;
}

class FilterTransactionsByState implements PersistUI {
  FilterTransactionsByState(this.state);

  final EntityState state;
}

class FilterTransactionsByStatus implements PersistUI {
  FilterTransactionsByStatus(this.status);

  final TransactionStatusEntity status;
}

class FilterTransactionsByCustom1 implements PersistUI {
  FilterTransactionsByCustom1(this.value);

  final String value;
}

class FilterTransactionsByCustom2 implements PersistUI {
  FilterTransactionsByCustom2(this.value);

  final String value;
}

class FilterTransactionsByCustom3 implements PersistUI {
  FilterTransactionsByCustom3(this.value);

  final String value;
}

class FilterTransactionsByCustom4 implements PersistUI {
  FilterTransactionsByCustom4(this.value);

  final String value;
}

class StartTransactionMultiselect {
  StartTransactionMultiselect();
}

class AddToTransactionMultiselect {
  AddToTransactionMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromTransactionMultiselect {
  RemoveFromTransactionMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearTransactionMultiselect {
  ClearTransactionMultiselect();
}

class UpdateTransactionTab implements PersistUI {
  UpdateTransactionTab({this.tabIndex});

  final int? tabIndex;
}

void handleTransactionAction(BuildContext? context,
    List<BaseEntity> transactions, EntityAction? action) {
  if (transactions.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final localization = AppLocalization.of(context);
  final transaction = transactions.first as TransactionEntity;
  final transactionIds =
      transactions.map((transaction) => transaction.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: transaction);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreTransactionsRequest(
          snackBarCompleter<Null>(localization!.restoredTransaction),
          transactionIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveTransactionsRequest(
          snackBarCompleter<Null>(localization!.archivedTransaction),
          transactionIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteTransactionsRequest(
          snackBarCompleter<Null>(localization!.deletedTransaction),
          transactionIds));
      break;
    case EntityAction.convertMatched:
      store.dispatch(ConvertTransactionsRequest(
          snackBarCompleter<Null>(localization!.convertedTransactions),
          transactionIds));
      break;
    case EntityAction.unlink:
      store.dispatch(UnlinkTransactionsRequest(
          snackBarCompleter<Null>(transactionIds.length == 1
              ? localization!.unlinkedTransaction
              : localization!.unlinkedTransactions
                  .replaceFirst(':count', '${transactionIds.length}')),
          transactionIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.transactionListState.isInMultiselect()) {
        store.dispatch(StartTransactionMultiselect());
      }

      if (transactions.isEmpty) {
        break;
      }

      for (final transaction in transactions) {
        if (!store.state.transactionListState.isSelected(transaction.id)) {
          store.dispatch(AddToTransactionMultiselect(entity: transaction));
        } else {
          store.dispatch(RemoveFromTransactionMultiselect(entity: transaction));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [transaction],
      );
      break;
    default:
      print('## ERROR: unhandled action $action in transaction_actions');
      break;
  }
}
