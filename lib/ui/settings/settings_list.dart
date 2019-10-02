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
        Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          child: Text(
            localization.basicSettings,
            style: Theme.of(context).textTheme.title,
          ),
        ),
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
        SettingsListTile(
          title: localization.onlinePayments,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.taxRates,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.products,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.notifications,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.importExport,
          viewModel: viewModel,
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          child: Text(
            localization.advancedSettings,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        SettingsListTile(
          title: localization.invoiceSettings,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.invoiceDesign,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.clientPortal,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.buyNowButtons,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.emailSettings,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.templatesAndReminders,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.creditCardsAndBanks,
          viewModel: viewModel,
        ),
        SettingsListTile(
          title: localization.dataVisualizations,
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
