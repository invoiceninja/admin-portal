// Flutter imports:

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/oauth.dart';

class MenuDrawerBuilder extends StatelessWidget {
  const MenuDrawerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MenuDrawerVM>(
      converter: MenuDrawerVM.fromStore,
      builder: (context, viewModel) {
        return MenuDrawer(viewModel: viewModel);
      },
    );
  }
}

class MenuDrawerVM {
  MenuDrawerVM({
    required this.state,
    required this.selectedCompany,
    required this.user,
    required this.selectedCompanyIndex,
    required this.onCompanyChanged,
    required this.isLoading,
    required this.onAddCompany,
    required this.onLogoutTap,
  });

  final AppState state;
  final CompanyEntity? selectedCompany;
  final UserEntity? user;
  final String selectedCompanyIndex;
  final Function(BuildContext context, int, CompanyEntity) onCompanyChanged;
  final Function(BuildContext context) onAddCompany;
  final Function(BuildContext) onLogoutTap;

  final bool isLoading;

  static MenuDrawerVM fromStore(Store<AppState> store) {
    final AppState state = store.state;

    return MenuDrawerVM(
      state: state,
      isLoading: state.isLoading,
      user: state.user,
      selectedCompany: state.company,
      selectedCompanyIndex: state.uiState.selectedCompanyIndex.toString(),
      onLogoutTap: (BuildContext context) {
        if (state.isDemo && kReleaseMode) {
          return;
        }
        confirmCallback(
            message: AppLocalization.of(context)!.logout,
            context: context,
            callback: (_) async {
              store.dispatch(UserLogout());

              final user = store.state.user;
              if (user.isConnectedToGoogle) {
                GoogleOAuth.signOut();
              }
            });
      },
      onCompanyChanged:
          (BuildContext context, int index, CompanyEntity company) {
        if (index == state.uiState.selectedCompanyIndex) {
          return;
        }

        checkForChanges(
            store: store,
            callback: () {
              store.dispatch(ClearEntityFilter());
              store.dispatch(DiscardChanges());
              store.dispatch(SelectCompany(companyIndex: index));
              if (store.state.company.isLarge && !store.state.isLoaded) {
                store.dispatch(LoadClients());
              } else if (store.state.isStale) {
                store.dispatch(RefreshData());
              }
              AppBuilder.of(context)!.rebuild();

              final uiState = state.uiState;
              if (uiState.isInSettings) {
                store.dispatch(ViewSettings(
                  company: company,
                  user: store.state.user,
                  section: uiState.subRoute,
                  force: true,
                ));
              } else if (uiState.isEditing ||
                  uiState.isViewing ||
                  uiState.isEmailing ||
                  uiState.isPDF) {
                store.dispatch(UpdateCurrentRoute(uiState.baseRoute));
              }
            });
      },
      onAddCompany: (BuildContext context) {
        if (state.isHosted &&
            !state.isPaidAccount &&
            state.companies.length >= state.account.hostedCompanyCount) {
          showMessageDialog(
            message: AppLocalization.of(context)!.upgradeToAddCompany,
          );
          return;
        }

        confirmCallback(
            context: context,
            message: AppLocalization.of(context)!.addCompany,
            callback: (_) async {
              final completer = snackBarCompleter<Null>(
                  AppLocalization.of(context)!.addedCompany,
                  shouldPop: true)
                ..future.then<Null>((_) {
                  AppBuilder.of(navigatorKey.currentContext!)!.rebuild();
                });

              store
                  .dispatch(AddCompany(context: context, completer: completer));

              await showDialog<AlertDialog>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => SimpleDialog(
                        children: <Widget>[LoadingDialog()],
                      ));
            });
      },
    );
  }
}
