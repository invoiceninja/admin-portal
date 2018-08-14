import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
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
  final Function(BuildContext context) onLogoutTap;
  final Function(BuildContext context) onRefreshTap;
  final Function(BuildContext context, bool value) onDarkModeChanged;
  final bool enableDarkMode;

  SettingsListVM({
    @required this.onLogoutTap,
    @required this.onRefreshTap,
    @required this.onDarkModeChanged,
    @required this.enableDarkMode,
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
      showDialog<AlertDialog>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SimpleDialog(
                children: <Widget>[LoadingDialog()],
              ));
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
                      final navigator = Navigator.of(context);
                      while (navigator.canPop()) {
                        navigator.pop();
                      }
                      navigator.pushNamed(LoginScreen.route);
                      store.dispatch(UserLogout());
                    })
              ],
            ),
      );
    }

    void _warnRestart(BuildContext context) {
      final localization = AppLocalization.of(context);
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              semanticLabel: localization.restartAppToApplyChange,
              title: Text(localization.restartAppToApplyChange),
              actions: <Widget>[
                new FlatButton(
                    child: Text(localization.ok.toUpperCase()),
                    onPressed: () => Navigator.pop(context))
              ],
            ),
      );
    }

    return SettingsListVM(
        onLogoutTap: (BuildContext context) => _confirmLogout(context),
        onRefreshTap: (BuildContext context) => _refreshData(context),
        onDarkModeChanged: (BuildContext context, bool value) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(kSharedPrefEnableDarkMode, value);
          store.dispatch(UserSettingsChanged(enableDarkMode: value));
          _warnRestart(context);
        },
        enableDarkMode: store.state.uiState.enableDarkMode);
  }
}
