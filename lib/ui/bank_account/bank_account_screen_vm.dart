import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_selectors.dart';
import 'package:redux/redux.dart';

import 'bank_account_screen.dart';

class BankAccountScreenBuilder extends StatelessWidget {
  const BankAccountScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BankAccountScreenVM>(
      converter: BankAccountScreenVM.fromStore,
      builder: (context, vm) {
        return BankAccountScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class BankAccountScreenVM {
  BankAccountScreenVM({
    @required this.isInMultiselect,
    @required this.bankAccountList,
    @required this.userCompany,
    @required this.onEntityAction,
    @required this.bankAccountMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity userCompany;
  final List<String> bankAccountList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, BankAccountEntity> bankAccountMap;

  static BankAccountScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return BankAccountScreenVM(
      bankAccountMap: state.bankAccountState.map,
      bankAccountList: memoizedFilteredBankAccountList(
        state.getUISelection(EntityType.bankAccount),
        state.bankAccountState.map,
        state.bankAccountState.list,
        state.bankAccountListState,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.bankAccountListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> bankAccounts,
              EntityAction action) =>
          handleBankAccountAction(context, bankAccounts, action),
    );
  }
}
