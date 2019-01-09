import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final SettingsListVM viewModel;

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
        FutureBuilder(
          future: viewModel.authenticationSupported,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return SwitchListTile(
                title:
                    Text(AppLocalization.of(context).biometricAuthentication),
                value: viewModel.requireAuthentication,
                onChanged: (value) =>
                    viewModel.onRequireAuthenticationChanged(context, value),
                secondary: Icon(viewModel.requireAuthentication
                    ? FontAwesomeIcons.lock
                    : FontAwesomeIcons.unlockAlt),
                activeColor: Theme.of(context).accentColor,
              );
            } else {
              return SizedBox();
            }
          },
        ),
        viewModel.state.selectedCompany.isModuleEnabled(EntityType.task)
            ? SwitchListTile(
                title: Text(AppLocalization.of(context).autoStartTasks),
                value: viewModel.autoStartTasks,
                onChanged: (value) =>
                    viewModel.onAutoStartTasksChanged(context, value),
                secondary: Icon(FontAwesomeIcons.clock),
                activeColor: Theme.of(context).accentColor,
              )
            : SizedBox(),
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
