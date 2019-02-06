import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:local_auth/local_auth.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsListBuilder extends StatelessWidget {
  const SettingsListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsListVM>(
      converter: SettingsListVM.fromStore,
      builder: (context, viewModel) {
        return SettingsList(viewModel: viewModel);
      },
    );
  }
}

class SettingsListVM {
  SettingsListVM({
    @required this.state,
    @required this.onLogoutTap,
    @required this.onRefreshTap,
    @required this.onDarkModeChanged,
    @required this.enableDarkMode,
    @required this.autoStartTasks,
    @required this.onAutoStartTasksChanged,
    @required this.onRequireAuthenticationChanged,
    @required this.requireAuthentication,
    @required this.authenticationSupported,
  });

  static SettingsListVM fromStore(Store<AppState> store) {
    void _refreshData(BuildContext context) async {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete,
          shouldPop: true);
      store.dispatch(RefreshData(
        platform: getPlatform(context),
        completer: completer,
      ));
      await showDialog<AlertDialog>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SimpleDialog(
                children: <Widget>[LoadingDialog()],
              ));
      AppBuilder.of(context).rebuild();
      store.dispatch(LoadDashboard());
    }

    void _confirmLogout(BuildContext context) {
      final localization = AppLocalization.of(context);
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              semanticLabel: localization.areYouSure,
              title: Text(localization.areYouSure),
              actions: <Widget>[
                new FlatButton(
                    child: Text(localization.cancel.toUpperCase()),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new FlatButton(
                    child: Text(localization.ok.toUpperCase()),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.route, (Route<dynamic> route) => false);
                      store.dispatch(UserLogout());
                    })
              ],
            ),
      );
    }

    return SettingsListVM(
      state: store.state,
      onLogoutTap: (BuildContext context) => _confirmLogout(context),
      onRefreshTap: (BuildContext context) => _refreshData(context),
      onDarkModeChanged: (BuildContext context, bool value) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(kSharedPrefEnableDarkMode, value);
        store.dispatch(UserSettingsChanged(enableDarkMode: value));
        AppBuilder.of(context).rebuild();
      },
      onAutoStartTasksChanged: (BuildContext context, bool value) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(kSharedPrefAutoStartTasks, value);
        store.dispatch(UserSettingsChanged(autoStartTasks: value));
        AppBuilder.of(context).rebuild();
      },
      onRequireAuthenticationChanged: (BuildContext context, bool value) async {
        bool authenticated = false;
        try {
          authenticated = await LocalAuthentication()
              .authenticateWithBiometrics(
                  localizedReason:
                      AppLocalization.of(context).authenticateToChangeSetting,
                  useErrorDialogs: true,
                  stickyAuth: false);
        } catch (e) {
          print(e);
        }
        if (authenticated) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(kSharedPrefRequireAuthentication, value);
          store.dispatch(UserSettingsChanged(requireAuthentication: value));
        } else {}
      },
      autoStartTasks: store.state.uiState.autoStartTasks,
      enableDarkMode: store.state.uiState.enableDarkMode,
      requireAuthentication: store.state.uiState.requireAuthentication,
      //authenticationSupported: LocalAuthentication().canCheckBiometrics,
      // TODO remove this once issue is resolved:
      // https://github.com/flutter/flutter/issues/24339
      authenticationSupported: Future<bool>(() async {
        bool enable = false;
        try {
          enable = await LocalAuthentication().canCheckBiometrics;
        } catch (e) {
          // do nothing
        }
        return enable;
      }),
    );
  }

  final AppState state;
  final Function(BuildContext context) onLogoutTap;
  final Function(BuildContext context) onRefreshTap;
  final Function(BuildContext context, bool value) onDarkModeChanged;
  final Function(BuildContext context, bool value) onAutoStartTasksChanged;
  final bool enableDarkMode;
  final bool autoStartTasks;
  final Function(BuildContext context, bool value)
      onRequireAuthenticationChanged;
  final bool requireAuthentication;
  final Future<bool> authenticationSupported;
}
