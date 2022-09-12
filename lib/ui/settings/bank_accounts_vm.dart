// Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/bank_accounts.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class BankAccountSettingsScreen extends StatelessWidget {
  const BankAccountSettingsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsBankAccountSettings';

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
    @required this.onConnectAccounts,
    @required this.onRefreshAccounts,
  });

  static BankAccountsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return BankAccountsVM(
        state: state,
        company: state.uiState.settingsUIState.company,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onRefreshAccounts: () {
          final webClient = WebClient();
          final credentials = state.credentials;
          final url = '${credentials.url}/bank_integrations/refresh_accounts';

          store.dispatch(StartSaving());

          webClient.post(url, credentials.token).then((dynamic response) {
            store.dispatch(StopSaving());
            print('## RESPONSE: $response');
          }).catchError((dynamic error) {
            store.dispatch(StopSaving());
            showErrorDialog(
                context: navigatorKey.currentContext, message: '$error');
          });
        },
        onConnectAccounts: () {
          final webClient = WebClient();
          final credentials = state.credentials;
          final url = '${credentials.url}/one_time_token';

          store.dispatch(StartSaving());

          webClient
              .post(url, credentials.token,
                  data: jsonEncode({
                    'context': {'return_url': ''}
                  }))
              .then((dynamic response) {
            store.dispatch(StopSaving());
            launchUrl(Uri.parse(
                '${cleanApiUrl(credentials.url)}/yodlee/onboard/${response['hash']}'));
          }).catchError((dynamic error) {
            store.dispatch(StopSaving());
            showErrorDialog(
                context: navigatorKey.currentContext, message: '$error');
          });
        },
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
  final Function onConnectAccounts;
  final Function onRefreshAccounts;
}
