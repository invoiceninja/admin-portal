import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/view/transaction_rule_view_vm.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/edit/transaction_rule_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TransactionRuleEditScreen extends StatelessWidget {
  const TransactionRuleEditScreen({Key? key}) : super(key: key);

  static const String route = '/$kSettings/$kSettingsTransactionRulesEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionRuleEditVM>(
      converter: (Store<AppState> store) {
        return TransactionRuleEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return TransactionRuleEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.transactionRule.updatedAt),
        );
      },
    );
  }
}

class TransactionRuleEditVM {
  TransactionRuleEditVM({
    required this.state,
    required this.transactionRule,
    required this.company,
    required this.onChanged,
    required this.isSaving,
    required this.origTransactionRule,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
  });

  factory TransactionRuleEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final transactionRule = state.transactionRuleUIState.editing!;

    return TransactionRuleEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origTransactionRule: state.transactionRuleState.map[transactionRule.id],
      transactionRule: transactionRule,
      company: state.company,
      onChanged: (TransactionRuleEntity transactionRule) {
        store.dispatch(UpdateTransactionRule(transactionRule));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(entity: TransactionRuleEntity(), force: true);
        if (state.transactionRuleUIState.cancelCompleter != null) {
          state.transactionRuleUIState.cancelCompleter!.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final transactionRule = store.state.transactionRuleUIState.editing;
          final localization = AppLocalization.of(context);
          final Completer<TransactionRuleEntity> completer =
              new Completer<TransactionRuleEntity>();
          store.dispatch(SaveTransactionRuleRequest(
              completer: completer, transactionRule: transactionRule));
          return completer.future.then((savedTransactionRule) {
            showToast(transactionRule!.isNew
                ? localization!.createdTransactionRule
                : localization!.updatedTransactionRule);
            if (state.prefState.isMobile) {
              store.dispatch(
                  UpdateCurrentRoute(TransactionRuleViewScreen.route));
              if (transactionRule.isNew) {
                Navigator.of(context)
                    .pushReplacementNamed(TransactionRuleViewScreen.route);
              } else {
                Navigator.of(context).pop(savedTransactionRule);
              }
            } else {
              viewEntity(entity: savedTransactionRule, force: true);
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
    );
  }

  final TransactionRuleEntity transactionRule;
  final CompanyEntity? company;
  final Function(TransactionRuleEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final TransactionRuleEntity? origTransactionRule;
  final AppState state;
}
