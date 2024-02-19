// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final SettingsListVM viewModel;

  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
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
    else if (settingsUIState.filter != null || settingsUIState.showNewSettings)
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
              color: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.only(left: 19, top: 16, bottom: 16),
              child: Text(
                localization!.basicSettings,
                style: Theme.of(context).textTheme.bodyMedium,
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
              section: kSettingsPaymentSettings,
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
            if (showAll && state.userCompany.isAdmin)
              SettingsListTile(
                section: kSettingsAccountManagement,
                viewModel: widget.viewModel,
              ),
            Container(
              color: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.only(left: 19, top: 16, bottom: 16),
              child: Text(
                localization.advancedSettings,
                style: Theme.of(context).textTheme.bodyMedium,
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
                section: kSettingsBankAccounts,
                viewModel: widget.viewModel,
              ),
            if (showAll)
              SettingsListTile(
                section: kSettingsGroupSettings,
                viewModel: widget.viewModel,
              ),
            if (showAll)
              SettingsListTile(
                section: kSettingsPaymentLinks,
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
            if (showAll) ...[
              SettingsListTile(
                section: kSettingsSchedules,
                viewModel: widget.viewModel,
              ),
              SettingsListTile(
                section: kSettingsUserManagement,
                viewModel: widget.viewModel,
              ),
            ],
          ],
        ),
        if (state.isLoading) LinearProgressIndicator(),
      ],
    );
  }
}

class SettingsListTile extends StatefulWidget {
  const SettingsListTile({
    required this.section,
    required this.viewModel,
  });

  final String section;
  final SettingsListVM viewModel;

  @override
  State<SettingsListTile> createState() => _SettingsListTileState();
}

class _SettingsListTileState extends State<SettingsListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    IconData? icon;
    if (widget.section == kSettingsDeviceSettings) {
      icon = isMobile(context) ? Icons.phone_android : MdiIcons.desktopClassic;
    } else {
      icon = getSettingIcon(widget.section);
    }

    final isSelected =
        widget.viewModel.state.uiState.containsRoute('/${widget.section}') &&
            isDesktop(context);

    final hoverColor = convertHexStringToColor(state.prefState.enableDarkMode
        ? kDefaultDarkSelectedColorMenu
        : kDefaultLightSelectedColorMenu);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        color: Theme.of(context).cardColor,
        child: SelectedIndicator(
          isSelected: isSelected,
          child: ListTile(
            tileColor: _isHovered && !isSelected ? hoverColor : null,
            dense: isDesktop(context),
            leading: Padding(
              padding: const EdgeInsets.only(left: 6, top: 2),
              child: Icon(icon ?? icon, size: 22),
            ),
            title: Text(
              localization.lookup(widget.section),
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
            ),
            onTap: () =>
                widget.viewModel.loadSection(context, widget.section, 0),
          ),
        ),
      ),
    );
  }
}

class SettingsSearch extends StatelessWidget {
  const SettingsSearch({this.filter, this.viewModel});

  final SettingsListVM? viewModel;
  final String? filter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.company;

    final map = {
      kSettingsCompanyDetails: [
        [
          'name',
          'id_number',
          'vat_number',
          'classification#2023-10-17',
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
          'payment_terms',
          'invoice_terms',
          'invoice_footer',
          'quote_terms',
          'quote_footer',
          'credit_terms',
          'credit_footer',
          'use_quote_terms#2022-05-17',
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
      kSettingsPaymentSettings: [
        [
          'company_gateways',
          'auto_bill',
          'auto_bill_on',
          'payment_type',
          'online_payment_email',
          'manual_payment_email',
          'use_available_credits',
          'admin_initiated_payments#2022-06-06',
          'allow_over_payment',
          'allow_under_payment',
          'auto_bill_standard_invoices#2023-01-17',
          'client_initiated_payments#2023-03-20',
          'send_emails_to#2023-11-30',
          'use_available_payments#2024-02-19',
        ]
      ],
      kSettingsTaxSettings: [
        [
          'tax_settings',
          'inclusive_taxes',
          'calculate_taxes#2023-06-11',
        ],
      ],
      kSettingsTaxRates: [
        [
          'tax_rates',
        ],
      ],
      kSettingsProducts: [
        [
          'track_inventory#2022-06-03',
          'stock_notifications#2022-06-03',
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
          'lock_invoiced_tasks#2022-11-30',
          'invoice_task_hours#2023-01-19',
          'allow_billable_task_items#2023-03-22',
          'show_task_item_description#2023-03-22',
          'project_location#2023-06-06',
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
          'convert_currency',
          'notify_vendor_when_paid#2023-01-08',
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
          'stop_on_unpaid',
          'auto_archive_paid_invoices',
          'auto_archive_cancelled_invoices',
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
          'enable_flexible_search#2022-07-05',
          'enable_tooltips#2022-07-05',
          'show_pdf_preview',
          'pdf_preview_location#2022-10-24',
          'refresh_data',
          if (!kIsWeb) 'downloads_folder#2023-10-29'
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
          'include_deleted#2022-10-07',
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
          'matomo_id#2022-12-12',
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
          'logo_size#2023-01-26',
          'show_paid_stamp#2023-01-29',
          'show_shipping_address#2023-01-29',
          'share_invoice_quote_columns#2023-03-20',
          'invoice_embed_documents#2023-10-27',
          'mobile_version#2024-01-29',
          if (supportsDesignTemplates()) ...[
            'delivery_note_design#2023-11-06',
            'statement_design#2023-11-06',
            'payment_receipt_design#2023-11-06',
            'payment_refund_design#2023-11-06',
          ],
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
          'client_document_upload',
          'vendor_document_upload#2022-07-06',
          'accept_purchase_order_number#2023-02-02',
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
          'header',
          'footer',
          'custom_css',
          if (isSelfHosted(context)) 'custom_javascript',
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
          'microsoft',
          'postmark#2023-01-11',
          'mailgun#2023-01-11',
          'email_alignment#2023-01-17',
          'show_email_footer#2023-01-17',
          'enable_e_invoice#2023-06-11,'
        ],
      ],
      kSettingsTemplatesAndReminders: [
        [
          'template',
          'send_reminders',
          'late_fees',
        ]
      ],
      kSettingsBankAccounts: [
        [
          'bank_accounts#2022-09-13',
        ],
      ],
      kSettingsTransactionRules: [
        [
          'transaction_rules#2022-11-21',
        ],
      ],
      kSettingsGroupSettings: [
        [
          'groups',
        ],
      ],
      kSettingsPaymentLinks: [
        [
          'payment_links',
        ],
      ],
      kSettingsSchedules: [
        [
          'schedules#2023-02-15',
        ],
      ],
      kSettingsUserManagement: [
        [
          'users',
        ],
      ]
    };

    if (store.state.settingsUIState.showNewSettings) {
      final sections = <String>[];
      for (var section in map.keys) {
        for (var tab = 0; tab < map[section]!.length; tab++) {
          final fields = map[section]![tab];
          for (var field in fields) {
            final List<String> parts = field.split('#');
            final dateAdded =
                parts.length == 1 ? '' : convertSqlDateToDateTime(parts[1]);
            sections.add('$dateAdded#${parts[0]}#$section#$tab');
          }
        }
      }

      sections.sort((a, b) {
        if (a.startsWith('#') && b.startsWith('#')) {
          return a.compareTo(b);
        } else if (a.startsWith('#')) {
          return 1;
        } else if (b.startsWith('#')) {
          return -1;
        }

        return b.compareTo(a);
      });

      return ScrollableListView(children: [
        for (var parts
            in sections.map((section) => section.split('#').toList()))
          if ((filter ?? '').trim().isEmpty ||
              localization
                  .lookup(parts[1])
                  .toLowerCase()
                  .contains(filter!.toLowerCase()))
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(localization.lookup(parts[1])),
                        Text(
                          localization.lookup(parts[2]),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  /*
                  SizedBox(width: 8),
                  if (parts[0].isNotEmpty)
                    Flexible(
                        child: Text(timeago.format(DateTime.parse(parts[0]),
                            locale:
                                localeSelector(store.state, twoLetter: true) +
                                    '_short'))),
                                    */
                ],
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 6, top: 10),
                child: Icon(getSettingIcon(parts[2]), size: 22),
              ),
              onTap: () =>
                  viewModel!.loadSection(context, parts[2], parseInt(parts[3])),
            ),
      ]);
    } else {
      return ScrollableListView(
        children: [
          for (var section in map.keys)
            for (int i = 0; i < map[section]!.length; i++)
              for (var field in map[section]![i])
                if (localization
                    .lookup(field.split('#')[0])
                    .toLowerCase()
                    .contains(filter!.toLowerCase()))
                  ListTile(
                    title: Text(localization.lookup(field.split('#')[0])),
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 6, top: 10),
                      child: Icon(getSettingIcon(section), size: 22),
                    ),
                    subtitle: Text(localization.lookup(section)),
                    onTap: () => viewModel!.loadSection(context, section, i),
                  ),
        ],
      );
    }
  }
}
