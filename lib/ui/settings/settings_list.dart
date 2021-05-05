import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final SettingsListVM viewModel;

  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = widget.viewModel.state;
    final settingsUIState = state.uiState.settingsUIState;
    final showAll = settingsUIState.entityType == EntityType.company;

    if (state.credentials.token.isEmpty) {
      return SizedBox();
    }

    if (!state.userCompany.isAdmin)
      return Stack(
        children: [
          ScrollableListView(
            children: <Widget>[
              SettingsListTile(
                section: kSettingsUserDetails,
                viewModel: widget.viewModel,
              ),
              SettingsListTile(
                section: kSettingsDeviceSettings,
                viewModel: widget.viewModel,
              ),
            ],
          ),
          if (state.isLoading) LinearProgressIndicator(),
        ],
      );
    else if (settingsUIState.filter != null)
      return SettingsSearch(
        viewModel: widget.viewModel,
        filter: settingsUIState.filter,
      );

    return Stack(
      children: [
        ScrollableListView(
          scrollController: _scrollController,
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
                      ? widget.viewModel.onViewClientPressed
                      : widget.viewModel.onViewGroupPressed,
                  onClearPressed: widget.viewModel.onClearSettingsFilterPressed,
                  isSettings: true,
                ),
              ),
            Container(
              color: Theme.of(context).backgroundColor,
              padding: const EdgeInsets.only(left: 19, top: 16, bottom: 16),
              child: Text(
                localization.basicSettings,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SettingsListTile(
              section: kSettingsCompanyDetails,
              viewModel: widget.viewModel,
            ),
            if (showAll)
              SettingsListTile(
                section: kSettingsUserDetails,
                viewModel: widget.viewModel,
              ),
            SettingsListTile(
              section: kSettingsLocalization,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsOnlinePayments,
              viewModel: widget.viewModel,
            ),
            if (showAll)
              SettingsListTile(
                section: kSettingsTaxSettings,
                viewModel: widget.viewModel,
              ),
            if (showAll)
              SettingsListTile(
                section: kSettingsProducts,
                viewModel: widget.viewModel,
              ),
            if (state.company.isModuleEnabled(EntityType.task))
              SettingsListTile(
                section: kSettingsTasks,
                viewModel: widget.viewModel,
              ),
            if (showAll && state.company.isModuleEnabled(EntityType.expense))
              SettingsListTile(
                section: kSettingsExpenses,
                viewModel: widget.viewModel,
              ),
            // TODO Re-entable
            /*
              if (showAll)
                SettingsListTile(
                  section: kSettingsIntegrations,
                  viewModel: viewModel,
                ),
               */
            if (showAll)
              SettingsListTile(
                section: kSettingsImportExport,
                viewModel: widget.viewModel,
              ),
            if (showAll)
              SettingsListTile(
                section: kSettingsDeviceSettings,
                viewModel: widget.viewModel,
              ),
            if (showAll && state.userCompany.isOwner)
              SettingsListTile(
                section: kSettingsAccountManagement,
                viewModel: widget.viewModel,
              ),
            Container(
              color: Theme.of(context).backgroundColor,
              padding: const EdgeInsets.only(left: 19, top: 16, bottom: 16),
              child: Text(
                localization.advancedSettings,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),

            SettingsListTile(
              section: kSettingsInvoiceDesign,
              viewModel: widget.viewModel,
            ),
            if (showAll)
              SettingsListTile(
                section: kSettingsCustomFields,
                viewModel: widget.viewModel,
              ),
            SettingsListTile(
              section: kSettingsGeneratedNumbers,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsEmailSettings,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsClientPortal,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsTemplatesAndReminders,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsGroupSettings,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsSubscriptions,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsWorkflowSettings,
              viewModel: widget.viewModel,
            ),
            /*
              if (showAll)
                SettingsListTile(
                  section: kSettingsBuyNowButtons,
                  viewModel: viewModel,
                ),
               */
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
                viewModel: widget.viewModel,
              ),
          ],
        ),
        if (state.isLoading) LinearProgressIndicator(),
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

    IconData icon;
    if (section == kSettingsDeviceSettings) {
      icon = isMobile(context) ? Icons.phone_android : MdiIcons.desktopClassic;
    } else {
      icon = getSettingIcon(section);
    }

    return Container(
      color: Theme.of(context).cardColor,
      child: SelectedIndicator(
        isSelected: viewModel.state.uiState.containsRoute('/$section') &&
            isDesktop(context),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 6, top: 2),
            child: Icon(icon ?? icon, size: 22),
          ),
          title: Text(localization.lookup(section)),
          onTap: () => viewModel.loadSection(context, section, 0),
        ),
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
      [
        'name',
        'id_number',
        'vat_number',
        'website',
        'email',
        'phone',
        'size',
        'industry',
      ],
      [
        'address',
        'postal_code',
        'country',
      ],
      [
        'logo',
      ],
      [
        'defaults',
        'auto_bill',
        'payment_type',
        'payment_terms',
        'online_payment_email',
        'manual_payment_email',
        'invoice_terms',
        'invoice_footer',
        'quote_terms',
        'quote_footer',
        'credit_terms',
        'credit_footer',
      ],
      [
        'default_documents',
      ]
    ],
    kSettingsUserDetails: [
      [
        'first_name',
        'last_name',
        'email',
        'phone',
        'password',
        'accent_color',
        'connect_google',
        'connect_gmail',
        'enable_two_factor',
      ],
      [
        'notifications',
      ],
    ],
    kSettingsLocalization: [
      [
        'currency',
        'language',
        'timezone',
        'date_format',
        'military_time',
        'first_month_of_the_year',
      ],
      [
        'custom_labels',
      ],
    ],
    kSettingsOnlinePayments: [
      [
        'company_gateways',
        'auto_bill_on',
        'use_available_credits',
        'allow_over_payment',
        'allow_under_payment',
      ]
    ],
    kSettingsTaxSettings: [
      [
        'tax_settings',
      ],
    ],
    kSettingsTaxRates: [
      [
        'tax_rates',
      ],
    ],
    kSettingsProducts: [
      [
        'fill_products',
        'update_products',
        'convert_products',
      ],
    ],
    kSettingsTasks: [
      [
        'task_settings',
        'auto_start_tasks',
        'show_tasks_table',
      ],
    ],
    kSettingsTaskStatuses: [
      [
        'task_statuses',
      ],
    ],
    kSettingsExpenses: [
      [
        'should_be_invoiced',
        'mark_paid',
      ],
    ],
    kSettingsExpenseCategories: [
      [
        'expense_categories',
      ],
    ],
    kSettingsImportExport: [
      [
        'import',
        'export',
      ],
    ],
    kSettingsDeviceSettings: [
      [
        'rows_per_page',
        'dark_mode',
        'long_press_multiselect',
        'biometric_authentication',
        'refresh_data',
      ],
    ],
    kSettingsAccountManagement: [
      [
        'api_tokens',
        'api_webhooks',
        'purge_data',
        'delete_company',
      ],
      [
        'enabled_modules',
      ],
      [
        'password_timeout',
        'web_session_timeout',
      ],
    ],
    kSettingsInvoiceDesign: [
      [
        'invoice_design',
        'quote_design',
        'page_size',
        'font_size',
        'primary_font',
        'secondary_font',
        'primary_color',
        'secondary_color',
      ],
      [
        'all_pages_header',
        'all_pages_footer',
        'empty_columns',
      ],
    ],
    kSettingsCustomDesigns: [
      [
        'custom_designs',
      ],
    ],
    kSettingsCustomFields: [
      [
        'custom_fields',
      ],
    ],
    kSettingsGeneratedNumbers: [
      [
        'number_padding',
        'number_counter',
        'recurring_prefix',
        'reset_counter',
        'invoice_number',
        'client_number',
        'credit_number',
        'payment_number',
      ],
    ],
    kSettingsClientPortal: [
      [
        'client_portal',
        'dashboard',
        'tasks',
        'portal_mode',
        'subdomain',
        'domain',
        'client_registration',
        'document_upload',
      ],
      [
        'enable_portal_password',
        'show_accept_invoice_terms',
        'show_accept_quote_terms',
        'require_invoice_signature',
        'require_quote_signature',
      ],
      [
        'messages',
      ],
      [
        'custom_css',
      ],
    ],
    kSettingsEmailSettings: [
      [
        'send_from_gmail',
        'email_design',
        'reply_to_email',
        'reply_to_name',
        'bcc_email',
        'attach_pdf',
        'attach_documents',
        'attach_ubl',
        'email_signature',
      ],
    ],
    kSettingsTemplatesAndReminders: [
      [
        'template',
        'send_reminders',
        'late_fees',
      ]
    ],
    kSettingsGroupSettings: [
      [
        'groups',
      ],
    ],
    kSettingsSubscriptions: [
      [
        'subscriptions',
      ],
    ],
    kSettingsWorkflowSettings: [
      [
        'auto_email_invoice',
        'auto_archive_invoice',
        'lock_invoices',
      ],
      [
        'auto_convert',
      ],
    ],
    kSettingsUserManagement: [
      [
        'users',
      ],
    ]
  };

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return ScrollableListView(
      children: <Widget>[
        for (var section in map.keys)
          for (int i = 0; i < map[section].length; i++)
            for (var field in map[section][i])
              if (localization
                  .lookup(field)
                  .toLowerCase()
                  .contains(filter.toLowerCase()))
                ListTile(
                  title: Text(localization.lookup(field)),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 6, top: 10),
                    child: Icon(getSettingIcon(section), size: 22),
                  ),
                  subtitle: Text(localization.lookup(section)),
                  onTap: () => viewModel.loadSection(context, section, i),
                ),
      ],
    );
  }
}
