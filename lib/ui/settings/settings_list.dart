import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
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
          section: kSettingsCompanyDetails,
          viewModel: viewModel,
          icon: FontAwesomeIcons.building,
        ),
        SettingsListTile(
          section: kSettingsUserDetails,
          viewModel: viewModel,
          icon: FontAwesomeIcons.user,
        ),
        SettingsListTile(
          section: kSettingsLocalization,
          viewModel: viewModel,
          icon: FontAwesomeIcons.globe,
        ),
        SettingsListTile(
          section: kSettingsOnlinePayments,
          viewModel: viewModel,
          icon: FontAwesomeIcons.creditCard,
        ),
        SettingsListTile(
          section: kSettingsTaxRates,
          viewModel: viewModel,
          icon: FontAwesomeIcons.percent,
        ),
        SettingsListTile(
          section: kSettingsProducts,
          viewModel: viewModel,
          icon: FontAwesomeIcons.cube,
        ),
        SettingsListTile(
          section: kSettingsNotifications,
          viewModel: viewModel,
          icon: FontAwesomeIcons.bell,
        ),
        SettingsListTile(
          section: kSettingsImportExport,
          viewModel: viewModel,
          icon: FontAwesomeIcons.fileExport,
        ),
        SettingsListTile(
          section: kSettingsDeviceSettings,
          viewModel: viewModel,
          icon: FontAwesomeIcons.cogs,
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
          section: kSettingsInvoiceSettings,
          viewModel: viewModel,
          icon: FontAwesomeIcons.fileInvoice,
        ),
        SettingsListTile(
          section: kSettingsInvoiceDesign,
          viewModel: viewModel,
          icon: FontAwesomeIcons.paintBrush,
        ),
        SettingsListTile(
          section: kSettingsClientPortal,
          viewModel: viewModel,
          icon: FontAwesomeIcons.cloud,
        ),
        SettingsListTile(
          section: kSettingsBuyNowButtons,
          viewModel: viewModel,
          icon: FontAwesomeIcons.link,
        ),
        SettingsListTile(
          section: kSettingsEmailSettings,
          viewModel: viewModel,
          icon: FontAwesomeIcons.solidEnvelope,
        ),
        SettingsListTile(
          section: kSettingsTemplatesAndReminders,
          viewModel: viewModel,
          icon: FontAwesomeIcons.solidClock,
        ),
        /*
        SettingsListTile(
          section: kSettingsCreditCardsAndBanks,
          viewModel: viewModel,
          icon: FontAwesomeIcons.link,
        ),
        SettingsListTile(
          section: kSettingsDataVisualizations,
          viewModel: viewModel,
          icon: FontAwesomeIcons.link,
        ),
         */
      ],
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    @required this.section,
    @required this.viewModel,
    this.icon,
  });

  final String section;
  final SettingsListVM viewModel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return SelectedIndicator(
      isSelected: viewModel.state.uiState.containsRoute('/$section'),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 6, top: 2),
          child: Icon(icon, size: 20),
        ),
        title: Text(localization.lookup(section)),
        onTap: () {
          viewModel.loadSection(context, section);
        },
      ),
    );
  }
}
