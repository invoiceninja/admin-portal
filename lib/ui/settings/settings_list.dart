import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final SettingsListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListView(
      children: <Widget>[
        SettingsListTile(
          title: localization.companyDetails,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.userDetails,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.localization,
          viewModel: viewModel,
        ),
      ],
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    @required this.title,
    @required this.viewModel,
  });

  final String title;
  final SettingsListVM viewModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        viewModel.loadSection(context, title);
      },
    );
  }
}
