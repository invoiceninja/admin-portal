import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
        ),
        SettingsListTile(
          section: kSettingsUserDetails,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsLocalization,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsOnlinePayments,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsTaxRates,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsProducts,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsNotifications,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsImportExport,
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
          section: kSettingsInvoiceSettings,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsInvoiceDesign,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsClientPortal,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsBuyNowButtons,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsEmailSettings,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsTemplatesAndReminders,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsCreditCardsAndBanks,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsDataVisualizations,
          viewModel: viewModel,
        ),
      ],
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    @required this.section,
    @required this.viewModel,
  });

  final String section;
  final SettingsListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return SelectedIndicator(
      isSelected: viewModel.state.uiState.containsRoute('/$section'),
      child: ListTile(
        title: Text(localization.lookup(section)),
        onTap: () {
          viewModel.loadSection(context, section);
        },
      ),
    );
  }
}
