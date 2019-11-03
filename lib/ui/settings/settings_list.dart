import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final SettingsListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = viewModel.state;
    final settingsUIState = state.uiState.settingsUIState;
    final showAll = settingsUIState.entityType == EntityType.company;

    if (settingsUIState.filter != null)
      return SettingsSearch(settingsUIState.filter);

    final title = (settingsUIState.entityType == EntityType.client)
        ? localization.filteredByClient +
            ': ${settingsUIState.client.displayName}'
        : (settingsUIState.entityType == EntityType.group)
            ? localization.filteredByGroup + ': ${settingsUIState.group.name}'
            : '';

    return ListView(
      children: <Widget>[
        if (settingsUIState.isFiltered)
          Container(
            color: Colors.orangeAccent,
            child: ListFilterMessage(
              title: title,
              onPressed: settingsUIState.entityType == EntityType.client
                  ? viewModel.onViewClientPressed
                  : viewModel.onViewGroupPressed,
              onClearPressed: viewModel.onClearSettingsFilterPressed,
            ),
          ),
        Container(
          color: Theme.of(context).bottomAppBarColor,
          padding: const EdgeInsets.only(left: 19, top: 16, bottom: 16),
          child: Text(
            localization.basicSettings,
            style: Theme.of(context).textTheme.body2,
          ),
        ),
        SettingsListTile(
          section: kSettingsCompanyDetails,
          viewModel: viewModel,
        ),
        if (showAll)
          SettingsListTile(
            section: kSettingsUserDetails,
            viewModel: viewModel,
          ),
        SettingsListTile(
          section: kSettingsLocalization,
          viewModel: viewModel,
        ),
        if (showAll)
          SettingsListTile(
            section: kSettingsOnlinePayments,
            viewModel: viewModel,
          ),
        if (showAll)
          SettingsListTile(
            section: kSettingsTaxRates,
            viewModel: viewModel,
          ),
        if (showAll)
          SettingsListTile(
            section: kSettingsProducts,
            viewModel: viewModel,
          ),
        /*
        if (showAll)
          SettingsListTile(
            section: kSettingsNotifications,
            viewModel: viewModel,
          ),
        if (showAll)
          SettingsListTile(
            section: kSettingsImportExport,
            viewModel: viewModel,
          ),
         */
        if (showAll)
          SettingsListTile(
            section: kSettingsDeviceSettings,
            viewModel: viewModel,
            icon: isMobile(context)
                ? FontAwesomeIcons.mobileAlt
                : FontAwesomeIcons.desktop,
          ),
        Container(
          color: Theme.of(context).bottomAppBarColor,
          padding: const EdgeInsets.only(left: 19, top: 16, bottom: 16),
          child: Text(
            localization.advancedSettings,
            style: Theme.of(context).textTheme.body2,
          ),
        ),
        SettingsListTile(
          section: kSettingsGroupSettings,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsGeneratedNumbers,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsCustomFields,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsInvoiceDesign,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsWorkflowSettings,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsClientPortal,
          viewModel: viewModel,
        ),
        /*
        if (showAll)
          SettingsListTile(
            section: kSettingsBuyNowButtons,
            viewModel: viewModel,
          ),
         */
        SettingsListTile(
          section: kSettingsEmailSettings,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsTemplatesAndReminders,
          viewModel: viewModel,
        ),
        /*
        SettingsListTile(
          section: kSettingsCreditCardsAndBanks,
          viewModel: viewModel,
        ),
        SettingsListTile(
          section: kSettingsDataVisualizations,
          viewModel: viewModel,
        ),
         */
        if (showAll)
          SettingsListTile(
            section: kSettingsUserManagement,
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
    this.icon,
  });

  final String section;
  final SettingsListVM viewModel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = viewModel.state;

    return SelectedIndicator(
      isSelected: viewModel.state.uiState.containsRoute('/$section'),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 6, top: 2),
          child: Icon(icon ?? getSettingIcon(section), size: 20),
        ),
        title: Text(localization.lookup(section)),
        onTap: () {
          if (section == kSettingsOnlinePayments &&
              state.companyGatewayState.list.isEmpty) {
            viewModel.loadSection(context, kSettingsOnlinePaymentsEdit);
          } else if (section == kSettingsTaxRates &&
              state.taxRateState.list.isEmpty) {
            viewModel.loadSection(context, kSettingsTaxRatesEdit);
          } else if (section == kSettingsGroupSettings &&
              state.groupState.list.isEmpty) {
            viewModel.loadSection(context, kSettingsGroupSettingsEdit);
          } else {
            viewModel.loadSection(context, section);
          }
        },
      ),
    );
  }
}

class SettingsSearch extends StatelessWidget {
  const SettingsSearch(this.filter);

  final String filter;

  static const map = {
    kSettingsCompanyDetails: ['id_number', 'vat_number', 'website'],
    kSettingsUserDetails: ['first_name', 'last_name', 'email', 'phone'],
  };

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    print('## FILTER: $filter');

    return ListView(
      children: <Widget>[
        for (var section in map.keys)
          for (var field in map[section])
            if (localization
                .lookup(field)
                .toLowerCase()
                .contains(filter.toLowerCase()))
              ListTile(
                title: Text(localization.lookup(field)),
              ),
      ],
    );
  }
}
