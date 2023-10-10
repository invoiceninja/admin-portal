import 'dart:async';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/transaction_rule_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/view/transaction_rule_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TransactionRuleViewScreen extends StatelessWidget {
  const TransactionRuleViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsTransactionRulesView';

  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionRuleViewVM>(
      converter: (Store<AppState> store) {
        return TransactionRuleViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return TransactionRuleView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class TransactionRuleViewVM {
  TransactionRuleViewVM({
    required this.state,
    required this.transactionRule,
    required this.company,
    required this.onEntityAction,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
    required this.onBackPressed,
  });

  factory TransactionRuleViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final transactionRule = state.transactionRuleState
            .map[state.transactionRuleUIState.selectedId] ??
        TransactionRuleEntity(id: state.transactionRuleUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadTransactionRule(
          completer: completer, transactionRuleId: transactionRule.id));
      return completer.future;
    }

    return TransactionRuleViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: transactionRule.isNew,
      transactionRule: transactionRule,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(TransactionRuleScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([transactionRule], action, autoPop: true),
    );
  }

  final AppState state;
  final TransactionRuleEntity transactionRule;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
