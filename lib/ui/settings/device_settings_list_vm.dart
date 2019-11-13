import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_list.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:local_auth/local_auth.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceSettingsScreen extends StatelessWidget {
  const DeviceSettingsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsDeviceSettings';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DeviceSettingsVM>(
      converter: DeviceSettingsVM.fromStore,
      builder: (context, viewModel) {
        return DeviceSettings(viewModel: viewModel);
      },
    );
  }
}

class DeviceSettingsVM {
  DeviceSettingsVM({
    @required this.state,
    @required this.onLogoutTap,
    @required this.onRefreshTap,
    @required this.onDarkModeChanged,
    @required this.onLayoutChanged,
    @required this.onAutoStartTasksChanged,
    @required this.onRequireAuthenticationChanged,
    @required this.onAccentColorChanged,
    @required this.onLongPressSelectionIsDefault,
    @required this.authenticationSupported,
  });

  static DeviceSettingsVM fromStore(Store<AppState> store) {
    void _refreshData(BuildContext context) async {
      final completer = snackBarCompleter<Null>(
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
                  store.dispatch(UserLogout(context));
                })
          ],
        ),
      );
    }

    return DeviceSettingsVM(
      state: store.state,
      onLogoutTap: (BuildContext context) => _confirmLogout(context),
      onRefreshTap: (BuildContext context) => _refreshData(context),
      onDarkModeChanged: (BuildContext context, bool value) async {
        if (!kIsWeb) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(kSharedPrefEnableDarkMode, value);
        }
        store.dispatch(UserSettingsChanged(enableDarkMode: value));
        AppBuilder.of(context).rebuild();
      },
      onAccentColorChanged: (BuildContext context, String value) async {
        value ??= kDefaultAccentColor;
        if (!kIsWeb) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(kSharedPrefAccentColor, value);
        }
        store.dispatch(UserSettingsChanged(accentColor: value));
        AppBuilder.of(context).rebuild();
      },
      onAutoStartTasksChanged: (BuildContext context, bool value) async {
        if (!kIsWeb) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(kSharedPrefAutoStartTasks, value);
        }
        store.dispatch(UserSettingsChanged(autoStartTasks: value));
        AppBuilder.of(context).rebuild();
      },
      onLongPressSelectionIsDefault: (BuildContext context, bool value) async {
        if (!kIsWeb) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(kSharedPrefLongPressSelectionIsDefault, value);
        }
        store.dispatch(UserSettingsChanged(longPressSelectionIsDefault: value));
        AppBuilder.of(context).rebuild();
      },
      onLayoutChanged: (BuildContext context, AppLayout value) {
        store.dispatch(UpdateLayout(value));
        AppBuilder.of(context).rebuild();
        if (value == AppLayout.mobile) {
          store.dispatch(ViewDashboard(context: context));
        } else {
          store.dispatch(ViewMainScreen(context));
        }

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
  final Function(BuildContext) onLogoutTap;
  final Function(BuildContext) onRefreshTap;
  final Function(BuildContext, bool) onDarkModeChanged;
  final Function(BuildContext, AppLayout) onLayoutChanged;
  final Function(BuildContext, String) onAccentColorChanged;
  final Function(BuildContext, bool) onAutoStartTasksChanged;
  final Function(BuildContext, bool) onLongPressSelectionIsDefault;
  final Function(BuildContext, bool) onRequireAuthenticationChanged;
  final Future<bool> authenticationSupported;
}
