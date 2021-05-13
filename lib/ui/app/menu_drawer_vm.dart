import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/oauth.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

class MenuDrawerBuilder extends StatelessWidget {
  const MenuDrawerBuilder({Key key}) : super(key: key);

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
    @required this.state,
    @required this.selectedCompany,
    @required this.user,
    @required this.selectedCompanyIndex,
    @required this.onCompanyChanged,
    @required this.isLoading,
    @required this.onAddCompany,
    @required this.onLogoutTap,
  });

  final AppState state;
  final CompanyEntity selectedCompany;
  final UserEntity user;
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
            message: AppLocalization.of(context).logout,
            context: context,
            callback: () async {
              store.dispatch(UserLogout());
              if (store.state.user.isConnectedToGoogle) {
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
            context: context,
            callback: () {
              store.dispatch(ClearEntityFilter());
              store.dispatch(DiscardChanges());
              store.dispatch(SelectCompany(companyIndex: index));
              if (store.state.isStale) {
                if (!store.state.isLoaded && store.state.company.isLarge) {
                  store.dispatch(LoadClients());
                } else {
                  store.dispatch(RefreshData());
                }
              }
              AppBuilder.of(context).rebuild();

              final uiState = state.uiState;
              if (uiState.isInSettings) {
                store.dispatch(ViewSettings(
                  company: company,
                  user: store.state.user,
                  section: uiState.subRoute,
                  force: true,
                ));

                if (uiState.isEditing || uiState.isViewing) {
                  store.dispatch(UpdateCurrentRoute(uiState.currentRoute
                      .replaceFirst('_edit', '')
                      .replaceFirst('_view', '')));
                }
              }
            });
      },
      onAddCompany: (BuildContext context) {
        confirmCallback(
            context: context,
            message: AppLocalization.of(context).addCompany,
            callback: () async {
              final completer = snackBarCompleter<Null>(
                  context, AppLocalization.of(context).addedCompany,
                  shouldPop: true);

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
