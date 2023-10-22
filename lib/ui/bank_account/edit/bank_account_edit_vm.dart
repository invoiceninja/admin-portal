// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/bank_account/edit/bank_account_edit.dart';
import 'package:invoiceninja_flutter/ui/bank_account/view/bank_account_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class BankAccountEditScreen extends StatelessWidget {
  const BankAccountEditScreen({Key? key}) : super(key: key);

  static const String route = '/$kSettings/$kSettingsBankAccountsEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BankAccountEditVM>(
      converter: (Store<AppState> store) {
        return BankAccountEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return BankAccountEdit(
          viewModel: vm,
          key: ValueKey(vm.bankAccount.id),
        );
      },
    );
  }
}

class BankAccountEditVM {
  BankAccountEditVM({
    required this.state,
    required this.company,
    required this.bankAccount,
    required this.origBankAccount,
    required this.onChanged,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.onEntityAction,
    required this.isSaving,
    required this.isDirty,
  });

  factory BankAccountEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final bankAccount = state.bankAccountUIState.editing!;

    return BankAccountEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: bankAccount.isNew,
      bankAccount: bankAccount,
      origBankAccount: state.bankAccountState.map[bankAccount.id],
      onChanged: (BankAccountEntity bankAccount) {
        store.dispatch(UpdateBankAccount(bankAccount));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(entity: BankAccountEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final bankAccount = store.state.bankAccountUIState.editing;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          final Completer<BankAccountEntity> completer =
              new Completer<BankAccountEntity>();
          store.dispatch(SaveBankAccountRequest(
              completer: completer, bankAccount: bankAccount));
          return completer.future.then((savedBankAccount) {
            showToast(bankAccount!.isNew
                ? localization!.createdBankAccount
                : localization!.updatedBankAccount);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(BankAccountViewScreen.route));
              if (bankAccount.isNew) {
                navigator!.pushReplacementNamed(BankAccountViewScreen.route);
              } else {
                navigator!.pop(savedBankAccount);
              }
            } else {
              viewEntity(entity: savedBankAccount);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
      onEntityAction: (BuildContext context, EntityAction action) {
        // TODO Add view page for bankAccounts
        // Prevent duplicate global key error
        if (action == EntityAction.clone) {
          Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((duration) {
            handleBankAccountAction(context, [bankAccount], action);
          });
        } else {
          handleBankAccountAction(context, [bankAccount], action);
        }
      },
    );
  }

  final AppState state;
  final CompanyEntity? company;
  final BankAccountEntity bankAccount;
  final BankAccountEntity? origBankAccount;
  final Function(BankAccountEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function(BuildContext, EntityAction) onEntityAction;
  final bool isSaving;
  final bool isDirty;
}
