import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class SettingsScreen extends StatelessWidget {
  static const String route = '/settings';

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: Text(localization.settings),
      hideHamburgerButton: !isMobile(context),
      body: SettingsListBuilder(),
    );
  }
}
