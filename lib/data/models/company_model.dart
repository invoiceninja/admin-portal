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
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'company_model.g.dart';

class CompanyFields {
  static const String name = 'name';
  static const String email = 'email';
  static const String address1 = 'address1';
  static const String address2 = 'address2';
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
      clientCanRegister: true,
      autoStartTasks: false,
      invoiceTaskTimelog: true,
      invoiceTaskDatelog: true,
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
      stopOnUnpaidRecurring: false,
      useQuoteTermsOnConversion: false,
      showProductionDescriptionDropdown: false,
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
    );
  }

  CompanyEntity._();

  static const USE_CREDITS_ALWAYS = 'always';
  static const USE_CREDITS_OPTION = 'option';
  static const USE_CREDITS_OFF = 'off';

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

  @BuiltValueField(wireName: 'use_quote_terms_on_conversion')
  bool get useQuoteTermsOnConversion;

  @BuiltValueField(wireName: 'show_production_description_dropdown')
  bool get showProductionDescriptionDropdown;

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

  BuiltList<TaskEntity> get tasks;

  BuiltList<ProjectEntity> get projects;

  BuiltList<ExpenseEntity> get expenses;

  BuiltList<VendorEntity> get vendors;

  BuiltList<DesignEntity> get designs;

  BuiltList<DocumentEntity> get documents;

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

  @BuiltValueField(wireName: 'stop_on_unpaid_recurring ')
  bool get stopOnUnpaidRecurring;

  String get displayName => settings.name ?? '';

  @override
  bool matchesFilter(String filter) {
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
  String matchesFilterValue(String filter) {
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
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  @override
  String get listDisplayName => null;

  bool hasCustomField(String field) => getCustomFieldLabel(field).isNotEmpty;

  bool get enableFirstInvoiceTaxRate => (numberOfInvoiceTaxRates ?? 0) >= 1;

  bool get enableSecondInvoiceTaxRate => (numberOfInvoiceTaxRates ?? 0) >= 2;

  bool get enableThirdInvoiceTaxRate => (numberOfInvoiceTaxRates ?? 0) >= 3;

  bool get enableFirstItemTaxRate => (numberOfItemTaxRates ?? 0) >= 1;

  bool get enableSecondItemTaxRate => (numberOfItemTaxRates ?? 0) >= 2;

  bool get enableThirdItemTaxRate => (numberOfItemTaxRates ?? 0) >= 3;

  bool get hasInvoiceTaxes => numberOfInvoiceTaxRates > 0;

  bool get hasItemTaxes => numberOfItemTaxRates > 0;

  bool get hasTaxes => hasInvoiceTaxes || hasItemTaxes;

  bool get isSmall => !isLarge;

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
    }

    if (customFields.containsKey(field)) {
      return customFields[field].split('|').first;
    } else {
      return '';
    }
  }

  String getCustomFieldType(String field) {
    if ((customFields[field] ?? '').contains('|')) {
      final value = customFields[field].split('|').last;
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
          ..credits.clear()
          ..tasks.clear()
          ..projects.clear()
          ..vendors.clear()
          ..expenses.clear()
          ..webhooks.clear()
          ..designs.clear()
          ..companyGateways.clear(),
      );

  bool isModuleEnabled(EntityType entityType) {
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
    }

    return true;
  }

  String get currencyId => settings.currencyId ?? kDefaultCurrencyId;

  // ignore: unused_element
  static void _initializeBuilder(CompanyEntityBuilder builder) => builder
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
    ..reportIncludeDrafts = false
    ..convertRateToClient = true
    ..stopOnUnpaidRecurring = false
    ..showProductionDescriptionDropdown = false
    ..systemLogs.replace(BuiltList<SystemLogEntity>())
    ..subscriptions.replace(BuiltList<SubscriptionEntity>())
    ..recurringExpenses.replace(BuiltList<ExpenseEntity>())
    ..clientRegistrationFields.replace(BuiltList<RegistrationFieldEntity>());

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
      .where((typeId) => options[typeId].supportTokenBilling)
      .isNotEmpty;

  bool get supportsRefunds =>
      options.keys.where((typeId) => options[typeId].supportRefunds).isNotEmpty;

  Map<String, dynamic> get parsedFields =>
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
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    return name.toLowerCase().contains(filter);
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    return null;
  }

  @override
  String get listDisplayName => name;

  @override
  double get listDisplayAmount => null;

  static String getClientUrl({String gatewayId, String customerReference}) {
    switch (gatewayId) {
      case kGatewayStripe:
      case kGatewayStripeConnect:
        return 'https://dashboard.stripe.com/customers/$customerReference';
      default:
        return null;
    }
  }

  static String getPaymentUrl({String gatewayId, String transactionReference}) {
    switch (gatewayId) {
      case kGatewayStripe:
      case kGatewayStripeConnect:
        if (transactionReference.startsWith('src'))
          return 'https://dashboard.stripe.com/sources/$transactionReference';
        else
          return 'https://dashboard.stripe.com/payments/$transactionReference';
        break;
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
  FormatNumberType get listDisplayAmountType => null;

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

  @nullable
  BuiltList<String> get webhooks;

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

  @nullable
  BuiltMap<String, BuiltList<String>> get notifications;

  @nullable
  CompanyEntity get company;

  @nullable
  UserEntity get user;

  @nullable
  TokenEntity get token;

  @nullable
  AccountEntity get account;

  @nullable
  UserSettingsEntity get settings;

  @BuiltValueField(wireName: 'ninja_portal_url')
  String get ninjaPortalUrl;

  bool can(UserPermission permission, EntityType entityType) {
    if (entityType == null) {
      return false;
    }

    if (!company.isModuleEnabled(entityType)) {
      return false;
    }

    if (Config.DEMO_MODE) {
      return true;
    }

    if (isAdmin ?? false) {
      return true;
    }

    return permissions.contains('${permission}_all') ||
        permissions.contains('${permission}_${entityType.snakeCase}');
  }

  bool receivesAllNotifications(String channel) =>
      notifications.containsKey(channel) &&
      notifications[channel].contains(kNotificationsAll);

  bool canView(EntityType entityType) => can(UserPermission.view, entityType);

  bool canEdit(EntityType entityType) => can(UserPermission.edit, entityType);

  bool canCreate(EntityType entityType) =>
      can(UserPermission.create, entityType);

  bool canViewOrCreate(EntityType entityType) =>
      canView(entityType) || canCreate(entityType);

  bool canEditEntity(BaseEntity entity) {
    if (entity == null) {
      return false;
    }

    if (entity.isNew) {
      return canCreate(entity.entityType);
    } else {
      return canEdit(entity.entityType) || user.canEdit(entity);
    }
  }

  // ignore: unused_element
  static void _initializeBuilder(UserCompanyEntityBuilder builder) => builder
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
    );
  }

  UserSettingsEntity._();

  @override
  @memoized
  int get hashCode;

  @nullable
  @BuiltValueField(wireName: 'accent_color')
  String get accentColor;

  @BuiltValueField(wireName: 'table_columns')
  BuiltMap<String, BuiltList<String>> get tableColumns;

  @BuiltValueField(wireName: 'report_settings')
  BuiltMap<String, ReportSettingsEntity> get reportSettings;

  @BuiltValueField(wireName: 'number_years_active')
  int get numberYearsActive;

  @BuiltValueField(wireName: 'include_deleted_clients')
  bool get includeDeletedClients;

  List<String> getTableColumns(EntityType entityType) {
    if (tableColumns != null && tableColumns.containsKey('$entityType')) {
      return tableColumns['$entityType'].toList();
    } else {
      return null;
    }
  }

  // ignore: unused_element
  static void _initializeBuilder(UserSettingsEntityBuilder builder) => builder
    ..accentColor = kDefaultAccentColor
    ..numberYearsActive = 3
    ..tableColumns.replace(BuiltMap<String, BuiltList<String>>())
    ..reportSettings.replace(BuiltMap<String, ReportSettingsEntity>())
    ..includeDeletedClients = false;

  static Serializer<UserSettingsEntity> get serializer =>
      _$userSettingsEntitySerializer;
}

abstract class ReportSettingsEntity
    implements Built<ReportSettingsEntity, ReportSettingsEntityBuilder> {
  factory ReportSettingsEntity({
    String sortColumn,
    bool sortAscending,
    int sortTotalsIndex,
    bool sortTotalsAscending,
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
    );
  }

  RegistrationFieldEntity._();

  @override
  @memoized
  int get hashCode;

  String get key;

  bool get required;

  static Serializer<RegistrationFieldEntity> get serializer =>
      _$registrationFieldEntitySerializer;
}
