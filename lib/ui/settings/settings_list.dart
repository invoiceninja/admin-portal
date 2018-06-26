import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/settings/settings_list_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/utils/localization.dart';

class SettingsList extends StatelessWidget {
  final SettingsListVM viewModel;
  final Function onThemeChange;
  final bool isDark;


  SettingsList({
    Key key,
    @required this.isDark,
    @required this.onThemeChange,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchListTile(
          title: Text(AppLocalization.of(context).dark_theme),
          value: this.isDark,
          onChanged: this.onThemeChange,
          secondary: Icon(Icons.format_paint),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.powerOff),
          title: Text(AppLocalization.of(context).logOut),
          onTap: () {
            viewModel.onLogoutTapped(context);
          },
        ),
      ],
    );
  }
}