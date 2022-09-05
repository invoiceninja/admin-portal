// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/bank_accounts.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class BankAccountsScreen extends StatelessWidget {
  const BankAccountsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsBankAccounts';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BankAccountsVM>(
      converter: BankAccountsVM.fromStore,
      builder: (context, viewModel) {
        return BankAccounts(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class BankAccountsVM {
  BankAccountsVM({
    @required this.state,
    @required this.company,
    @required this.onCompanyChanged,
    @required this.onSavePressed,
  });

  static BankAccountsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return BankAccountsVM(
        state: state,
        company: state.uiState.settingsUIState.company,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onSavePressed: (context) {
          Debouncer.runOnComplete(() {
            final settingsUIState = store.state.uiState.settingsUIState;
            final completer = snackBarCompleter<Null>(
                context, AppLocalization.of(context).savedSettings);
            store.dispatch(SaveCompanyRequest(
                completer: completer, company: settingsUIState.company));
          });
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final CompanyEntity company;
  final Function(CompanyEntity) onCompanyChanged;
}
