import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SettingsList extends StatelessWidget {
  final SettingsListVM viewModel;

  const SettingsList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchListTile(
          title: Text(AppLocalization.of(context).darkMode),
          value: viewModel.enableDarkMode,
          onChanged: (value) => viewModel.onDarkModeChanged(context, value),
          secondary: Icon(FontAwesomeIcons.moon),
          activeColor: Theme.of(context).accentColor,
        ),
        SwitchListTile(
          title: Text(AppLocalization.of(context).biometricAuthentication),
          value: viewModel.requireAuthentication,
          onChanged: (value) =>
              viewModel.onRequireAuthenticationChanged(context, value),
          secondary: Icon(viewModel.requireAuthentication
              ? FontAwesomeIcons.lock
              : FontAwesomeIcons.unlockAlt),
          activeColor: Theme.of(context).accentColor,
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.syncAlt),
          title: Text(AppLocalization.of(context).refreshData),
          onTap: () {
            viewModel.onRefreshTap(context);
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.powerOff),
          title: Text(AppLocalization.of(context).logout),
          onTap: () {
            viewModel.onLogoutTap(context);
          },
        ),
      ],
    );
  }
}
