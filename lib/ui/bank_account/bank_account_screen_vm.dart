import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_selectors.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'bank_account_screen.dart';

class BankAccountScreenBuilder extends StatelessWidget {
  const BankAccountScreenBuilder({Key? key}) : super(key: key);

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
    required this.isInMultiselect,
    required this.bankAccountList,
    required this.userCompany,
    required this.onEntityAction,
    required this.bankAccountMap,
    required this.onRefreshAccounts,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> bankAccountList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, BankAccountEntity> bankAccountMap;
  final Function(BuildContext) onRefreshAccounts;

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
      onRefreshAccounts: (context) {
        final webClient = WebClient();
        final credentials = state.credentials;
        final url = '${credentials.url}/bank_integrations/refresh_accounts';
        final localization = AppLocalization.of(context);

        store.dispatch(StartSaving());

        webClient.post(url, credentials.token).then((dynamic response) {
          store.dispatch(StopSaving());
          store.dispatch(RefreshData());
          showToast(localization!.refreshComplete);
        }).catchError((dynamic error) {
          store.dispatch(StopSaving());
          showErrorDialog(message: '$error');
        });
      },
    );
  }
}
