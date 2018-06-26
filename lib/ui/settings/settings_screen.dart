import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/settings/settings_list_vm.dart';

class SettingsScreen extends StatelessWidget {
  static final String route = '/settings';

  final Function onThemeChange;
  final bool isDark;
  SettingsScreen(this.onThemeChange, this.isDark);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.settings),
      ),
      drawer: AppDrawerBuilder(),
      body: SettingsListBuilder(onThemeChange, isDark),
    );
  }
}