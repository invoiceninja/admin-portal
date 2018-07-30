import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsListBuilder extends StatelessWidget {
  //final Function onThemeChange;
  //final bool isDark;
  //const SettingsListBuilder(this.onThemeChange, this.isDark, {Key key})
  //    : super(key: key);

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
  final Function(BuildContext context) onLogoutTapped;
  final Function(bool value) onDarkModeChanged;

  SettingsListVM({
    @required this.onLogoutTapped,
    @required this.onDarkModeChanged,
  });

  static SettingsListVM fromStore(Store<AppState> store) {
    return SettingsListVM(onLogoutTapped: (BuildContext context) {
      Navigator.popUntil(context, ModalRoute.withName(LoginScreen.route));
      /*
      while (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      Navigator.of(context).pushReplacementNamed(LoginScreen.route);
      */
      store.dispatch(UserLogout());
    }, onDarkModeChanged: (bool value) async {
      print('value: $value');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('darkMode', value);
    });
  }
}
