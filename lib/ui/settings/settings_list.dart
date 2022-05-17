// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_list_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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
            SettingsListTile(
              section: kSettingsWorkflowSettings,
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
              section: kSettingsClientPortal,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsEmailSettings,
              viewModel: widget.viewModel,
            ),
            SettingsListTile(
              section: kSettingsTemplatesAndReminders,
              viewModel: widget.viewModel,
            ),
            if (showAll)
              SettingsListTile(
                section: kSettingsGroupSettings,
                viewModel: widget.viewModel,
              ),
            if (showAll)
              SettingsListTile(
                section: kSettingsSubscriptions,
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
          dense: isDesktop(context),
          leading: Padding(
            padding: const EdgeInsets.only(left: 6, top: 2),
            child: Icon(icon ?? icon, size: 22),
          ),
          title: Text(
            localization.lookup(section),
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
          ),
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

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.company;

    final map = {
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
          if (company.hasCustomField(CustomFieldType.company1))
            company.getCustomFieldLabel(CustomFieldType.company1),
          if (company.hasCustomField(CustomFieldType.company2))
            company.getCustomFieldLabel(CustomFieldType.company2),
          if (company.hasCustomField(CustomFieldType.company3))
            company.getCustomFieldLabel(CustomFieldType.company3),
          if (company.hasCustomField(CustomFieldType.company4))
            company.getCustomFieldLabel(CustomFieldType.company4)
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
          'use_quote_terms',
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
          'decimal_comma',
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
          'inclusive_taxes',
        ],
      ],
      kSettingsProducts: [
        [
          'show_product_discount',
          'show_product_cost',
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
          'client_portal',
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
          'inclusive_taxes',
        ],
      ],
      kSettingsExpenseCategories: [
        [
          'expense_categories',
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
      kSettingsImportExport: [
        [
          'import',
          'export',
        ],
      ],
      kSettingsDeviceSettings: [
        [
          'long_press_multiselect',
          'biometric_authentication',
          'show_pdf_preview',
          'refresh_data',
        ],
        [
          'dark_mode',
          'custom_colors',
        ],
      ],
      kSettingsAccountManagement: [
        [
          'activate_company',
          'enable_markdown',
          'include_drafts',
          'api_tokens',
          'api_webhooks',
          'purge_data',
          'delete_company',
        ],
        [
          'enabled_modules',
        ],
        [
          'google_analytics',
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
          'portal_mode',
          'subdomain',
          'domain',
          'document_upload',
        ],
        [
          'client_registration',
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
          'from_name',
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
      kSettingsUserManagement: [
        [
          'users',
        ],
      ]
    };

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
