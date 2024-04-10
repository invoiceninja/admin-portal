// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/account_model.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/data/models/system_log_model.dart';
import 'package:invoiceninja_flutter/data/models/tax_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'company_model.g.dart';

class CompanyFields {
  static const String name = 'name';
  static const String email = 'email';
  static const String address1 = 'address1';
  static const String address2 = 'address2';
  static const String city = 'city';
  static const String postalCode = 'postal_code';
  static const String country = 'country';
  static const String vatNumber = 'vat_number';
  static const String idNumber = 'id_number';
  static const String state = 'state';
  static const String phone = 'phone';
  static const String website = 'website';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
  static const String custom3 = 'custom3';
  static const String custom4 = 'custom4';
  static const String cityStatePostal = 'city_state_postal';
  static const String postalCityState = 'postal_city_state';
  static const String postalCity = 'postal_city';
}

abstract class CompanyEntity extends Object
    with BaseEntity
    implements Built<CompanyEntity, CompanyEntityBuilder> {
  factory CompanyEntity() {
    return _$CompanyEntity._(
      entityType: EntityType.company,
      id: '',
      updatedAt: 0,
      archivedAt: 0,
      assignedUserId: '',
      createdAt: 0,
      createdUserId: '',
      isChanged: false,
      isDeleted: false,
      companyKey: '',
      settings: SettingsEntity(),
      sizeId: '',
      industryId: '',
      enabledModules: 0,
      firstMonthOfYear: '0',
      firstDayOfWeek: '0',
      subdomain: '',
      portalDomain: '',
      portalMode: kClientPortalModeSubdomain,
      updateProducts: true,
      fillProducts: true,
      showProductDetails: true,
      enableProductCost: false,
      enableProductQuantity: true,
      enableProductDiscount: false,
      defaultQuantity: true,
      defaultTaskIsDateBased: false,
      slackWebhookUrl: '',
      googleAnalyticsKey: '',
      matomoUrl: '',
      matomoId: '',
      clientCanRegister: true,
      autoStartTasks: false,
      invoiceTaskTimelog: true,
      invoiceTaskDatelog: true,
      invoiceTaskProject: false,
      invoiceTaskHours: false,
      invoiceTaskItemDescription: true,
      invoiceTaskProjectHeader: true,
      isLarge: false,
      enableShopApi: false,
      convertProductExchangeRate: false,
      convertRateToClient: true,
      enableCustomSurchargeTaxes1: false,
      enableCustomSurchargeTaxes2: false,
      enableCustomSurchargeTaxes3: false,
      enableCustomSurchargeTaxes4: false,
      numberOfInvoiceTaxRates: 0,
      numberOfItemTaxRates: 0,
      numberOfExpenseTaxRates: 0,
      invoiceExpenseDocuments: false,
      markExpensesInvoiceable: false,
      markExpensesPaid: false,
      showTasksTable: false,
      showTaskEndDate: false,
      invoiceTaskDocuments: false,
      isDisabled: false,
      calculateExpenseTaxByAmount: false,
      expenseInclusiveTaxes: false,
      sessionTimeout: 0,
      passwordTimeout: 30 * 60 * 1000,
      oauthPasswordRequired: false,
      markdownEnabled: true,
      markdownEmailEnabled: true,
      useCommaAsDecimalPlace: false,
      reportIncludeDrafts: false,
      reportIncludeDeleted: false,
      stopOnUnpaidRecurring: false,
      useQuoteTermsOnConversion: false,
      enableApplyingPayments: false,
      trackInventory: false,
      stockNotificationThreshold: 0,
      stockNotification: true,
      invoiceTaskLock: false,
      convertPaymentCurrency: false,
      convertExpenseCurrency: false,
      notifyVendorWhenPaid: false,
      calculateTaxes: false,
      hasEInvoiceCertificate: false,
      hasEInvoiceCertificatePassphrase: false,
      eInvoiceCertificatePassphrase: '',
      smtpHost: '',
      smtpPort: 587,
      smtpEncryption: SMTP_ENCRYPTION_TLS,
      smtpUsername: '',
      smtpPassword: '',
      smtpLocalDomain: '',
      smtpVerifyPeer: true,
      taxData: TaxDataEntity(),
      taxConfig: TaxConfigEntity(),
      groups: BuiltList<GroupEntity>(),
      taxRates: BuiltList<TaxRateEntity>(),
      taskStatuses: BuiltList<TaskStatusEntity>(),
      taskStatusMap: BuiltMap<String, TaskStatusEntity>(),
      companyGateways: BuiltList<CompanyGatewayEntity>(),
      expenseCategories: BuiltList<ExpenseCategoryEntity>(),
      users: BuiltList<UserEntity>(),
      customFields: BuiltMap<String, String>(),
      activities: BuiltList<ActivityEntity>(),
      clients: BuiltList<ClientEntity>(),
      products: BuiltList<ProductEntity>(),
      invoices: BuiltList<InvoiceEntity>(),
      recurringInvoices: BuiltList<InvoiceEntity>(),
      recurringExpenses: BuiltList<ExpenseEntity>(),
      payments: BuiltList<PaymentEntity>(),
      quotes: BuiltList<InvoiceEntity>(),
      credits: BuiltList<InvoiceEntity>(),
      tasks: BuiltList<TaskEntity>(),
      expenses: BuiltList<ExpenseEntity>(),
      projects: BuiltList<ProjectEntity>(),
      vendors: BuiltList<VendorEntity>(),
      designs: BuiltList<DesignEntity>(),
      paymentTerms: BuiltList<PaymentTermEntity>(),
      tokens: BuiltList<TokenEntity>(),
      webhooks: BuiltList<WebhookEntity>(),
      documents: BuiltList<DocumentEntity>(),
      subscriptions: BuiltList<SubscriptionEntity>(),
      systemLogs: BuiltList<SystemLogEntity>(),
      clientRegistrationFields: BuiltList<RegistrationFieldEntity>(),
      purchaseOrders: BuiltList<InvoiceEntity>(),
      bankAccounts: BuiltList<BankAccountEntity>(),
      transactions: BuiltList<TransactionEntity>(),
      transactionRules: BuiltList<TransactionRuleEntity>(),
      schedules: BuiltList<ScheduleEntity>(),
    );
  }

  CompanyEntity._();

  static const USE_ALWAYS = 'always';
  static const USE_OPTION = 'option';
  static const USE_OFF = 'off';

  static const SMTP_ENCRYPTION_TLS = 'TLS';
  static const SMTP_ENCRYPTION_STARTTLS = 'STARTTLS';

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'custom_surcharge_taxes1')
  bool get enableCustomSurchargeTaxes1;

  @BuiltValueField(wireName: 'custom_surcharge_taxes2')
  bool get enableCustomSurchargeTaxes2;

  @BuiltValueField(wireName: 'custom_surcharge_taxes3')
  bool get enableCustomSurchargeTaxes3;

  @BuiltValueField(wireName: 'custom_surcharge_taxes4')
  bool get enableCustomSurchargeTaxes4;

  @BuiltValueField(wireName: 'size_id')
  String get sizeId;

  @BuiltValueField(wireName: 'industry_id')
  String get industryId;

  @BuiltValueField(wireName: 'subdomain')
  String get subdomain;

  @BuiltValueField(wireName: 'portal_mode')
  String get portalMode;

  @BuiltValueField(wireName: 'portal_domain')
  String get portalDomain;

  @BuiltValueField(wireName: 'update_products')
  bool get updateProducts;

  @BuiltValueField(wireName: 'convert_products')
  bool get convertProductExchangeRate;

  @BuiltValueField(wireName: 'convert_rate_to_client')
  bool get convertRateToClient;

  @BuiltValueField(wireName: 'fill_products')
  bool get fillProducts;

  @BuiltValueField(wireName: 'enable_product_cost')
  bool get enableProductCost;

  @BuiltValueField(wireName: 'enable_product_quantity')
  bool get enableProductQuantity;

  @BuiltValueField(wireName: 'enable_product_discount')
  bool get enableProductDiscount;

  @BuiltValueField(wireName: 'default_task_is_date_based')
  bool get defaultTaskIsDateBased;

  @BuiltValueField(wireName: 'default_quantity')
  bool get defaultQuantity;

  @BuiltValueField(wireName: 'show_product_details')
  bool get showProductDetails;

  @BuiltValueField(wireName: 'client_can_register')
  bool get clientCanRegister;

  @BuiltValueField(wireName: 'is_large')
  bool get isLarge;

  @BuiltValueField(wireName: 'is_disabled')
  bool get isDisabled;

  @BuiltValueField(wireName: 'enable_shop_api')
  bool get enableShopApi;

  @BuiltValueField(wireName: 'company_key')
  String get companyKey;

  @BuiltValueField(wireName: 'first_day_of_week')
  String get firstDayOfWeek;

  @BuiltValueField(wireName: 'first_month_of_year')
  String get firstMonthOfYear;

  @BuiltValueField(wireName: 'enabled_tax_rates')
  int get numberOfInvoiceTaxRates;

  @BuiltValueField(wireName: 'enabled_item_tax_rates')
  int get numberOfItemTaxRates;

  @BuiltValueField(wireName: 'enabled_expense_tax_rates')
  int get numberOfExpenseTaxRates;

  @BuiltValueField(wireName: 'expense_inclusive_taxes')
  bool get expenseInclusiveTaxes;

  @BuiltValueField(wireName: 'session_timeout')
  int get sessionTimeout;

  @BuiltValueField(wireName: 'default_password_timeout')
  int get passwordTimeout;

  @BuiltValueField(wireName: 'oauth_password_required')
  bool get oauthPasswordRequired;

  @BuiltValueField(wireName: 'markdown_enabled')
  bool get markdownEnabled;

  @BuiltValueField(wireName: 'markdown_email_enabled')
  bool get markdownEmailEnabled;

  @BuiltValueField(wireName: 'use_comma_as_decimal_place')
  bool get useCommaAsDecimalPlace;

  @BuiltValueField(wireName: 'report_include_drafts')
  bool get reportIncludeDrafts;

  @BuiltValueField(wireName: 'report_include_deleted')
  bool get reportIncludeDeleted;

  @BuiltValueField(wireName: 'use_quote_terms_on_conversion')
  bool get useQuoteTermsOnConversion;

  @BuiltValueField(wireName: 'enable_applying_payments')
  bool get enableApplyingPayments;

  @BuiltValueField(wireName: 'track_inventory')
  bool get trackInventory;

  @BuiltValueField(wireName: 'inventory_notification_threshold')
  int get stockNotificationThreshold;

  @BuiltValueField(wireName: 'stock_notification')
  bool get stockNotification;

  @BuiltValueField(wireName: 'invoice_task_lock')
  bool get invoiceTaskLock;

  @BuiltValueField(wireName: 'convert_payment_currency')
  bool get convertPaymentCurrency;

  @BuiltValueField(wireName: 'convert_expense_currency')
  bool get convertExpenseCurrency;

  @BuiltValueField(wireName: 'notify_vendor_when_paid')
  bool get notifyVendorWhenPaid;

  @BuiltValueField(wireName: 'smtp_host')
  String get smtpHost;

  @BuiltValueField(wireName: 'smtp_port')
  int get smtpPort;

  @BuiltValueField(wireName: 'smtp_encryption')
  String get smtpEncryption;

  @BuiltValueField(wireName: 'smtp_username')
  String get smtpUsername;

  @BuiltValueField(wireName: 'smtp_password')
  String get smtpPassword;

  @BuiltValueField(wireName: 'smtp_local_domain')
  String get smtpLocalDomain;

  @BuiltValueField(wireName: 'smtp_verify_peer')
  bool get smtpVerifyPeer;

  BuiltList<GroupEntity> get groups;

  BuiltList<ActivityEntity> get activities;

  @BuiltValueField(wireName: 'tax_rates')
  BuiltList<TaxRateEntity> get taxRates;

  @BuiltValueField(wireName: 'task_statuses')
  BuiltList<TaskStatusEntity> get taskStatuses;

  BuiltMap<String, TaskStatusEntity> get taskStatusMap;

  @BuiltValueField(wireName: 'company_gateways')
  BuiltList<CompanyGatewayEntity> get companyGateways;

  @BuiltValueField(wireName: 'expense_categories')
  BuiltList<ExpenseCategoryEntity> get expenseCategories;

  BuiltList<UserEntity> get users;

  BuiltList<ClientEntity> get clients;

  BuiltList<ProductEntity> get products;

  BuiltList<InvoiceEntity> get invoices;

  @BuiltValueField(wireName: 'recurring_invoices')
  BuiltList<InvoiceEntity> get recurringInvoices;

  @BuiltValueField(wireName: 'recurring_expenses')
  BuiltList<ExpenseEntity> get recurringExpenses;

  BuiltList<PaymentEntity> get payments;

  BuiltList<InvoiceEntity> get quotes;

  BuiltList<InvoiceEntity> get credits;

  @BuiltValueField(wireName: 'purchase_orders')
  BuiltList<InvoiceEntity> get purchaseOrders;

  @BuiltValueField(wireName: 'bank_integrations')
  BuiltList<BankAccountEntity> get bankAccounts;

  @BuiltValueField(wireName: 'bank_transactions')
  BuiltList<TransactionEntity> get transactions;

  @BuiltValueField(wireName: 'bank_transaction_rules')
  BuiltList<TransactionRuleEntity> get transactionRules;

  BuiltList<TaskEntity> get tasks;

  BuiltList<ProjectEntity> get projects;

  BuiltList<ExpenseEntity> get expenses;

  BuiltList<VendorEntity> get vendors;

  BuiltList<DesignEntity> get designs;

  BuiltList<DocumentEntity> get documents;

  @BuiltValueField(wireName: 'task_schedulers')
  BuiltList<ScheduleEntity> get schedules;

  @BuiltValueField(wireName: 'tokens_hashed')
  BuiltList<TokenEntity> get tokens;

  BuiltList<WebhookEntity> get webhooks;

  BuiltList<SubscriptionEntity> get subscriptions;

  @BuiltValueField(wireName: 'payment_terms')
  BuiltList<PaymentTermEntity> get paymentTerms;

  @BuiltValueField(wireName: 'system_logs')
  BuiltList<SystemLogEntity> get systemLogs;

  @BuiltValueField(wireName: 'client_registration_fields')
  BuiltList<RegistrationFieldEntity> get clientRegistrationFields;

  @BuiltValueField(wireName: 'custom_fields')
  BuiltMap<String, String> get customFields;

  @BuiltValueField(wireName: 'slack_webhook_url')
  String get slackWebhookUrl;

  @BuiltValueField(wireName: 'google_analytics_key')
  String get googleAnalyticsKey;

  @BuiltValueField(wireName: 'matomo_url')
  String get matomoUrl;

  @BuiltValueField(wireName: 'matomo_id')
  String get matomoId;

  @BuiltValueField(wireName: 'mark_expenses_invoiceable')
  bool get markExpensesInvoiceable;

  @BuiltValueField(wireName: 'mark_expenses_paid')
  bool get markExpensesPaid;

  @BuiltValueField(wireName: 'invoice_expense_documents')
  bool get invoiceExpenseDocuments;

  @BuiltValueField(wireName: 'invoice_task_documents')
  bool get invoiceTaskDocuments;

  @BuiltValueField(wireName: 'invoice_task_timelog')
  bool get invoiceTaskTimelog;

  @BuiltValueField(wireName: 'invoice_task_datelog')
  bool get invoiceTaskDatelog;

  @BuiltValueField(wireName: 'invoice_task_project')
  bool get invoiceTaskProject;

  @BuiltValueField(wireName: 'invoice_task_hours')
  bool get invoiceTaskHours;

  @BuiltValueField(wireName: 'invoice_task_item_description')
  bool get invoiceTaskItemDescription;

  @BuiltValueField(wireName: 'invoice_task_project_header')
  bool get invoiceTaskProjectHeader;

  @BuiltValueField(wireName: 'auto_start_tasks')
  bool get autoStartTasks;

  @BuiltValueField(wireName: 'show_tasks_table')
  bool get showTasksTable;

  @BuiltValueField(wireName: 'show_task_end_date')
  bool get showTaskEndDate;

  SettingsEntity get settings;

  @BuiltValueField(wireName: 'enabled_modules')
  int get enabledModules;

  @BuiltValueField(wireName: 'calculate_expense_tax_by_amount')
  bool get calculateExpenseTaxByAmount;

  @BuiltValueField(wireName: 'stop_on_unpaid_recurring')
  bool get stopOnUnpaidRecurring;

  @BuiltValueField(wireName: 'calculate_taxes')
  bool get calculateTaxes;

  @BuiltValueField(wireName: 'tax_data')
  TaxConfigEntity get taxConfig;

  @BuiltValueField(wireName: 'origin_tax_data')
  TaxDataEntity get taxData;

  @BuiltValueField(wireName: 'has_e_invoice_certificate')
  bool get hasEInvoiceCertificate;

  @BuiltValueField(wireName: 'has_e_invoice_certificate_passphrase')
  bool get hasEInvoiceCertificatePassphrase;

  @BuiltValueField(wireName: 'e_invoice_certificate_passphrase')
  String get eInvoiceCertificatePassphrase;

  String get displayName => settings.name ?? '';

  @override
  bool get isActive => true;

  @override
  bool matchesFilter(String? filter) {
    for (final user in users) {
      if (user.matchesFilter(filter)) {
        return true;
      }
    }
    for (final project in projects) {
      if (project.matchesFilter(filter)) {
        return true;
      }
    }
    for (final product in products) {
      if (product.matchesFilter(filter)) {
        return true;
      }
    }

    return matchesStrings(
      haystacks: [subdomain, displayName, companyKey],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    for (final user in users) {
      final value = user.matchesFilterValue(filter);
      if (value != null) {
        return value;
      }
    }
    for (final project in projects) {
      final value = project.matchesFilterValue(filter);
      if (value != null) {
        return value;
      }
    }
    for (final product in products) {
      final value = product.matchesFilterValue(filter);
      if (value != null) {
        return value;
      }
    }

    return matchesStringsValue(
      haystacks: [subdomain, displayName, companyKey],
      needle: filter,
    );
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType? get listDisplayAmountType => null;

  @override
  String get listDisplayName => settings.name ?? '';

  bool hasCustomField(String field) => getCustomFieldLabel(field).isNotEmpty;

  bool get enableFirstInvoiceTaxRate => numberOfInvoiceTaxRates >= 1;

  bool get enableSecondInvoiceTaxRate => numberOfInvoiceTaxRates >= 2;

  bool get enableThirdInvoiceTaxRate => numberOfInvoiceTaxRates >= 3;

  bool get enableFirstItemTaxRate => numberOfItemTaxRates >= 1;

  bool get enableSecondItemTaxRate => numberOfItemTaxRates >= 2;

  bool get enableThirdItemTaxRate => numberOfItemTaxRates >= 3;

  bool get enableFirstExpenseTaxRate => numberOfExpenseTaxRates >= 1;

  bool get enableSecondExpenseTaxRate => numberOfExpenseTaxRates >= 2;

  bool get enableThirdExpenseTaxRate => numberOfExpenseTaxRates >= 3;

  bool get hasInvoiceTaxes => numberOfInvoiceTaxRates > 0;

  bool get hasItemTaxes => numberOfItemTaxRates > 0;

  bool get hasTaxes => hasInvoiceTaxes || hasItemTaxes;

  bool get isSmall => !isLarge;

  bool get hasName => (settings.name ?? '').isNotEmpty;

  bool get hasCustomSurcharge =>
      hasCustomField(CustomFieldType.surcharge1) ||
      hasCustomField(CustomFieldType.surcharge2) ||
      hasCustomField(CustomFieldType.surcharge3) ||
      hasCustomField(CustomFieldType.surcharge4);

  bool hasCustomProductField(String label) {
    return [
      getCustomFieldLabel(CustomFieldType.product1).toLowerCase(),
      getCustomFieldLabel(CustomFieldType.product2).toLowerCase(),
      getCustomFieldLabel(CustomFieldType.product3).toLowerCase(),
      getCustomFieldLabel(CustomFieldType.product4).toLowerCase(),
    ].contains(label.toLowerCase());
  }

  String getCustomFieldLabel(String field) {
    field = field.replaceFirst('\$', '');

    // Convert '$client.custom1' to 'client1'
    if (field.contains('.custom')) {
      field = field.replaceFirst('.custom', '');
    }

    // Convert '$product.product1' to 'product1'
    if (field.contains('.product')) {
      field = field.replaceFirst('.product', '');
    } else if (field.contains('.task')) {
      field = field.replaceFirst('.task', '');
    }

    // Conver quote/credit to invoice
    if (field.contains('quote')) {
      field = field.replaceFirst('quote', 'invoice');
    } else if (field.contains('credit')) {
      field = field.replaceFirst('credit', 'invoice');
    } else if (field.contains('recurring_invoice')) {
      field = field.replaceFirst('recurring_invoice', 'invoice');
    } else if (field.contains('purchase_order')) {
      field = field.replaceFirst('purchase_order', 'invoice');
    }

    if (field.contains('recurring_expense')) {
      field = field.replaceFirst('recurring_expense', 'expense');
    }

    if (customFields.containsKey(field)) {
      return customFields[field]!.split('|').first;
    } else {
      return '';
    }
  }

  String getCustomFieldType(String? field) {
    if ((customFields[field] ?? '').contains('|')) {
      final value = customFields[field]!.split('|').last;
      if ([kFieldTypeSingleLineText, kFieldTypeDate, kFieldTypeSwitch]
          .contains(value)) {
        return value;
      } else {
        return kFieldTypeDropdown;
      }
    } else {
      return kFieldTypeMultiLineText;
    }
  }

  String formatCustomFieldValue(String field, String value) {
    final context = navigatorKey.currentContext!;
    final type = getCustomFieldType(field);
    final localization = AppLocalization.of(context);

    if (type == kFieldTypeDate) {
      value = formatDate(value, context);
    } else if (type == kFieldTypeSwitch) {
      value = value == kSwitchValueYes ? localization!.yes : localization!.no;
    }

    return getCustomFieldLabel(field) + ': $value';
  }

  List<String> getCustomFieldValues(String field, {bool excludeBlank = false}) {
    final values = customFields[field];

    if (values == null || !values.contains('|')) {
      return [];
    } else {
      final parts = values.split('|');
      final data = parts.last.split(',');

      if (parts.length == 2) {
        if ([kFieldTypeDate, kFieldTypeSwitch, kFieldTypeSingleLineText]
            .contains(parts[1])) {
          return [];
        }
      }

      if (excludeBlank) {
        return data.where((data) => data.isNotEmpty).toList();
      } else {
        return data;
      }
    }
  }

  // TODO make sure to clear everything
  CompanyEntity get coreCompany => rebuild(
        (b) => b
          ..clients.clear()
          ..products.clear()
          ..invoices.clear()
          ..payments.clear()
          ..quotes.clear()
          ..purchaseOrders.clear()
          ..bankAccounts.clear()
          ..transactions.clear()
          ..transactionRules.clear()
          ..credits.clear()
          ..tasks.clear()
          ..projects.clear()
          ..vendors.clear()
          ..expenses.clear()
          ..webhooks.clear()
          ..designs.clear()
          ..companyGateways.clear(),
      );

  bool isModuleEnabled(EntityType? entityType) {
    if ((entityType == EntityType.invoice ||
            entityType == EntityType.payment) &&
        enabledModules & kModuleInvoices == 0) {
      return false;
    } else if (entityType == EntityType.credit &&
        enabledModules & kModuleCredits == 0) {
      return false;
    } else if (entityType == EntityType.quote &&
        enabledModules & kModuleQuotes == 0) {
      return false;
    } else if (entityType == EntityType.task &&
        enabledModules & kModuleTasks == 0) {
      return false;
    } else if (entityType == EntityType.project &&
        enabledModules & kModuleProjects == 0) {
      return false;
    } else if (entityType == EntityType.vendor &&
        enabledModules & kModuleVendors == 0) {
      return false;
    } else if (entityType == EntityType.expense &&
        enabledModules & kModuleExpenses == 0) {
      return false;
    } else if (entityType == EntityType.recurringInvoice &&
        enabledModules & kModuleRecurringInvoices == 0) {
      return false;
    } else if (entityType == EntityType.recurringExpense &&
        enabledModules & kModuleRecurringExpenses == 0) {
      return false;
    } else if (entityType == EntityType.purchaseOrder &&
        enabledModules & kModulePurchaseOrders == 0) {
      return false;
    } else if (entityType == EntityType.transaction &&
        enabledModules & kModuleTransactions == 0) {
      return false;
    } else if (entityType == EntityType.document &&
        enabledModules & kModuleDocuments == 0) {
      return false;
    }

    return true;
  }

  int get daysActive =>
      DateTime.now().difference(convertTimestampToDate(createdAt)).inDays;

  String get currencyId => settings.currencyId ?? kDefaultCurrencyId;

  String get languageId => settings.languageId ?? kDefaultLanguageId;

  bool get supportsQrIban => settings.countryId == kCountrySwitzerland;

  // ignore: unused_element
  static void _initializeBuilder(CompanyEntityBuilder builder) => builder
    ..entityType = EntityType.company
    ..calculateExpenseTaxByAmount = false
    ..enableProductDiscount = false
    ..defaultTaskIsDateBased = false
    ..sessionTimeout = 0
    ..passwordTimeout = 30 * 60 * 1000
    ..oauthPasswordRequired = false
    ..invoiceTaskDatelog = true
    ..showTaskEndDate = false
    ..markdownEnabled = true
    ..markdownEmailEnabled = true
    ..useCommaAsDecimalPlace = false
    ..useQuoteTermsOnConversion = false
    ..enableApplyingPayments = false
    ..trackInventory = false
    ..stockNotificationThreshold = 0
    ..stockNotification = true
    ..reportIncludeDrafts = false
    ..reportIncludeDeleted = false
    ..convertRateToClient = true
    ..stopOnUnpaidRecurring = false
    ..numberOfExpenseTaxRates = 0
    ..invoiceTaskProject = false
    ..invoiceTaskHours = false
    ..invoiceTaskLock = false
    ..invoiceTaskItemDescription = true
    ..invoiceTaskProjectHeader = true
    ..matomoUrl = ''
    ..matomoId = ''
    ..convertPaymentCurrency = false
    ..convertExpenseCurrency = false
    ..notifyVendorWhenPaid = false
    ..calculateTaxes = false
    ..hasEInvoiceCertificate = false
    ..hasEInvoiceCertificatePassphrase = false
    ..eInvoiceCertificatePassphrase = ''
    ..enableCustomSurchargeTaxes1 = false
    ..enableCustomSurchargeTaxes2 = false
    ..enableCustomSurchargeTaxes3 = false
    ..enableCustomSurchargeTaxes4 = false
    ..sizeId = ''
    ..industryId = ''
    ..subdomain = ''
    ..portalMode = ''
    ..portalDomain = ''
    ..updateProducts = false
    ..convertProductExchangeRate = false
    ..fillProducts = false
    ..enableProductCost = false
    ..enableProductQuantity = true
    ..defaultQuantity = true
    ..showProductDetails = true
    ..clientCanRegister = false
    ..isLarge = false
    ..isDisabled = false
    ..enableShopApi = false
    ..companyKey = ''
    ..firstDayOfWeek = ''
    ..firstMonthOfYear = ''
    ..numberOfInvoiceTaxRates = 0
    ..numberOfItemTaxRates = 0
    ..expenseInclusiveTaxes = false
    ..slackWebhookUrl = ''
    ..googleAnalyticsKey = ''
    ..markExpensesInvoiceable = false
    ..markExpensesPaid = false
    ..invoiceExpenseDocuments = false
    ..invoiceTaskDocuments = false
    ..invoiceTaskTimelog = false
    ..autoStartTasks = false
    ..showTasksTable = false
    ..enabledModules = 0
    ..createdAt = 0
    ..updatedAt = 0
    ..archivedAt = 0
    ..id = ''
    ..smtpHost = ''
    ..smtpPort = 587
    ..smtpEncryption = SMTP_ENCRYPTION_TLS
    ..smtpUsername = ''
    ..smtpPassword = ''
    ..smtpLocalDomain = ''
    ..smtpVerifyPeer = true
    ..taxConfig.replace(TaxConfigEntity())
    ..taxData.replace(TaxDataEntity())
    ..systemLogs.replace(BuiltList<SystemLogEntity>())
    ..subscriptions.replace(BuiltList<SubscriptionEntity>())
    ..recurringExpenses.replace(BuiltList<ExpenseEntity>())
    ..clientRegistrationFields.replace(BuiltList<RegistrationFieldEntity>())
    ..purchaseOrders.replace(BuiltList<InvoiceEntity>())
    ..bankAccounts.replace(BuiltList<BankAccountEntity>())
    ..transactions.replace(BuiltList<TransactionEntity>())
    ..transactionRules.replace(BuiltList<TransactionRuleEntity>())
    ..schedules.replace(BuiltList<ScheduleEntity>());

  static Serializer<CompanyEntity> get serializer => _$companyEntitySerializer;
}

abstract class GatewayEntity extends Object
    with SelectableEntity
    implements Built<GatewayEntity, GatewayEntityBuilder> {
  factory GatewayEntity() {
    return _$GatewayEntity._(
      id: BaseEntity.nextId,
      name: '',
      sortOrder: 0,
      fields: '',
      defaultGatewayTypeId: kGatewayTypeCreditCard,
      isOffsite: false,
      isVisible: false,
      options: BuiltMap<String, GatewayOptionsEntity>(),
      siteUrl: '',
    );
  }

  GatewayEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  @BuiltValueField(wireName: 'key')
  String get id;

  String get name;

  @BuiltValueField(wireName: 'is_offsite')
  bool get isOffsite;

  @BuiltValueField(wireName: 'visible')
  bool get isVisible;

  @BuiltValueField(wireName: 'sort_order')
  int get sortOrder;

  @BuiltValueField(wireName: 'default_gateway_type_id')
  String get defaultGatewayTypeId;

  @BuiltValueField(wireName: 'site_url')
  String get siteUrl;

  @BuiltValueField(wireName: 'options')
  BuiltMap<String, GatewayOptionsEntity> get options;

  String get fields;

  bool get supportsTokenBilling => options.keys
      .where((typeId) => options[typeId]!.supportTokenBilling)
      .isNotEmpty;

  bool supportsRefunds(String gatewayTypeId) =>
      options[gatewayTypeId]?.supportRefunds ?? false;

  Map<String, dynamic>? get parsedFields =>
      fields.isEmpty ? <String, dynamic>{} : jsonDecode(fields);

  int compareTo(GatewayEntity gateway, String sortField, bool sortAscending) {
    int response = 0;
    final GatewayEntity gatewayA = sortAscending ? this : gateway;
    final GatewayEntity gatewayB = sortAscending ? gateway : this;

    switch (sortField) {
      case CreditFields.amount:
        response = gatewayA.name.compareTo(gatewayB.name);
        break;
      default:
        print('## ERROR: sort by gateway.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String? filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    }

    if ('autobill'.contains(filter) &&
        options.values
            .where((option) => option.supportTokenBilling)
            .isNotEmpty) {
      return true;
    }

    final gatewayIds = options.keys.toList();
    final localization = AppLocalization.of(navigatorKey.currentContext!);

    for (var i = 0; i < gatewayIds.length; i++) {
      final gatewayTypeId = gatewayIds[i];
      final gatewayType = localization!.lookup(kGatewayTypes[gatewayTypeId]);

      if (gatewayType.toLowerCase().contains(filter)) {
        return true;
      }
    }

    return false;
  }

  @override
  String? matchesFilterValue(String? filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    if ('autobill'.contains(filter) &&
        options.values
            .where((option) => option.supportTokenBilling)
            .isNotEmpty) {
      return 'Auto-Bill';
    }

    final gatewayIds = options.keys.toList();
    final localization = AppLocalization.of(navigatorKey.currentContext!);

    for (var i = 0; i < gatewayIds.length; i++) {
      final gatewayTypeId = gatewayIds[i];
      final gatewayType = localization!.lookup(kGatewayTypes[gatewayTypeId]);

      if (gatewayType.toLowerCase().contains(filter)) {
        return gatewayType;
      }
    }

    return null;
  }

  @override
  String get listDisplayName => name;

  @override
  double? get listDisplayAmount => null;

  static String? getClientUrl({String? gatewayId, String? customerReference}) {
    switch (gatewayId) {
      case kGatewayStripe:
      case kGatewayStripeConnect:
        return 'https://dashboard.stripe.com/customers/$customerReference';
      default:
        return null;
    }
  }

  static String? getPaymentUrl(
      {String? gatewayId, String? transactionReference}) {
    switch (gatewayId) {
      case kGatewayStripe:
      case kGatewayStripeConnect:
        if (transactionReference!.startsWith('src'))
          return 'https://dashboard.stripe.com/sources/$transactionReference';
        else
          return 'https://dashboard.stripe.com/payments/$transactionReference';
      default:
        return null;
    }
  }

  List<String> supportedEvents() {
    final events = <String>[];

    options.forEach((key, option) {
      events.addAll((option.webhooks ?? <String>[]).toList());
    });

    return events.toSet().toList();
  }

  @override
  FormatNumberType? get listDisplayAmountType => null;

  // ignore: unused_element
  static void _initializeBuilder(GatewayEntityBuilder builder) =>
      builder..siteUrl = '';

  static Serializer<GatewayEntity> get serializer => _$gatewayEntitySerializer;
}

abstract class GatewayOptionsEntity
    implements Built<GatewayOptionsEntity, GatewayOptionsEntityBuilder> {
  factory GatewayOptionsEntity() {
    return _$GatewayOptionsEntity._(
      supportRefunds: false,
      supportTokenBilling: false,
    );
  }

  GatewayOptionsEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'refund')
  bool get supportRefunds;

  @BuiltValueField(wireName: 'token_billing')
  bool get supportTokenBilling;

  BuiltList<String>? get webhooks;

  static Serializer<GatewayOptionsEntity> get serializer =>
      _$gatewayOptionsEntitySerializer;
}

abstract class UserCompanyEntity
    implements Built<UserCompanyEntity, UserCompanyEntityBuilder> {
  factory UserCompanyEntity(bool reportErrors) {
    return _$UserCompanyEntity._(
      isAdmin: false,
      isOwner: false,
      permissions: '',
      ninjaPortalUrl: '',
      permissionsUpdatedAt: 0,
      settings: UserSettingsEntity(),
      company: CompanyEntity(),
      user: UserEntity(),
      token: TokenEntity(),
      account: AccountEntity(reportErrors),
      notifications: BuiltMap<String, BuiltList<String>>().rebuild((b) => b
        ..[kNotificationChannelEmail] =
            BuiltList<String>(<String>[kNotificationsAll])),
    );
  }

  UserCompanyEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'is_admin')
  bool get isAdmin;

  @BuiltValueField(wireName: 'is_owner')
  bool get isOwner;

  @BuiltValueField(wireName: 'permissions_updated_at')
  int get permissionsUpdatedAt;

  String get permissions;

  BuiltMap<String, BuiltList<String>> get notifications;

  CompanyEntity get company;

  UserEntity get user;

  TokenEntity get token;

  AccountEntity get account;

  UserSettingsEntity get settings;

  @BuiltValueField(wireName: 'ninja_portal_url')
  String get ninjaPortalUrl;

  bool can(UserPermission permission, EntityType? entityType) {
    if (entityType == null) {
      return false;
    }

    if (!company.isModuleEnabled(entityType)) {
      return false;
    }

    if (Config.DEMO_MODE) {
      return true;
    }

    if (isAdmin) {
      return true;
    }

    return permissions.contains('${permission}_all') ||
        permissions.contains('${permission}_${entityType.snakeCase}');
  }

  bool receivesAllNotifications(String channel) =>
      notifications.containsKey(channel) &&
      notifications[channel]!.contains(kNotificationsAll);

  bool canView(EntityType? entityType) => can(UserPermission.view, entityType);

  bool canEdit(EntityType? entityType) => can(UserPermission.edit, entityType);

  bool canCreate(EntityType? entityType) =>
      can(UserPermission.create, entityType);

  bool canViewCreateOrEdit(EntityType? entityType) =>
      canView(entityType) || canCreate(entityType) || canEdit(entityType);

  bool canEditEntity(BaseEntity? entity) {
    if (entity == null) {
      return false;
    }

    if (entity.isNew) {
      return canCreate(entity.entityType);
    } else {
      return canEdit(entity.entityType) || user.canEdit(entity);
    }
  }

  bool get canViewReports {
    if (isAdmin) {
      return true;
    }

    return permissions.contains(kPermissionViewReports);
  }

  bool get canViewDashboard {
    if (isAdmin) {
      return true;
    }

    return permissions.contains(kPermissionViewDashboard);
  }

  // ignore: unused_element
  static void _initializeBuilder(UserCompanyEntityBuilder builder) => builder
    ..user.replace(UserEntity())
    ..token.replace(TokenEntity())
    ..account.replace(AccountEntity(false))
    ..settings.replace(UserSettingsEntity())
    ..notifications.replace(BuiltMap<String, BuiltList<String>>().rebuild((b) =>
        b
          ..[kNotificationChannelEmail] =
              BuiltList<String>(<String>[kNotificationsAll])))
    ..permissionsUpdatedAt = 0
    ..ninjaPortalUrl = '';

  static Serializer<UserCompanyEntity> get serializer =>
      _$userCompanyEntitySerializer;
}

abstract class UserSettingsEntity
    implements Built<UserSettingsEntity, UserSettingsEntityBuilder> {
  factory UserSettingsEntity() {
    return _$UserSettingsEntity._(
      accentColor: kDefaultAccentColor,
      numberYearsActive: 3,
      tableColumns: BuiltMap<String, BuiltList<String>>(),
      reportSettings: BuiltMap<String, ReportSettingsEntity>(),
      includeDeletedClients: false,
      dashboardFields: BuiltList<DashboardField>(<DashboardField>[
        DashboardField(
          field: DashboardUISettings.FIELD_ACTIVE_INVOICES,
          period: DashboardUISettings.PERIOD_CURRENT,
        ),
        DashboardField(
          field: DashboardUISettings.FIELD_OUTSTANDING_INVOICES,
          period: DashboardUISettings.PERIOD_CURRENT,
        ),
        DashboardField(
          field: DashboardUISettings.FIELD_COMPLETED_PAYMENTS,
          period: DashboardUISettings.PERIOD_CURRENT,
        ),
      ]),
      dashboardFieldsPerRowMobile: 1,
      dashboardFieldsPerRowDesktop: 3,
    );
  }

  UserSettingsEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'accent_color')
  String? get accentColor;

  @BuiltValueField(wireName: 'table_columns')
  BuiltMap<String, BuiltList<String>> get tableColumns;

  @BuiltValueField(wireName: 'report_settings')
  BuiltMap<String, ReportSettingsEntity> get reportSettings;

  @BuiltValueField(wireName: 'number_years_active')
  int get numberYearsActive;

  @BuiltValueField(wireName: 'include_deleted_clients')
  bool get includeDeletedClients;

  @BuiltValueField(wireName: 'dashboard_fields')
  BuiltList<DashboardField> get dashboardFields;

  @BuiltValueField(wireName: 'dashboard_fields_per_row_mobile')
  int get dashboardFieldsPerRowMobile;

  @BuiltValueField(wireName: 'dashboard_fields_per_row_desktop')
  int get dashboardFieldsPerRowDesktop;

  List<String>? getTableColumns(EntityType entityType) {
    if (tableColumns.containsKey('$entityType')) {
      return tableColumns['$entityType']!.toList();
    } else {
      return null;
    }
  }

  String? get validatedAccentColor {
    if ((accentColor ?? '').isEmpty) {
      return kDefaultAccentColor;
    }

    if (accentColor!.toLowerCase() == '#ffffff') {
      return kDefaultAccentColor;
    }

    return accentColor;
  }

  // ignore: unused_element
  static void _initializeBuilder(UserSettingsEntityBuilder builder) => builder
    ..accentColor = kDefaultAccentColor
    ..numberYearsActive = 3
    ..tableColumns.replace(BuiltMap<String, BuiltList<String>>())
    ..reportSettings.replace(BuiltMap<String, ReportSettingsEntity>())
    ..dashboardFields.replace(BuiltList<DashboardField>(<DashboardField>[
      DashboardField(
        field: DashboardUISettings.FIELD_ACTIVE_INVOICES,
        period: DashboardUISettings.PERIOD_CURRENT,
      ),
      DashboardField(
        field: DashboardUISettings.FIELD_OUTSTANDING_INVOICES,
        period: DashboardUISettings.PERIOD_CURRENT,
      ),
      DashboardField(
        field: DashboardUISettings.FIELD_COMPLETED_PAYMENTS,
        period: DashboardUISettings.PERIOD_CURRENT,
      ),
    ]))
    ..dashboardFieldsPerRowMobile = 1
    ..dashboardFieldsPerRowDesktop = 3
    ..includeDeletedClients = false;

  static Serializer<UserSettingsEntity> get serializer =>
      _$userSettingsEntitySerializer;
}

abstract class ReportSettingsEntity
    implements Built<ReportSettingsEntity, ReportSettingsEntityBuilder> {
  factory ReportSettingsEntity({
    String? sortColumn,
    bool? sortAscending,
    int? sortTotalsIndex,
    bool? sortTotalsAscending,
  }) {
    return _$ReportSettingsEntity._(
      sortColumn: sortColumn ?? '',
      sortAscending: sortAscending ?? true,
      sortTotalsIndex: sortTotalsIndex ?? 0,
      sortTotalsAscending: sortTotalsAscending ?? true,
      columns: BuiltList<String>(),
    );
  }

  ReportSettingsEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'sort_column')
  String get sortColumn;

  @BuiltValueField(wireName: 'sort_ascending')
  bool get sortAscending;

  @BuiltValueField(wireName: 'sort_totals_index')
  int get sortTotalsIndex;

  @BuiltValueField(wireName: 'sort_totals_ascending')
  bool get sortTotalsAscending;

  BuiltList<String> get columns;

  // ignore: unused_element
  static void _initializeBuilder(ReportSettingsEntityBuilder builder) => builder
    ..sortColumn = ''
    ..sortAscending = true
    ..sortTotalsAscending = true
    ..sortTotalsIndex = 0
    ..columns.replace(BuiltList<String>());

  static Serializer<ReportSettingsEntity> get serializer =>
      _$reportSettingsEntitySerializer;
}

abstract class CompanyItemResponse
    implements Built<CompanyItemResponse, CompanyItemResponseBuilder> {
  factory CompanyItemResponse([void updates(CompanyItemResponseBuilder b)]) =
      _$CompanyItemResponse;

  CompanyItemResponse._();

  @override
  @memoized
  int get hashCode;

  CompanyEntity get data;

  static Serializer<CompanyItemResponse> get serializer =>
      _$companyItemResponseSerializer;
}

abstract class RegistrationFieldEntity
    implements Built<RegistrationFieldEntity, RegistrationFieldEntityBuilder> {
  factory RegistrationFieldEntity(bool reportErrors) {
    return _$RegistrationFieldEntity._(
      key: '',
      required: false,
      visible: false,
    );
  }

  RegistrationFieldEntity._();

  static const SETTING_HIDDEN = 'hidden';
  static const SETTING_OPTIONAL = 'optional';
  static const SETTING_REQUIRED = 'required';

  @override
  @memoized
  int get hashCode;

  String get key;

  bool get required;

  bool get visible;

  String get setting {
    if (required) {
      return SETTING_REQUIRED;
    } else if (visible) {
      return SETTING_OPTIONAL;
    } else {
      return SETTING_HIDDEN;
    }
  }

  // ignore: unused_element
  static void _initializeBuilder(RegistrationFieldEntityBuilder builder) =>
      builder..visible = false;

  static Serializer<RegistrationFieldEntity> get serializer =>
      _$registrationFieldEntitySerializer;
}

abstract class DashboardField
    implements Built<DashboardField, DashboardFieldBuilder> {
  factory DashboardField({
    String? field,
    String? period,
    String? type,
  }) {
    return _$DashboardField._(
      field: field ?? '',
      period: period ?? '',
      type: type ?? TYPE_SUM,
    );
  }

  DashboardField._();

  static const TYPE_SUM = 'sum';
  static const TYPE_COUNT = 'count';
  static const TYPE_AVERAGE = 'average';

  @override
  @memoized
  int get hashCode;

  String get field;

  String get period;

  String get type;

  // ignore: unused_element
  static void _initializeBuilder(DashboardFieldBuilder builder) =>
      builder..type = TYPE_SUM;

  static Serializer<DashboardField> get serializer =>
      _$dashboardFieldSerializer;
}
