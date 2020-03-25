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

    if (state.credentials.token.isEmpty) {
      return SizedBox();
    }

    if (!state.userCompany.isAdmin)
      return ListView(
        children: <Widget>[
          SettingsListTile(
            section: kSettingsUserDetails,
            viewModel: viewModel,
          ),
          SettingsListTile(
            section: kSettingsDeviceSettings,
            viewModel: viewModel,
          ),
        ],
      );
    else if (settingsUIState.filter != null)
      return SettingsSearch(
        viewModel: viewModel,
        filter: settingsUIState.filter,
      );

    return ListView(
      children: <Widget>[
        if (settingsUIState.isFiltered)
          Container(
            color: Colors.orangeAccent,
            child: ListFilterMessage(
              filterEntityType: settingsUIState.entityType,
              filterEntityId: settingsUIState.entityType == EntityType.group
                  ? settingsUIState.group.id
                  : settingsUIState.client.id,
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
            style: Theme.of(context).textTheme.bodyText2,
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
            section: kSettingsTaxSettings,
            viewModel: viewModel,
          ),
        if (showAll)
          SettingsListTile(
            section: kSettingsProducts,
            viewModel: viewModel,
          ),
        // TODO Re-entable
        /*
        if (showAll)
          SettingsListTile(
            section: kSettingsIntegrations,
            viewModel: viewModel,
          ),
         */
        /*
        if (showAll)
          SettingsListTile(
            section: kSettingsImportExport,
            viewModel: viewModel,
          ),
         */
        if (showAll && state.userCompany.isOwner)
          SettingsListTile(
            section: kSettingsAccountManagement,
            viewModel: viewModel,
          ),
        if (showAll)
          SettingsListTile(
            section: kSettingsDeviceSettings,
            viewModel: viewModel,
          ),
        Container(
          color: Theme.of(context).bottomAppBarColor,
          padding: const EdgeInsets.only(left: 19, top: 16, bottom: 16),
          child: Text(
            localization.advancedSettings,
            style: Theme.of(context).textTheme.bodyText2,
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
        if (showAll)
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
  });

  final String section;
  final SettingsListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = viewModel.state;

    IconData icon;
    if (section == kSettingsDeviceSettings) {
      icon = kIsWeb
          ? Icons.desktop_mac
          : isMobile(context)
              ? FontAwesomeIcons.mobileAlt
              : FontAwesomeIcons.desktop;
    } else {
      icon = getSettingIcon(section);
    }

    return SelectedIndicator(
      isSelected: viewModel.state.uiState.containsRoute('/$section'),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 6, top: 2),
          child: Icon(icon ?? icon, size: 20),
        ),
        title: Text(localization.lookup(section)),
        onTap: () {
          if (section == kSettingsOnlinePayments &&
              state.companyGatewayState.list.isEmpty) {
            viewModel.loadSection(context, kSettingsOnlinePaymentsEdit);
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
  const SettingsSearch({this.filter, this.viewModel});

  final SettingsListVM viewModel;
  final String filter;

  static const map = {
    kSettingsCompanyDetails: [
      'name',
      'id_number',
      'vat_number',
      'website',
      'email',
      'phone',
      'logo',
      'address',
      'postal_code',
      'country',
      'defaults',
      'payment_type',
      'payment_terms',
      'task_rate',
      'invoice_terms',
      'invoice_footer',
      'quote_terms',
      'quote_footer',
      'credit_terms',
      'credit_footer',
    ],
    kSettingsUserDetails: [
      'first_name',
      'last_name',
      'email',
      'phone',
    ],
    kSettingsLocalization: [
      'currency',
      'language',
      'timezone',
      'date_format',
      'military_time',
      'first_day_of_the_week',
      'first_month_of_the_year',
    ],
    kSettingsOnlinePayments: [
      'accepted_card_logos',
      'limits_and_fees',
    ],
    kSettingsTaxSettings: [
      'tax_settings',
    ],
    kSettingsTaxRates: [
      'tax_rates',
    ],
    kSettingsProducts: [
      'fill_products',
      'update_products',
      'convert_products',
    ],
    kSettingsDeviceSettings: [
      'dark_mode',
      'long_press_multiselect',
      'biometric_authentication',
      'refresh_data',
      'logout',
    ],
    kSettingsGroupSettings: [
      'groups',
    ],
    kSettingsGeneratedNumbers: [
      'number_padding',
      'number_counter',
      'recurring_prefix',
      'reset_counter',
      'invoice_number',
      'client_number',
      'credit_number',
      'payment_number',
    ],
    kSettingsCustomFields: [
      'custom_fields',
    ],
    kSettingsInvoiceDesign: [
      'invoice_design',
      'quote_design',
      'page_size',
      'font_size',
      'primary_font',
      'secondary_font',
      'primary_color',
      'secondary_color',
      'all_pages_header',
      'all_pages_footer',
      'hide_paid_to_date',
      'invoice_embed_documents',
    ],
    kSettingsCustomDesigns: [
      'custom_designs',
    ],
    kSettingsWorkflowSettings: [
      'auto_email_invoice',
      'auto_archive_invoice',
      'auto_convert',
    ],
    kSettingsClientPortal: [
      'portal_mode',
      'subdomain',
      'domain',
      'enable_portal_password',
      'show_accept_invoice_terms',
      'show_accept_quote_terms',
      'require_invoice_signature',
      'require_quote_signature',
      'custom_css',
    ],
    kSettingsEmailSettings: [
      'email_design',
      'reply_to_email',
      'bcc_email',
      'attach_pdf',
      'attach_documents',
      'attach_ubl',
      'email_signature',
    ],
    kSettingsTemplatesAndReminders: [
      'template',
      'send_reminders',
      'late_fees',
    ],
    kSettingsUserManagement: [
      'users',
    ]
  };

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
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
                leading: Padding(
                  padding: const EdgeInsets.only(left: 6, top: 10),
                  child: Icon(getSettingIcon(section), size: 20),
                ),
                subtitle: Text(localization.lookup(section)),
                onTap: () => viewModel.loadSection(context, section),
              ),
      ],
    );
  }
}
