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
      id: '',
      updatedAt: 0,
      archivedAt: 0,
      assignedUserId: '',
      createdAt: 0,
      createdUserId: '',
      isChanged: false,
      isDeleted: false,
      companyKey: '',
      plan: '',
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
      defaultQuantity: true,
      slackWebhookUrl: '',
      googleAnalyticsKey: '',
      clientCanRegister: true,
      isLarge: false,
      enableShopApi: false,
      convertProductExchangeRate: false,
      enableCustomSurchargeTaxes1: false,
      enableCustomSurchargeTaxes2: false,
      enableCustomSurchargeTaxes3: false,
      enableCustomSurchargeTaxes4: false,
      numberOfInvoiceTaxRates: 0,
      numberOfItemTaxRates: 0,
      groups: BuiltList<GroupEntity>(),
      taxRates: BuiltList<TaxRateEntity>(),
      taskStatuses: BuiltList<TaskStatusEntity>(),
      taskStatusMap: BuiltMap<String, TaskStatusEntity>(),
      companyGateways: BuiltList<CompanyGatewayEntity>(),
      expenseCategories: BuiltList<ExpenseCategoryEntity>(),
      expenseCategoryMap: BuiltMap<String, ExpenseCategoryEntity>(),
      users: BuiltList<UserEntity>(),
      customFields: BuiltMap<String, String>(),
      activities: BuiltList<ActivityEntity>(),
      clients: BuiltList<ClientEntity>(),
      products: BuiltList<ProductEntity>(),
      invoices: BuiltList<InvoiceEntity>(),
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
    );
  }

  CompanyEntity._();

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

  @BuiltValueField(wireName: 'default_quantity')
  bool get defaultQuantity;

  @BuiltValueField(wireName: 'show_product_details')
  bool get showProductDetails;

  @BuiltValueField(wireName: 'client_can_register')
  bool get clientCanRegister;

  @BuiltValueField(wireName: 'is_large')
  bool get isLarge;

  @BuiltValueField(wireName: 'enable_shop_api')
  bool get enableShopApi;

  // TODO remove this
  @nullable
  String get plan;

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

  BuiltMap<String, ExpenseCategoryEntity> get expenseCategoryMap;

  BuiltList<UserEntity> get users;

  BuiltList<ClientEntity> get clients;

  BuiltList<ProductEntity> get products;

  BuiltList<InvoiceEntity> get invoices;

  BuiltList<PaymentEntity> get payments;

  BuiltList<InvoiceEntity> get quotes;

  BuiltList<InvoiceEntity> get credits;

  BuiltList<TaskEntity> get tasks;

  BuiltList<ProjectEntity> get projects;

  BuiltList<ExpenseEntity> get expenses;

  BuiltList<VendorEntity> get vendors;

  BuiltList<DesignEntity> get designs;

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

  SettingsEntity get settings;

  @nullable
  @BuiltValueField(wireName: 'enabled_modules')
  int get enabledModules;

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
    // TODO remove this
    if ([
      EntityType.recurringInvoice,
      EntityType.project,
      EntityType.task,
      EntityType.expense,
      EntityType.vendor,
    ].contains(entityType)) {
      return false;
    }

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
    } else if ([EntityType.task, EntityType.project].contains(entityType) &&
        enabledModules & kModuleTasks == 0) {
      return false;
    } else if ([EntityType.expense, EntityType.vendor].contains(entityType) &&
        enabledModules & kModuleExpenses == 0) {
      return false;
    } else if (entityType == EntityType.recurringInvoice &&
        enabledModules & kModuleRecurringInvoices == 0) {
      return false;
    }

    return true;
  }

  String get currencyId => settings.currencyId ?? kDefaultCurrencyId;

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
    );
  }

  GatewayEntity._();

  @override
  @memoized
  int get hashCode;

  static Serializer<GatewayEntity> get serializer => _$gatewayEntitySerializer;

  @override
  @nullable
  @BuiltValueField(wireName: 'key')
  String get id;

  String get name;

  @BuiltValueField(wireName: 'is_offsite')
  bool get isOffsite;

  @BuiltValueField(wireName: 'sort_order')
  int get sortOrder;

  @nullable
  @BuiltValueField(wireName: 'default_gateway_type_id')
  String get defaultGatewayTypeId;

  //bool get recommended;
  //bool get visible;

  String get fields;

  bool get supportsTokenBilling => [
        kGatewayStripe,
        kGatewayAuthorizeNet,
        kGatewayCheckoutCom,
      ].contains(id);

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

  @override
  FormatNumberType get listDisplayAmountType => null;
}

abstract class UserCompanyEntity
    implements Built<UserCompanyEntity, UserCompanyEntityBuilder> {
  factory UserCompanyEntity() {
    return _$UserCompanyEntity._(
      isAdmin: false,
      isOwner: false,
      permissions: '',
      company: CompanyEntity(),
      user: UserEntity(),
      token: TokenEntity(),
      account: AccountEntity(),
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

    // TODO remove this once task/expenses are supported
    if (!Config.DEMO_MODE &&
        [
          EntityType.vendor,
          EntityType.expense,
          EntityType.task,
          EntityType.project,
        ].contains(entityType)) {
      return false;
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

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'accent_color')
  @nullable
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
      sortTotalsIndex: sortTotalsIndex,
      sortTotalsAscending: sortTotalsAscending ?? true,
      columns: BuiltList<String>(),
    );
  }

  ReportSettingsEntity._();

  @override
  @memoized
  int get hashCode;

  @nullable
  @BuiltValueField(wireName: 'sort_column')
  String get sortColumn;

  // TODO remove nullable
  @nullable
  @BuiltValueField(wireName: 'sort_ascending')
  bool get sortAscending;

  @nullable
  @BuiltValueField(wireName: 'sort_totals_index')
  int get sortTotalsIndex;

  // TODO remove nullable
  @nullable
  @BuiltValueField(wireName: 'sort_totals_ascending')
  bool get sortTotalsAscending;

  BuiltList<String> get columns;

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
      timezoneId: clientSettings?.timezoneId ??
          groupSettings?.timezoneId ??
          companySettings?.timezoneId,
      dateFormatId: clientSettings?.dateFormatId ??
          groupSettings?.dateFormatId ??
          companySettings?.dateFormatId,
      enableMilitaryTime: clientSettings?.enableMilitaryTime ??
          groupSettings?.enableMilitaryTime ??
          companySettings?.enableMilitaryTime,
      languageId: clientSettings?.languageId ??
          groupSettings?.languageId ??
          companySettings?.languageId,
      showCurrencyCode: clientSettings?.showCurrencyCode ??
          groupSettings?.showCurrencyCode ??
          companySettings?.showCurrencyCode,
      currencyId: clientSettings?.currencyId ??
          groupSettings?.currencyId ??
          companySettings?.currencyId,
      customValue1: clientSettings?.customValue1 ??
          groupSettings?.customValue1 ??
          companySettings?.customValue1,
      customValue2: clientSettings?.customValue2 ??
          groupSettings?.customValue2 ??
          companySettings?.customValue2,
      customValue3: clientSettings?.customValue3 ??
          groupSettings?.customValue3 ??
          companySettings?.customValue3,
      customValue4: clientSettings?.customValue4 ??
          groupSettings?.customValue4 ??
          companySettings?.customValue4,
      defaultPaymentTerms: clientSettings?.defaultPaymentTerms ??
          groupSettings?.defaultPaymentTerms ??
          companySettings?.defaultPaymentTerms,
      companyGatewayIds: clientSettings?.companyGatewayIds ??
          groupSettings?.companyGatewayIds ??
          companySettings?.companyGatewayIds,
      defaultTaskRate: clientSettings?.defaultTaskRate ??
          groupSettings?.defaultTaskRate ??
          companySettings?.defaultTaskRate,
      sendReminders: clientSettings?.sendReminders ??
          groupSettings?.sendReminders ??
          companySettings?.sendReminders,
      enablePortal: clientSettings?.enablePortal ??
          groupSettings?.enablePortal ??
          companySettings?.enablePortal,
      enablePortalDashboard: clientSettings?.enablePortalDashboard ??
          groupSettings?.enablePortalDashboard ??
          companySettings?.enablePortalDashboard,
      enablePortalTasks: clientSettings?.enablePortalTasks ??
          groupSettings?.enablePortalTasks ??
          companySettings?.enablePortalTasks,
      emailStyle: clientSettings?.emailStyle ??
          groupSettings?.emailStyle ??
          companySettings?.emailStyle,
      replyToEmail: clientSettings?.replyToEmail ??
          groupSettings?.replyToEmail ??
          companySettings?.replyToEmail,
      bccEmail: clientSettings?.bccEmail ??
          groupSettings?.bccEmail ??
          companySettings?.bccEmail,
      pdfEmailAttachment: clientSettings?.pdfEmailAttachment ??
          groupSettings?.pdfEmailAttachment ??
          companySettings?.pdfEmailAttachment,
      ublEmailAttachment: clientSettings?.ublEmailAttachment ??
          groupSettings?.ublEmailAttachment ??
          companySettings?.ublEmailAttachment,
      documentEmailAttachment: clientSettings?.documentEmailAttachment ??
          groupSettings?.documentEmailAttachment ??
          companySettings?.documentEmailAttachment,
      emailStyleCustom: clientSettings?.emailStyleCustom ??
          groupSettings?.emailStyleCustom ??
          companySettings?.emailStyleCustom,
      customMessageDashboard: clientSettings?.customMessageDashboard ??
          groupSettings?.customMessageDashboard ??
          companySettings?.customMessageDashboard,
      customMessageUnpaidInvoice: clientSettings?.customMessageUnpaidInvoice ??
          groupSettings?.customMessageUnpaidInvoice ??
          companySettings?.customMessageUnpaidInvoice,
      customMessagePaidInvoice: clientSettings?.customMessagePaidInvoice ??
          groupSettings?.customMessagePaidInvoice ??
          companySettings?.customMessagePaidInvoice,
      customMessageUnapprovedQuote:
          clientSettings?.customMessageUnapprovedQuote ??
              groupSettings?.customMessageUnapprovedQuote ??
              companySettings?.customMessageUnapprovedQuote,
      lockSentInvoices: clientSettings?.lockSentInvoices ??
          groupSettings?.lockSentInvoices ??
          companySettings?.lockSentInvoices,
      autoArchiveInvoice: clientSettings?.autoArchiveInvoice ??
          groupSettings?.autoArchiveInvoice ??
          companySettings?.autoArchiveInvoice,
      autoArchiveQuote: clientSettings?.autoArchiveQuote ??
          groupSettings?.autoArchiveQuote ??
          companySettings?.autoArchiveQuote,
      autoEmailInvoice: clientSettings?.autoEmailInvoice ??
          groupSettings?.autoEmailInvoice ??
          companySettings?.autoEmailInvoice,
      autoConvertQuote: clientSettings?.autoConvertQuote ??
          groupSettings?.autoConvertQuote ??
          companySettings?.autoConvertQuote,
      enableInclusiveTaxes: clientSettings?.enableInclusiveTaxes ??
          groupSettings?.enableInclusiveTaxes ??
          companySettings?.enableInclusiveTaxes,
      translations: clientSettings?.translations ??
          groupSettings?.translations ??
          companySettings?.translations,
      taskNumberPattern: clientSettings?.taskNumberPattern ??
          groupSettings?.taskNumberPattern ??
          companySettings?.taskNumberPattern,
      taskNumberCounter: clientSettings?.taskNumberCounter ??
          groupSettings?.taskNumberCounter ??
          companySettings?.taskNumberCounter,
      expenseNumberPattern: clientSettings?.expenseNumberPattern ??
          groupSettings?.expenseNumberPattern ??
          companySettings?.expenseNumberPattern,
      expenseNumberCounter: clientSettings?.expenseNumberCounter ??
          groupSettings?.expenseNumberCounter ??
          companySettings?.expenseNumberCounter,
      vendorNumberPattern: clientSettings?.vendorNumberPattern ??
          groupSettings?.vendorNumberPattern ??
          companySettings?.vendorNumberPattern,
      vendorNumberCounter: clientSettings?.vendorNumberCounter ??
          groupSettings?.vendorNumberCounter ??
          companySettings?.vendorNumberCounter,
      ticketNumberPattern: clientSettings?.ticketNumberPattern ??
          groupSettings?.ticketNumberPattern ??
          companySettings?.ticketNumberPattern,
      ticketNumberCounter: clientSettings?.ticketNumberCounter ??
          groupSettings?.ticketNumberCounter ??
          companySettings?.ticketNumberCounter,
      paymentNumberPattern: clientSettings?.paymentNumberPattern ??
          groupSettings?.paymentNumberPattern ??
          companySettings?.paymentNumberPattern,
      paymentNumberCounter: clientSettings?.paymentNumberCounter ??
          groupSettings?.paymentNumberCounter ??
          companySettings?.paymentNumberCounter,
      invoiceNumberPattern: clientSettings?.invoiceNumberPattern ??
          groupSettings?.invoiceNumberPattern ??
          companySettings?.invoiceNumberPattern,
      invoiceNumberCounter: clientSettings?.invoiceNumberCounter ??
          groupSettings?.invoiceNumberCounter ??
          companySettings?.invoiceNumberCounter,
      quoteNumberPattern: clientSettings?.quoteNumberPattern ??
          groupSettings?.quoteNumberPattern ??
          companySettings?.quoteNumberPattern,
      quoteNumberCounter: clientSettings?.quoteNumberCounter ??
          groupSettings?.quoteNumberCounter ??
          companySettings?.quoteNumberCounter,
      clientNumberPattern: clientSettings?.clientNumberPattern ??
          groupSettings?.clientNumberPattern ??
          companySettings?.clientNumberPattern,
      clientNumberCounter: clientSettings?.clientNumberCounter ??
          groupSettings?.clientNumberCounter ??
          companySettings?.clientNumberCounter,
      creditNumberPattern: clientSettings?.creditNumberPattern ??
          groupSettings?.creditNumberPattern ??
          companySettings?.creditNumberPattern,
      creditNumberCounter: clientSettings?.creditNumberCounter ??
          groupSettings?.creditNumberCounter ??
          companySettings?.creditNumberCounter,
      recurringNumberPrefix: clientSettings?.recurringNumberPrefix ??
          groupSettings?.recurringNumberPrefix ??
          companySettings?.recurringNumberPrefix,
      resetCounterFrequencyId: clientSettings?.resetCounterFrequencyId ??
          groupSettings?.resetCounterFrequencyId ??
          companySettings?.resetCounterFrequencyId,
      resetCounterDate: clientSettings?.resetCounterDate ??
          groupSettings?.resetCounterDate ??
          companySettings?.resetCounterDate,
      counterPadding: clientSettings?.counterPadding ??
          groupSettings?.counterPadding ??
          companySettings?.counterPadding,
      sharedInvoiceQuoteCounter: clientSettings?.sharedInvoiceQuoteCounter ??
          groupSettings?.sharedInvoiceQuoteCounter ??
          companySettings?.sharedInvoiceQuoteCounter,
      defaultInvoiceTerms: clientSettings?.defaultInvoiceTerms ??
          groupSettings?.defaultInvoiceTerms ??
          companySettings?.defaultInvoiceTerms,
      defaultQuoteTerms: clientSettings?.defaultQuoteTerms ??
          groupSettings?.defaultQuoteTerms ??
          companySettings?.defaultQuoteTerms,
      defaultQuoteFooter: clientSettings?.defaultQuoteFooter ??
          groupSettings?.defaultQuoteFooter ??
          companySettings?.defaultQuoteFooter,
      defaultInvoiceDesignId: clientSettings?.defaultInvoiceDesignId ??
          groupSettings?.defaultInvoiceDesignId ??
          companySettings?.defaultInvoiceDesignId,
      defaultQuoteDesignId: clientSettings?.defaultQuoteDesignId ??
          groupSettings?.defaultQuoteDesignId ??
          companySettings?.defaultQuoteDesignId,
      defaultCreditDesignId: clientSettings?.defaultCreditDesignId ??
          groupSettings?.defaultCreditDesignId ??
          companySettings?.defaultCreditDesignId,
      defaultInvoiceFooter: clientSettings?.defaultInvoiceFooter ??
          groupSettings?.defaultInvoiceFooter ??
          companySettings?.defaultInvoiceFooter,
      invoiceLabels: clientSettings?.invoiceLabels ??
          groupSettings?.invoiceLabels ??
          companySettings?.invoiceLabels,
      defaultTaxName1: clientSettings?.defaultTaxName1 ??
          groupSettings?.defaultTaxName1 ??
          companySettings?.defaultTaxName1,
      defaultTaxRate1: clientSettings?.defaultTaxRate1 ??
          groupSettings?.defaultTaxRate1 ??
          companySettings?.defaultTaxRate1,
      defaultTaxName2: clientSettings?.defaultTaxName2 ??
          groupSettings?.defaultTaxName2 ??
          companySettings?.defaultTaxName2,
      defaultTaxRate2: clientSettings?.defaultTaxRate2 ??
          groupSettings?.defaultTaxRate2 ??
          companySettings?.defaultTaxRate2,
      defaultTaxName3: clientSettings?.defaultTaxName3 ??
          groupSettings?.defaultTaxName3 ??
          companySettings?.defaultTaxName3,
      defaultTaxRate3: clientSettings?.defaultTaxRate3 ??
          groupSettings?.defaultTaxRate3 ??
          companySettings?.defaultTaxRate3,
      defaultPaymentTypeId: clientSettings?.defaultPaymentTypeId ??
          groupSettings?.defaultPaymentTypeId ??
          companySettings?.defaultPaymentTypeId,
      invoiceFields: clientSettings?.invoiceFields ??
          groupSettings?.invoiceFields ??
          companySettings?.invoiceFields,
      emailSignature: clientSettings?.emailSignature ??
          groupSettings?.emailSignature ??
          companySettings?.emailSignature,
      emailSubjectInvoice: clientSettings?.emailSubjectInvoice ??
          groupSettings?.emailSubjectInvoice ??
          companySettings?.emailSubjectInvoice,
      emailSubjectQuote: clientSettings?.emailSubjectQuote ??
          groupSettings?.emailSubjectQuote ??
          companySettings?.emailSubjectQuote,
      emailSubjectPayment: clientSettings?.emailSubjectPayment ??
          groupSettings?.emailSubjectPayment ??
          companySettings?.emailSubjectPayment,
      emailSubjectPaymentPartial: clientSettings?.emailSubjectPaymentPartial ??
          groupSettings?.emailSubjectPaymentPartial ??
          companySettings?.emailSubjectPaymentPartial,
      emailBodyInvoice: clientSettings?.emailBodyInvoice ??
          groupSettings?.emailBodyInvoice ??
          companySettings?.emailBodyInvoice,
      emailBodyQuote: clientSettings?.emailBodyQuote ??
          groupSettings?.emailBodyQuote ??
          companySettings?.emailBodyQuote,
      emailBodyPayment: clientSettings?.emailBodyPayment ??
          groupSettings?.emailBodyPayment ??
          companySettings?.emailBodyPayment,
      emailBodyPaymentPartial: clientSettings?.emailBodyPaymentPartial ??
          groupSettings?.emailBodyPaymentPartial ??
          companySettings?.emailBodyPaymentPartial,
      emailSubjectReminder1: clientSettings?.emailSubjectReminder1 ??
          groupSettings?.emailSubjectReminder1 ??
          companySettings?.emailSubjectReminder1,
      emailSubjectReminder2: clientSettings?.emailSubjectReminder2 ??
          groupSettings?.emailSubjectReminder2 ??
          companySettings?.emailSubjectReminder2,
      emailSubjectReminder3: clientSettings?.emailSubjectReminder3 ??
          groupSettings?.emailSubjectReminder3 ??
          companySettings?.emailSubjectReminder3,
      emailBodyReminder1: clientSettings?.emailBodyReminder1 ??
          groupSettings?.emailBodyReminder1 ??
          companySettings?.emailBodyReminder1,
      emailBodyReminder2: clientSettings?.emailBodyReminder2 ??
          groupSettings?.emailBodyReminder2 ??
          companySettings?.emailBodyReminder2,
      emailBodyReminder3: clientSettings?.emailBodyReminder3 ??
          groupSettings?.emailBodyReminder3 ??
          companySettings?.emailBodyReminder3,
      enablePortalPassword: clientSettings?.enablePortalPassword ??
          groupSettings?.enablePortalPassword ??
          companySettings?.enablePortalPassword,
      signatureOnPdf: clientSettings?.signatureOnPdf ??
          groupSettings?.signatureOnPdf ??
          companySettings?.signatureOnPdf,
      enableEmailMarkup: clientSettings?.enableEmailMarkup ??
          groupSettings?.enableEmailMarkup ??
          companySettings?.enableEmailMarkup,
      showAcceptInvoiceTerms: clientSettings?.showAcceptInvoiceTerms ??
          groupSettings?.showAcceptInvoiceTerms ??
          companySettings?.showAcceptInvoiceTerms,
      showAcceptQuoteTerms: clientSettings?.showAcceptQuoteTerms ??
          groupSettings?.showAcceptQuoteTerms ??
          companySettings?.showAcceptQuoteTerms,
      requireInvoiceSignature: clientSettings?.requireInvoiceSignature ??
          groupSettings?.requireInvoiceSignature ??
          companySettings?.requireInvoiceSignature,
      requireQuoteSignature: clientSettings?.requireQuoteSignature ??
          groupSettings?.requireQuoteSignature ??
          companySettings?.requireQuoteSignature,
      name:
          clientSettings?.name ?? groupSettings?.name ?? companySettings?.name,
      companyLogo: clientSettings?.companyLogo ??
          groupSettings?.companyLogo ??
          companySettings?.companyLogo,
      website: clientSettings?.website ??
          groupSettings?.website ??
          companySettings?.website,
      address1: clientSettings?.address1 ??
          groupSettings?.address1 ??
          companySettings?.address1,
      address2: clientSettings?.address2 ??
          groupSettings?.address2 ??
          companySettings?.address2,
      city:
          clientSettings?.city ?? groupSettings?.city ?? companySettings?.city,
      state: clientSettings?.state ??
          groupSettings?.state ??
          companySettings?.state,
      postalCode: clientSettings?.postalCode ??
          groupSettings?.postalCode ??
          companySettings?.postalCode,
      phone: clientSettings?.phone ??
          groupSettings?.phone ??
          companySettings?.phone,
      email: clientSettings?.email ??
          groupSettings?.email ??
          companySettings?.email,
      countryId: clientSettings?.countryId ??
          groupSettings?.countryId ??
          companySettings?.countryId,
      vatNumber: clientSettings?.vatNumber ??
          groupSettings?.vatNumber ??
          companySettings?.vatNumber,
      idNumber: clientSettings?.idNumber ??
          groupSettings?.idNumber ??
          companySettings?.idNumber,
      pageSize: clientSettings?.pageSize ??
          groupSettings?.pageSize ??
          companySettings?.pageSize,
      fontSize: clientSettings?.fontSize ??
          groupSettings?.fontSize ??
          companySettings?.fontSize,
      primaryColor: clientSettings?.primaryColor ??
          groupSettings?.primaryColor ??
          companySettings?.primaryColor,
      secondaryColor: clientSettings?.secondaryColor ??
          groupSettings?.secondaryColor ??
          companySettings?.secondaryColor,
      primaryFont: clientSettings?.primaryFont ??
          groupSettings?.primaryFont ??
          companySettings?.primaryFont,
      secondaryFont: clientSettings?.secondaryFont ??
          groupSettings?.secondaryFont ??
          companySettings?.secondaryFont,
      hidePaidToDate: clientSettings?.hidePaidToDate ??
          groupSettings?.hidePaidToDate ??
          companySettings?.hidePaidToDate,
      embedDocuments: clientSettings?.embedDocuments ??
          groupSettings?.embedDocuments ??
          companySettings?.embedDocuments,
      allPagesHeader: clientSettings?.allPagesHeader ??
          groupSettings?.allPagesHeader ??
          companySettings?.allPagesHeader,
      allPagesFooter: clientSettings?.allPagesFooter ??
          groupSettings?.allPagesFooter ??
          companySettings?.allPagesFooter,
      enableReminder1: clientSettings?.enableReminder1 ??
          groupSettings?.enableReminder1 ??
          companySettings?.enableReminder1,
      enableReminder2: clientSettings?.enableReminder2 ??
          groupSettings?.enableReminder2 ??
          companySettings?.enableReminder2,
      enableReminder3: clientSettings?.enableReminder3 ??
          groupSettings?.enableReminder3 ??
          companySettings?.enableReminder3,
      enableReminder4: clientSettings?.enableReminder4 ??
          groupSettings?.enableReminder4 ??
          companySettings?.enableReminder4,
      numDaysReminder1: clientSettings?.numDaysReminder1 ??
          groupSettings?.numDaysReminder1 ??
          companySettings?.numDaysReminder1,
      numDaysReminder2: clientSettings?.numDaysReminder2 ??
          groupSettings?.numDaysReminder2 ??
          companySettings?.numDaysReminder2,
      numDaysReminder3: clientSettings?.numDaysReminder3 ??
          groupSettings?.numDaysReminder3 ??
          companySettings?.numDaysReminder3,
      scheduleReminder1: clientSettings?.scheduleReminder1 ??
          groupSettings?.scheduleReminder1 ??
          companySettings?.scheduleReminder1,
      scheduleReminder2: clientSettings?.scheduleReminder2 ??
          groupSettings?.scheduleReminder2 ??
          companySettings?.scheduleReminder2,
      scheduleReminder3: clientSettings?.scheduleReminder3 ??
          groupSettings?.scheduleReminder3 ??
          companySettings?.scheduleReminder3,
      endlessReminderFrequencyId: clientSettings?.endlessReminderFrequencyId ??
          groupSettings?.endlessReminderFrequencyId ??
          companySettings?.endlessReminderFrequencyId,
      lateFeeAmount1: clientSettings?.lateFeeAmount1 ??
          groupSettings?.lateFeeAmount1 ??
          companySettings?.lateFeeAmount1,
      lateFeeAmount2: clientSettings?.lateFeeAmount2 ??
          groupSettings?.lateFeeAmount2 ??
          companySettings?.lateFeeAmount2,
      lateFeeAmount3: clientSettings?.lateFeeAmount3 ??
          groupSettings?.lateFeeAmount3 ??
          companySettings?.lateFeeAmount3,
      lateFeeAmountEndless: clientSettings?.lateFeeAmountEndless ??
          groupSettings?.lateFeeAmountEndless ??
          companySettings?.lateFeeAmountEndless,
      lateFeePercent1: clientSettings?.lateFeePercent1 ??
          groupSettings?.lateFeePercent1 ??
          companySettings?.lateFeePercent1,
      lateFeePercent2: clientSettings?.lateFeePercent2 ??
          groupSettings?.lateFeePercent2 ??
          companySettings?.lateFeePercent2,
      lateFeePercent3: clientSettings?.lateFeePercent3 ??
          groupSettings?.lateFeePercent3 ??
          companySettings?.lateFeePercent3,
      lateFeePercentEndless: clientSettings?.lateFeePercentEndless ??
          groupSettings?.lateFeePercentEndless ??
          companySettings?.lateFeePercentEndless,
      emailSubjectReminder4: clientSettings?.emailSubjectReminder4 ??
          groupSettings?.emailSubjectReminder4 ??
          companySettings?.emailSubjectReminder4,
      emailBodyReminder4: clientSettings?.emailBodyReminder4 ??
          groupSettings?.emailBodyReminder4 ??
          companySettings?.emailBodyReminder4,
      customPaymentTerms: clientSettings?.customPaymentTerms ??
          groupSettings?.customPaymentTerms ??
          companySettings?.customPaymentTerms,
      pdfVariables: clientSettings?.pdfVariables ??
          groupSettings?.pdfVariables ??
          companySettings?.pdfVariables,
      emailSendingMethod: clientSettings?.emailSendingMethod ??
          groupSettings?.emailSendingMethod ??
          companySettings?.emailSendingMethod,
      gmailSendingUserId: clientSettings?.gmailSendingUserId ??
          groupSettings?.gmailSendingUserId ??
          companySettings?.gmailSendingUserId,
      autoBill: clientSettings?.autoBill ??
          groupSettings?.autoBill ??
          companySettings?.autoBill,
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
  @BuiltValueField(wireName: 'email_style')
  String get emailStyle;

  @nullable
  @BuiltValueField(wireName: 'reply_to_email')
  String get replyToEmail;

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
  @BuiltValueField(wireName: 'lock_sent_invoices')
  bool get lockSentInvoices;

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
  @BuiltValueField(wireName: 'invoice_number_pattern')
  String get invoiceNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'invoice_number_counter')
  int get invoiceNumberCounter;

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
  @BuiltValueField(wireName: 'invoice_labels')
  String get invoiceLabels;

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
  @BuiltValueField(wireName: 'invoice_fields')
  String get invoiceFields;

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
  @BuiltValueField(wireName: 'enable_reminder4')
  bool get enableReminder4;

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
  @BuiltValueField(wireName: 'email_subject_reminder4')
  String get emailSubjectReminder4;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder4')
  String get emailBodyReminder4;

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

  // TODO remove this field
  @nullable
  @BuiltValueField(wireName: 'custom_payment_terms')
  BuiltList<PaymentTermEntity> get customPaymentTerms;

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
      case EmailTemplate.payment:
        return emailSubjectPayment;
      case EmailTemplate.partial_payment:
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
      case EmailTemplate.payment:
        return emailBodyPayment;
      case EmailTemplate.partial_payment:
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

  bool hasInvoiceField(String field,
      [EntityType entityType = EntityType.product]) {
    if (invoiceFields != null && invoiceFields.isNotEmpty) {
      return invoiceFields.contains('$entityType.$field');
    } else if (field == 'discount') {
      return false;
    } else {
      return true;
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
