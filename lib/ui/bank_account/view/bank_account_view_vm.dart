import 'dart:async';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/bank_account/bank_account_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/bank_account/view/bank_account_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class BankAccountViewScreen extends StatelessWidget {
  const BankAccountViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsBankAccountsView';

  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BankAccountViewVM>(
      converter: (Store<AppState> store) {
        return BankAccountViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return BankAccountView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class BankAccountViewVM {
  BankAccountViewVM({
    required this.state,
    required this.bankAccount,
    required this.company,
    required this.onEntityAction,
    required this.onRefreshed,
    required this.onBackPressed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
  });

  factory BankAccountViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final bankAccount =
        state.bankAccountState.map[state.bankAccountUIState.selectedId] ??
            BankAccountEntity(id: state.bankAccountUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(
          LoadBankAccount(completer: completer, bankAccountId: bankAccount.id));
      return completer.future;
    }

    return BankAccountViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: bankAccount.isNew,
      bankAccount: bankAccount,
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(BankAccountScreen.route));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([bankAccount], action, autoPop: true),
    );
  }

  final AppState state;
  final BankAccountEntity bankAccount;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
