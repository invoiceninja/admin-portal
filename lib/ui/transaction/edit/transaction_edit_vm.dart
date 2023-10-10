import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/transaction/view/transaction_view_vm.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/ui/transaction/edit/transaction_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TransactionEditScreen extends StatelessWidget {
  const TransactionEditScreen({Key? key}) : super(key: key);
  static const String route = '/transaction/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionEditVM>(
      converter: (Store<AppState> store) {
        return TransactionEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return TransactionEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.transaction.updatedAt),
        );
      },
    );
  }
}

class TransactionEditVM {
  TransactionEditVM({
    required this.state,
    required this.transaction,
    required this.company,
    required this.onChanged,
    required this.isSaving,
    required this.origTransaction,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
    required this.onAddBankAccountPressed,
  });

  factory TransactionEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final transaction = state.transactionUIState.editing!;

    return TransactionEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origTransaction: state.transactionState.map[transaction.id],
      transaction: transaction,
      company: state.company,
      onChanged: (TransactionEntity transaction) {
        store.dispatch(UpdateTransaction(transaction));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(entity: TransactionEntity(), force: true);
        if (state.transactionUIState.cancelCompleter != null) {
          state.transactionUIState.cancelCompleter!.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final transaction = store.state.transactionUIState.editing;
          final localization = AppLocalization.of(context);
          final Completer<TransactionEntity> completer =
              new Completer<TransactionEntity>();
          store.dispatch(SaveTransactionRequest(
              completer: completer, transaction: transaction));
          return completer.future.then((savedTransaction) {
            showToast(transaction!.isNew
                ? localization!.createdTransaction
                : localization!.updatedTransaction);
            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(TransactionViewScreen.route));
              if (transaction.isNew) {
                Navigator.of(context)
                    .pushReplacementNamed(TransactionViewScreen.route);
              } else {
                Navigator.of(context).pop(savedTransaction);
              }
            } else {
              viewEntity(entity: savedTransaction, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
      onAddBankAccountPressed: (context, completer) {
        createEntity(
            entity: BankAccountEntity(state: state),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then<Null>((_) {
                store.dispatch(UpdateCurrentRoute(TransactionEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(TransactionEditScreen.route));
        });
      },
    );
  }

  final TransactionEntity transaction;
  final CompanyEntity? company;
  final Function(TransactionEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final TransactionEntity? origTransaction;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddBankAccountPressed;
}
