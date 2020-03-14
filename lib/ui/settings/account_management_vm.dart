import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsAccountManagement';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AccountManagementVM>(
      converter: AccountManagementVM.fromStore,
      builder: (context, viewModel) {
        return AccountManagement(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class AccountManagementVM {
  AccountManagementVM({
    @required this.state,
    @required this.company,
    @required this.onCompanyChanged,
    @required this.onSavePressed,
    @required this.onCompanyDelete,
  });

  static AccountManagementVM fromStore(Store<AppState> store) {
    final state = store.state;

    return AccountManagementVM(
        state: state,
        company: state.uiState.settingsUIState.company,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onCompanyDelete: (context, password) {
          final selectedCompanyIndex = state.uiState.selectedCompanyIndex;
          final completer = Completer<Null>()
            ..future.then((value) {
              final companies = state.companies;
              if (companies.length > 1) {
                int index;
                for (int i = 0; i < 10; i++) {
                  index = i;
                  if (index != selectedCompanyIndex) {
                    break;
                  }
                }
                store.dispatch(SelectCompany(index));
                store.dispatch(ViewDashboard(navigator: Navigator.of(context)));

                final completer = snackBarCompleter<Null>(
                    context, AppLocalization.of(context).refreshComplete);
                store.dispatch(RefreshData(
                  completer: completer,
                  loadCompanies: false,
                ));
              } else {
                store.dispatch(UserLogout(context));
              }
            });
          store.dispatch(
              DeleteCompanyRequest(completer: completer, password: password));
        },
        onSavePressed: (context) {
          final settingsUIState = state.uiState.settingsUIState;
          final completer = snackBarCompleter<Null>(
              context, AppLocalization.of(context).savedSettings);
          store.dispatch(SaveCompanyRequest(
              completer: completer, company: settingsUIState.company));
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final CompanyEntity company;
  final Function(CompanyEntity) onCompanyChanged;
  final Function(BuildContext, String) onCompanyDelete;
}
