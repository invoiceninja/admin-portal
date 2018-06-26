import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/ui/auth/login_vm.dart';
import 'package:invoiceninja/ui/settings/settings_list.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';

class SettingsListBuilder extends StatelessWidget {
  final Function onThemeChange;
  final bool isDark;
  SettingsListBuilder(this.onThemeChange, this.isDark, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsListVM>(
      converter: SettingsListVM.fromStore,
      builder: (context, viewModel) {
        return SettingsList(onThemeChange: onThemeChange, isDark: isDark, viewModel: viewModel);
      },
    );
  }
}

class SettingsListVM {
  final Function(BuildContext context) onLogoutTapped;

  SettingsListVM({
    @required this.onLogoutTapped,
  });

  static SettingsListVM fromStore(Store<AppState> store) {
    return SettingsListVM(
      onLogoutTapped: (BuildContext context) {
        while(Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
        store.dispatch(UserLogout());
      }
    );
  }
}