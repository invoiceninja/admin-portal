// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/oauth.dart';

class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({Key? key}) : super(key: key);
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
    required this.state,
    required this.company,
    required this.onCompanyChanged,
    required this.onSetPrimaryCompany,
    required this.onSavePressed,
    required this.onCompanyDelete,
    required this.onPurgeData,
    required this.onAppliedLicense,
  });

  static AccountManagementVM fromStore(Store<AppState> store) {
    final state = store.state;

    return AccountManagementVM(
        state: state,
        company: state.uiState.settingsUIState.company,
        onCompanyChanged: (company) =>
            store.dispatch(UpdateCompany(company: company)),
        onCompanyDelete: (context, password, idToken, reason) {
          showDialog<AlertDialog>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => SimpleDialog(
                    children: <Widget>[LoadingDialog()],
                  ));

          final companyLength = state.companies.length;
          final deleteCompleter = Completer<Null>()
            ..future.then<Null>((_) {
              final context = navigatorKey.currentContext;
              final state = store.state;
              if (companyLength == 1) {
                store.dispatch(UserLogout());
                if (state.user.isConnectedToGoogle) {
                  GoogleOAuth.disconnect();
                }
              } else {
                final selectedCompanyIndex = state.uiState.selectedCompanyIndex;
                final index = selectedCompanyIndex == 0 ? 1 : 0;
                store.dispatch(SelectCompany(companyIndex: index));
                final refreshCompleter = Completer<Null>()
                  ..future.then<Null>((_) {
                    store.dispatch(SelectCompany(companyIndex: 0));
                    store.dispatch(ViewDashboard());
                    AppBuilder.of(navigatorKey.currentContext!)!.rebuild();

                    if (Navigator.of(context!).canPop()) {
                      Navigator.of(context).pop();
                    }
                  });
                store.dispatch(
                    RefreshData(clearData: true, completer: refreshCompleter));
              }
            }).catchError((Object error) {
              if (Navigator.of(navigatorKey.currentContext!).canPop()) {
                Navigator.of(navigatorKey.currentContext!).pop();
              }

              showDialog<ErrorDialog>(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return ErrorDialog(error);
                  });
            });
          store.dispatch(DeleteCompanyRequest(
            completer: deleteCompleter,
            password: password,
            idToken: idToken,
            reason: reason,
          ));
        },
        onSavePressed: (context) {
          Debouncer.runOnComplete(() {
            final settingsUIState = store.state.uiState.settingsUIState;
            final completer = snackBarCompleter<Null>(
                AppLocalization.of(context)!.savedSettings);
            store.dispatch(SaveCompanyRequest(
                completer: completer, company: settingsUIState.company));
          });
        },
        onPurgeData: (context, password, idToken) {
          final completer = snackBarCompleter<Null>(
              AppLocalization.of(context)!.purgeSuccessful);
          store.dispatch(PurgeDataRequest(
            completer: completer,
            password: password,
            idToken: idToken,
          ));
        },
        onAppliedLicense: () {
          store.dispatch(RefreshData());
        },
        onSetPrimaryCompany: (context) {
          final completer = snackBarCompleter<Null>(
              AppLocalization.of(context)!.updatedCompany);
          store.dispatch(SetDefaultCompanyRequest(completer: completer));
        });
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final CompanyEntity company;
  final Function(BuildContext) onSetPrimaryCompany;
  final Function(CompanyEntity) onCompanyChanged;
  final Function(BuildContext, String, String, String) onCompanyDelete;
  final Function(BuildContext, String, String) onPurgeData;
  final Function onAppliedLicense;
}
