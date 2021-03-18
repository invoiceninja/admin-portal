import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/account_model.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/.env.dart';
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
      invoiceTaskDocuments: false,
      isDisabled: false,
      calculateExpenseTaxByAmount: false,
      expenseInclusiveTaxes: false,
      sessionTimeout: 0,
      passwordTimeout: 30 * 60 * 1000,
      oauthPasswordRequired: false,
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

  @BuiltValueField(wireName: 'payment_terms')
  BuiltList<PaymentTermEntity> get paymentTerms;

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

  SettingsEntity get settings;

  @BuiltValueField(wireName: 'enabled_modules')
  int get enabledModules;

  @BuiltValueField(wireName: 'calculate_expense_tax_by_amount')
  bool get calculateExpenseTaxByAmount;

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

  bool get hasCustomSurcharge =>
      hasCustomField(CustomFieldType.surcharge1) ||
      hasCustomField(CustomFieldType.surcharge2) ||
      hasCustomField(CustomFieldType.surcharge3) ||
      hasCustomField(CustomFieldType.surcharge4);

  String getCustomFieldLabel(String field) {
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
  CompanyEntity get coreCompany => rebuild((b) => b
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
      //..designs.clear()
      //..companyGateways.clear()
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
    ..invoiceTaskDatelog = true;

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
    );
  }

  GatewayEntity._();

  @override
  @memoized
  int get hashCode;

  static Serializer<GatewayEntity> get serializer => _$gatewayEntitySerializer;

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
        return 'https://dashboard.stripe.com/customers/$customerReference}';
      default:
        return null;
    }
  }

  static String getPaymentUrl({String gatewayId, String transactionReference}) {
    switch (gatewayId) {
      case kGatewayStripe:
        return 'https://dashboard.stripe.com/payments/$transactionReference}';
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
        permissions.contains('${permission}_$entityType');
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
  static void _initializeBuilder(UserCompanyEntityBuilder builder) =>
      builder..permissionsUpdatedAt = 0;

  static Serializer<UserCompanyEntity> get serializer =>
      _$userCompanyEntitySerializer;
}

abstract class UserSettingsEntity
    implements Built<UserSettingsEntity, UserSettingsEntityBuilder> {
  factory UserSettingsEntity() {
    return _$UserSettingsEntity._(
      accentColor: kDefaultAccentColor,
      tableColumns: BuiltMap<String, BuiltList<String>>(),
      reportSettings: BuiltMap<String, ReportSettingsEntity>(),
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

  List<String> getTableColumns(EntityType entityType) {
    if (tableColumns != null && tableColumns.containsKey('$entityType')) {
      return tableColumns['$entityType'].toList();
    } else {
      return null;
    }
  }

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
  static void _initializeBuilder(ReportSettingsEntityBuilder builder) =>
      builder..sortColumn = '';

  static Serializer<ReportSettingsEntity> get serializer =>
      _$reportSettingsEntitySerializer;
}

abstract class SettingsEntity
    implements Built<SettingsEntity, SettingsEntityBuilder> {
  factory SettingsEntity({
    SettingsEntity companySettings,
    SettingsEntity groupSettings,
    SettingsEntity clientSettings,
  }) {
    return _$SettingsEntity._(
      defaultInvoiceTerms: clientSettings?.defaultInvoiceTerms ??
          groupSettings?.defaultInvoiceTerms ??
          companySettings?.defaultInvoiceTerms,
      defaultInvoiceFooter: clientSettings?.defaultInvoiceFooter ??
          groupSettings?.defaultInvoiceFooter ??
          companySettings?.defaultInvoiceFooter,
      lockInvoices: clientSettings?.lockInvoices ??
          groupSettings?.lockInvoices ??
          companySettings?.lockInvoices,
    );
  }

  SettingsEntity._();

  @override
  @memoized
  int get hashCode;

  static const EMAIL_SENDING_METHOD_DEFAULT = 'default';
  static const EMAIL_SENDING_METHOD_GMAIL = 'gmail';

  static const LOCK_INVOICES_OFF = 'off';
  static const LOCK_INVOICES_SENT = 'when_sent';
  static const LOCK_INVOICES_PAID = 'when_paid';

  static const AUTO_BILL_OFF = 'off';
  static const AUTO_BILL_OPT_IN = 'optin';
  static const AUTO_BILL_OPT_OUT = 'optout';
  static const AUTO_BILL_ALWAYS = 'always';

  static const AUTO_BILL_ON_SEND_DATE = 'on_send_date';
  static const AUTO_BILL_ON_DUE_DATE = 'on_due_date';

  @nullable
  @BuiltValueField(wireName: 'timezone_id')
  String get timezoneId;

  @nullable
  @BuiltValueField(wireName: 'date_format_id')
  String get dateFormatId;

  @nullable
  @BuiltValueField(wireName: 'military_time')
  bool get enableMilitaryTime;

  @nullable
  @BuiltValueField(wireName: 'language_id')
  String get languageId;

  @nullable
  @BuiltValueField(wireName: 'show_currency_code')
  bool get showCurrencyCode;

  @nullable
  @BuiltValueField(wireName: 'currency_id')
  String get currencyId;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @nullable
  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @nullable
  @BuiltValueField(wireName: 'payment_terms')
  String get defaultPaymentTerms;

  @nullable
  @BuiltValueField(wireName: 'company_gateway_ids')
  String get companyGatewayIds;

  @nullable
  @BuiltValueField(wireName: 'default_task_rate')
  double get defaultTaskRate;

  @nullable
  @BuiltValueField(wireName: 'send_reminders')
  bool get sendReminders;

  @nullable
  @BuiltValueField(wireName: 'enable_client_portal')
  bool get enablePortal;

  @nullable
  @BuiltValueField(wireName: 'enable_client_portal_dashboard')
  bool get enablePortalDashboard;

  @nullable
  @BuiltValueField(wireName: 'enable_client_portal_tasks')
  bool get enablePortalTasks;

  @nullable
  @BuiltValueField(wireName: 'client_portal_enable_uploads')
  bool get enablePortalUploads;

  @nullable
  @BuiltValueField(wireName: 'email_style')
  String get emailStyle;

  @nullable
  @BuiltValueField(wireName: 'reply_to_email')
  String get replyToEmail;

  @nullable
  @BuiltValueField(wireName: 'reply_to_name')
  String get replyToName;

  @nullable
  @BuiltValueField(wireName: 'bcc_email')
  String get bccEmail;

  @nullable
  @BuiltValueField(wireName: 'pdf_email_attachment')
  bool get pdfEmailAttachment;

  @nullable
  @BuiltValueField(wireName: 'ubl_email_attachment')
  bool get ublEmailAttachment;

  @nullable
  @BuiltValueField(wireName: 'document_email_attachment')
  bool get documentEmailAttachment;

  @nullable
  @BuiltValueField(wireName: 'email_style_custom')
  String get emailStyleCustom;

  @nullable
  @BuiltValueField(wireName: 'custom_message_dashboard')
  String get customMessageDashboard;

  @nullable
  @BuiltValueField(wireName: 'custom_message_unpaid_invoice')
  String get customMessageUnpaidInvoice;

  @nullable
  @BuiltValueField(wireName: 'custom_message_paid_invoice')
  String get customMessagePaidInvoice;

  @nullable
  @BuiltValueField(wireName: 'custom_message_unapproved_quote')
  String get customMessageUnapprovedQuote;

  @nullable
  @BuiltValueField(wireName: 'auto_archive_invoice')
  bool get autoArchiveInvoice;

  @nullable
  @BuiltValueField(wireName: 'auto_archive_quote')
  bool get autoArchiveQuote;

  @nullable
  @BuiltValueField(wireName: 'auto_email_invoice')
  bool get autoEmailInvoice;

  @nullable
  @BuiltValueField(wireName: 'auto_convert_quote')
  bool get autoConvertQuote;

  @nullable
  @BuiltValueField(wireName: 'inclusive_taxes')
  bool get enableInclusiveTaxes;

  @nullable
  BuiltMap<String, String> get translations;

  @nullable
  @BuiltValueField(wireName: 'task_number_pattern')
  String get taskNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'task_number_counter')
  int get taskNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'expense_number_pattern')
  String get expenseNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'expense_number_counter')
  int get expenseNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'vendor_number_pattern')
  String get vendorNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'vendor_number_counter')
  int get vendorNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'ticket_number_pattern')
  String get ticketNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'ticket_number_counter')
  int get ticketNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'payment_number_pattern')
  String get paymentNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'payment_number_counter')
  int get paymentNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'project_number_pattern')
  String get projectNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'project_number_counter')
  int get projectNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'invoice_number_pattern')
  String get invoiceNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'invoice_number_counter')
  int get invoiceNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'recurring_invoice_number_pattern')
  String get recurringInvoiceNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'recurring_invoice_number_counter')
  int get recurringInvoiceNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'quote_number_pattern')
  String get quoteNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'quote_number_counter')
  int get quoteNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'client_number_pattern')
  String get clientNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'client_number_counter')
  int get clientNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'credit_number_pattern')
  String get creditNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'credit_number_counter')
  int get creditNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'recurring_number_prefix')
  String get recurringNumberPrefix;

  @nullable
  @BuiltValueField(wireName: 'reset_counter_frequency_id')
  String get resetCounterFrequencyId;

  @nullable
  @BuiltValueField(wireName: 'reset_counter_date')
  String get resetCounterDate;

  @nullable
  @BuiltValueField(wireName: 'counter_padding')
  int get counterPadding;

  @nullable
  @BuiltValueField(wireName: 'shared_invoice_quote_counter')
  bool get sharedInvoiceQuoteCounter;

  @nullable
  @BuiltValueField(wireName: 'shared_invoice_credit_counter')
  bool get sharedInvoiceCreditCounter;

  @nullable
  @BuiltValueField(wireName: 'invoice_terms')
  String get defaultInvoiceTerms;

  @nullable
  @BuiltValueField(wireName: 'quote_terms')
  String get defaultQuoteTerms;

  @nullable
  @BuiltValueField(wireName: 'quote_footer')
  String get defaultQuoteFooter;

  @nullable
  @BuiltValueField(wireName: 'credit_terms')
  String get defaultCreditTerms;

  @nullable
  @BuiltValueField(wireName: 'credit_footer')
  String get defaultCreditFooter;

  @nullable
  @BuiltValueField(wireName: 'invoice_design_id')
  String get defaultInvoiceDesignId;

  @nullable
  @BuiltValueField(wireName: 'quote_design_id')
  String get defaultQuoteDesignId;

  @nullable
  @BuiltValueField(wireName: 'credit_design_id')
  String get defaultCreditDesignId;

  @nullable
  @BuiltValueField(wireName: 'invoice_footer')
  String get defaultInvoiceFooter;

  @nullable
  @BuiltValueField(wireName: 'tax_name1')
  String get defaultTaxName1;

  @nullable
  @BuiltValueField(wireName: 'tax_rate1')
  double get defaultTaxRate1;

  @nullable
  @BuiltValueField(wireName: 'tax_name2')
  String get defaultTaxName2;

  @nullable
  @BuiltValueField(wireName: 'tax_rate2')
  double get defaultTaxRate2;

  @nullable
  @BuiltValueField(wireName: 'tax_name3')
  String get defaultTaxName3;

  @nullable
  @BuiltValueField(wireName: 'tax_rate3')
  double get defaultTaxRate3;

  @nullable
  @BuiltValueField(wireName: 'payment_type_id')
  String get defaultPaymentTypeId;

  @nullable
  @BuiltValueField(wireName: 'pdf_variables')
  BuiltMap<String, BuiltList<String>> get pdfVariables;

  @nullable
  @BuiltValueField(wireName: 'email_signature')
  String get emailSignature;

  @nullable
  @BuiltValueField(wireName: 'email_subject_invoice')
  String get emailSubjectInvoice;

  @nullable
  @BuiltValueField(wireName: 'email_subject_quote')
  String get emailSubjectQuote;

  @nullable
  @BuiltValueField(wireName: 'email_subject_credit')
  String get emailSubjectCredit;

  @nullable
  @BuiltValueField(wireName: 'email_subject_payment')
  String get emailSubjectPayment;

  @nullable
  @BuiltValueField(wireName: 'email_subject_payment_partial')
  String get emailSubjectPaymentPartial;

  @nullable
  @BuiltValueField(wireName: 'email_template_invoice')
  String get emailBodyInvoice;

  @nullable
  @BuiltValueField(wireName: 'email_template_quote')
  String get emailBodyQuote;

  @nullable
  @BuiltValueField(wireName: 'email_template_credit')
  String get emailBodyCredit;

  @nullable
  @BuiltValueField(wireName: 'email_template_payment')
  String get emailBodyPayment;

  @nullable
  @BuiltValueField(wireName: 'email_template_payment_partial')
  String get emailBodyPaymentPartial;

  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder1')
  String get emailSubjectReminder1;

  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder2')
  String get emailSubjectReminder2;

  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder3')
  String get emailSubjectReminder3;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder1')
  String get emailBodyReminder1;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder2')
  String get emailBodyReminder2;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder3')
  String get emailBodyReminder3;

  @nullable
  @BuiltValueField(wireName: 'email_subject_custom1')
  String get emailSubjectCustom1;

  @nullable
  @BuiltValueField(wireName: 'email_template_custom1')
  String get emailBodyCustom1;

  @nullable
  @BuiltValueField(wireName: 'email_subject_custom2')
  String get emailSubjectCustom2;

  @nullable
  @BuiltValueField(wireName: 'email_template_custom2')
  String get emailBodyCustom2;

  @nullable
  @BuiltValueField(wireName: 'email_subject_custom3')
  String get emailSubjectCustom3;

  @nullable
  @BuiltValueField(wireName: 'email_template_custom3')
  String get emailBodyCustom3;

  @nullable
  @BuiltValueField(wireName: 'email_subject_statement')
  String get emailSubjectStatement;

  @nullable
  @BuiltValueField(wireName: 'email_template_statement')
  String get emailBodyStatement;

  @nullable
  @BuiltValueField(wireName: 'enable_client_portal_password')
  bool get enablePortalPassword;

  @nullable
  @BuiltValueField(wireName: 'signature_on_pdf')
  bool get signatureOnPdf;

  @nullable
  @BuiltValueField(wireName: 'enable_email_markup')
  bool get enableEmailMarkup;

  @nullable
  @BuiltValueField(wireName: 'show_accept_invoice_terms')
  bool get showAcceptInvoiceTerms;

  @nullable
  @BuiltValueField(wireName: 'show_accept_quote_terms')
  bool get showAcceptQuoteTerms;

  @nullable
  @BuiltValueField(wireName: 'require_invoice_signature')
  bool get requireInvoiceSignature;

  @nullable
  @BuiltValueField(wireName: 'require_quote_signature')
  bool get requireQuoteSignature;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'company_logo')
  String get companyLogo;

  @nullable
  @BuiltValueField(wireName: 'website')
  String get website;

  @nullable
  String get address1;

  @nullable
  String get address2;

  @nullable
  String get city;

  @nullable
  String get state;

  @nullable
  @BuiltValueField(wireName: 'postal_code')
  String get postalCode;

  @nullable
  String get phone;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'country_id')
  String get countryId;

  @nullable
  @BuiltValueField(wireName: 'vat_number')
  String get vatNumber;

  @nullable
  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

  @nullable
  @BuiltValueField(wireName: 'page_size')
  String get pageSize;

  @nullable
  @BuiltValueField(wireName: 'font_size')
  int get fontSize;

  @nullable
  @BuiltValueField(wireName: 'primary_color')
  String get primaryColor;

  @nullable
  @BuiltValueField(wireName: 'secondary_color')
  String get secondaryColor;

  @nullable
  @BuiltValueField(wireName: 'primary_font')
  String get primaryFont;

  @nullable
  @BuiltValueField(wireName: 'secondary_font')
  String get secondaryFont;

  @nullable
  @BuiltValueField(wireName: 'hide_paid_to_date')
  bool get hidePaidToDate;

  @nullable
  @BuiltValueField(wireName: 'embed_documents')
  bool get embedDocuments;

  @nullable
  @BuiltValueField(wireName: 'all_pages_header')
  bool get allPagesHeader;

  @nullable
  @BuiltValueField(wireName: 'all_pages_footer')
  bool get allPagesFooter;

  @nullable
  @BuiltValueField(wireName: 'enable_reminder1')
  bool get enableReminder1;

  @nullable
  @BuiltValueField(wireName: 'enable_reminder2')
  bool get enableReminder2;

  @nullable
  @BuiltValueField(wireName: 'enable_reminder3')
  bool get enableReminder3;

  @nullable
  @BuiltValueField(wireName: 'enable_reminder_endless')
  bool get enableReminderEndless;

  @nullable
  @BuiltValueField(wireName: 'num_days_reminder1')
  int get numDaysReminder1;

  @nullable
  @BuiltValueField(wireName: 'num_days_reminder2')
  int get numDaysReminder2;

  @nullable
  @BuiltValueField(wireName: 'num_days_reminder3')
  int get numDaysReminder3;

  @nullable
  @BuiltValueField(wireName: 'schedule_reminder1')
  String get scheduleReminder1;

  @nullable
  @BuiltValueField(wireName: 'schedule_reminder2')
  String get scheduleReminder2;

  @nullable
  @BuiltValueField(wireName: 'schedule_reminder3')
  String get scheduleReminder3;

  @nullable
  @BuiltValueField(wireName: 'endless_reminder_frequency_id')
  String get endlessReminderFrequencyId;

  @nullable
  @BuiltValueField(wireName: 'late_fee_amount1')
  double get lateFeeAmount1;

  @nullable
  @BuiltValueField(wireName: 'late_fee_amount2')
  double get lateFeeAmount2;

  @nullable
  @BuiltValueField(wireName: 'late_fee_amount3')
  double get lateFeeAmount3;

  @nullable
  @BuiltValueField(wireName: 'late_fee_endless_amount')
  double get lateFeeAmountEndless;

  @nullable
  @BuiltValueField(wireName: 'late_fee_percent1')
  double get lateFeePercent1;

  @nullable
  @BuiltValueField(wireName: 'late_fee_percent2')
  double get lateFeePercent2;

  @nullable
  @BuiltValueField(wireName: 'late_fee_percent3')
  double get lateFeePercent3;

  @nullable
  @BuiltValueField(wireName: 'late_fee_endless_percent')
  double get lateFeePercentEndless;

  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder_endless')
  String get emailSubjectReminderEndless;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder_endless')
  String get emailBodyReminderEndless;

  @nullable
  @BuiltValueField(wireName: 'client_online_payment_notification')
  bool get clientOnlinePaymentNotification;

  @nullable
  @BuiltValueField(wireName: 'client_manual_payment_notification')
  bool get clientManualPaymentNotification;

  @nullable
  @BuiltValueField(wireName: 'counter_number_applied')
  String get counterNumberApplied;

  @nullable
  @BuiltValueField(wireName: 'email_sending_method')
  String get emailSendingMethod;

  @nullable
  @BuiltValueField(wireName: 'gmail_sending_user_id')
  String get gmailSendingUserId;

  @nullable
  @BuiltValueField(wireName: 'client_portal_terms')
  String get clientPortalTerms;

  @nullable
  @BuiltValueField(wireName: 'client_portal_privacy_policy')
  String get clientPortalPrivacy;

  @nullable
  @BuiltValueField(wireName: 'lock_invoices')
  String get lockInvoices;

  @nullable
  @BuiltValueField(wireName: 'auto_bill')
  String get autoBill;

  @nullable
  @BuiltValueField(wireName: 'client_portal_allow_under_payment')
  bool get clientPortalAllowUnderPayment;

  @nullable
  @BuiltValueField(wireName: 'client_portal_allow_over_payment')
  bool get clientPortalAllowOverPayment;

  @nullable
  @BuiltValueField(wireName: 'auto_bill_date')
  String get autoBillDate;

  @nullable
  @BuiltValueField(wireName: 'client_portal_under_payment_minimum')
  double get clientPortalUnderPaymentMinimum;

  @nullable
  @BuiltValueField(wireName: 'use_credits_payment')
  String get useCreditsPayment;

  @nullable
  @BuiltValueField(wireName: 'portal_custom_head')
  String get clientPortalCustomHeader;

  @nullable
  @BuiltValueField(wireName: 'portal_custom_css')
  String get clientPortalCustomCss;

  @nullable
  @BuiltValueField(wireName: 'portal_custom_footer')
  String get clientPortalCustomFooter;

  @nullable
  @BuiltValueField(wireName: 'portal_custom_js')
  String get clientPortalCustomJs;

  @nullable
  @BuiltValueField(wireName: 'hide_empty_columns_on_pdf')
  bool get hideEmptyColumnsOnPdf;

  // TODO remove this field
  @nullable
  @BuiltValueField(wireName: 'has_custom_design1_HIDDEN')
  bool get hasCustomDesign1;

  // TODO remove this field
  @nullable
  @BuiltValueField(wireName: 'has_custom_design2_HIDDEN')
  bool get hasCustomDesign2;

  // TODO remove this field
  @nullable
  @BuiltValueField(wireName: 'has_custom_design3_HIDDEN')
  bool get hasCustomDesign3;

  bool get hasAddress => address1 != null && address1.isNotEmpty;

  bool get hasLogo => companyLogo != null && companyLogo.isNotEmpty;

  bool get hasTimezone => timezoneId != null && timezoneId.isNotEmpty;

  bool get hasDateFormat => dateFormatId != null && dateFormatId.isNotEmpty;

  bool get hasLanguage => languageId != null && languageId.isNotEmpty;

  bool get hasCurrency => currencyId != null && currencyId.isNotEmpty;

  bool get hasDefaultPaymentTypeId =>
      defaultPaymentTypeId != null && defaultPaymentTypeId.isNotEmpty;

  List<String> getFieldsForSection(String section) =>
      pdfVariables != null && pdfVariables.containsKey(section)
          ? pdfVariables[section].toList()
          : [];

  SettingsEntity setFieldsForSection(String section, List<String> fields) {
    if (pdfVariables == null) {
      return rebuild((b) => b..pdfVariables.replace({section: fields}));
    } else {
      return rebuild((b) => b..pdfVariables[section] = BuiltList(fields));
    }
  }

  String getEmailSubject(EmailTemplate emailTemplate) {
    switch (emailTemplate) {
      case EmailTemplate.invoice:
        return emailSubjectInvoice;
      case EmailTemplate.quote:
        return emailSubjectQuote;
      case EmailTemplate.credit:
        return emailSubjectCredit;
      case EmailTemplate.payment:
        return emailSubjectPayment;
      case EmailTemplate.payment_partial:
        return emailSubjectPaymentPartial;
      case EmailTemplate.reminder1:
        return emailSubjectReminder1;
      case EmailTemplate.reminder2:
        return emailSubjectReminder2;
      case EmailTemplate.reminder3:
        return emailSubjectReminder3;
      case EmailTemplate.custom1:
        return emailSubjectCustom1;
      case EmailTemplate.custom2:
        return emailSubjectCustom2;
      case EmailTemplate.custom3:
        return emailSubjectCustom3;
      default:
        return emailSubjectInvoice;
    }
  }

  String getEmailBody(EmailTemplate template) {
    switch (template) {
      case EmailTemplate.invoice:
        return emailBodyInvoice;
      case EmailTemplate.quote:
        return emailBodyQuote;
      case EmailTemplate.credit:
        return emailBodyCredit;
      case EmailTemplate.payment:
        return emailBodyPayment;
      case EmailTemplate.payment_partial:
        return emailBodyPaymentPartial;
      case EmailTemplate.reminder1:
        return emailBodyReminder1;
      case EmailTemplate.reminder2:
        return emailBodyReminder2;
      case EmailTemplate.reminder3:
        return emailBodyReminder3;
      case EmailTemplate.custom1:
        return emailBodyCustom1;
      case EmailTemplate.custom2:
        return emailBodyCustom2;
      case EmailTemplate.custom3:
        return emailBodyCustom3;
      default:
        return emailBodyInvoice;
    }
  }

  static Serializer<SettingsEntity> get serializer =>
      _$settingsEntitySerializer;
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
