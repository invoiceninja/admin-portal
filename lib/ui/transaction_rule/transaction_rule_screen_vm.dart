import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_selectors.dart';
import 'package:redux/redux.dart';

import 'transaction_rule_screen.dart';

class TransactionRuleScreenBuilder extends StatelessWidget {
  const TransactionRuleScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionRuleScreenVM>(
      converter: TransactionRuleScreenVM.fromStore,
      builder: (context, vm) {
        return TransactionRuleScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class TransactionRuleScreenVM {
  TransactionRuleScreenVM({
    required this.isInMultiselect,
    required this.transactionRuleList,
    required this.userCompany,
    required this.onEntityAction,
    required this.transactionRuleMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> transactionRuleList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String?, TransactionRuleEntity?> transactionRuleMap;

  static TransactionRuleScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TransactionRuleScreenVM(
      transactionRuleMap: state.transactionRuleState.map,
      transactionRuleList: memoizedFilteredTransactionRuleList(
        state.getUISelection(EntityType.transactionRule),
        state.transactionRuleState.map,
        state.transactionRuleState.list,
        state.transactionRuleListState,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.transactionRuleListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> transactionRules,
              EntityAction action) =>
          handleTransactionRuleAction(context, transactionRules, action),
    );
  }
}
