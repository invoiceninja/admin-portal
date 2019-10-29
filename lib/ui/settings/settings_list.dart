import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
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
    final showAll =
        state.uiState.settingsUIState.entityType == EntityType.company;
    final settingsUIState = state.uiState.settingsUIState;

    final title = settingsUIState.entityType == EntityType.client
        ? localization.filteredByClient +
            ': ${settingsUIState.client.displayName}'
        : localization.filteredByGroup + ': ${settingsUIState.group.name}';

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
          icon: FontAwesomeIcons.building,
        ),
        if (showAll)
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
        if (showAll)
          SettingsListTile(
            section: kSettingsOnlinePayments,
            viewModel: viewModel,
            icon: FontAwesomeIcons.creditCard,
          ),
        if (showAll)
          SettingsListTile(
            section: kSettingsTaxRates,
            viewModel: viewModel,
            icon: FontAwesomeIcons.percent,
          ),
        if (showAll)
          SettingsListTile(
            section: kSettingsProducts,
            viewModel: viewModel,
            icon: FontAwesomeIcons.cube,
          ),
        /*
        if (showAll)
          SettingsListTile(
            section: kSettingsNotifications,
            viewModel: viewModel,
            icon: FontAwesomeIcons.bell,
          ),
        if (showAll)
          SettingsListTile(
            section: kSettingsImportExport,
            viewModel: viewModel,
            icon: FontAwesomeIcons.fileExport,
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
          icon: FontAwesomeIcons.layerGroup,
        ),
        SettingsListTile(
          section: kSettingsGeneratedNumbers,
          viewModel: viewModel,
          icon: FontAwesomeIcons.idBadge,
        ),
        SettingsListTile(
          section: kSettingsCustomFields,
          viewModel: viewModel,
          icon: FontAwesomeIcons.heading,
        ),
        SettingsListTile(
          section: kSettingsInvoiceDesign,
          viewModel: viewModel,
          icon: FontAwesomeIcons.paintBrush,
        ),
        SettingsListTile(
          section: kSettingsWorkflowSettings,
          viewModel: viewModel,
          icon: FontAwesomeIcons.codeBranch,
        ),
        SettingsListTile(
          section: kSettingsClientPortal,
          viewModel: viewModel,
          icon: FontAwesomeIcons.cloud,
        ),
        /*
        if (showAll)
          SettingsListTile(
            section: kSettingsBuyNowButtons,
            viewModel: viewModel,
            icon: FontAwesomeIcons.link,
          ),
         */
        SettingsListTile(
          section: kSettingsEmailSettings,
          viewModel: viewModel,
          icon: FontAwesomeIcons.solidEnvelope,
        ),
        /*
        SettingsListTile(
          section: kSettingsTemplatesAndReminders,
          viewModel: viewModel,
          icon: FontAwesomeIcons.solidClock,
        ),
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
        SettingsListTile(
          section: kSettingsUserManagement,
          viewModel: viewModel,
          icon: FontAwesomeIcons.layerGroup,
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
          child: Icon(icon, size: 20),
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
