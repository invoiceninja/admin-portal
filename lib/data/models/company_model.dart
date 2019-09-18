import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';

part 'company_model.g.dart';

abstract class CompanyEntity
    implements Built<CompanyEntity, CompanyEntityBuilder> {
  factory CompanyEntity() {
    return _$CompanyEntity._(
      companyKey: '',
      name: '',
      plan: '',
      settings: SettingsEntity(),
      logoUrl: '',
      appUrl: '',
      convertProductExchangeRate: false,
      companyCurrencyId: '1',
      dateFormatId: '1',
      datetimeFormatId: '1',
      defaultInvoiceDesignId: '1',
      defaultInvoiceFooter: '',
      defaultInvoiceTerms: '',
      defaultPaymentTerms: 0,
      defaultPaymentTypeId: '',
      defaultQuoteDesignId: '1',
      defaultQuoteTerms: '',
      defaultTaskRate: 0.0,
      defaultTaxName1: '',
      defaultTaxRate1: 0.0,
      defaultTaxName2: '',
      defaultTaxRate2: 0.0,
      enableCustomInvoiceTaxes1: false,
      enableCustomInvoiceTaxes2: false,
      enabledModules: 0,
      enableInclusiveTaxes: false,
      enableInvoiceItemTaxes: false,
      enableInvoiceTaxes: true,
      enableMilitaryTime: false,
      enableSecondTaxRate: false,
      financialYearStart: 1,
      languageId: kLanguageEnglish,
      showCurrencyCode: false,
      showInvoiceItemTaxes: false,
      startOfWeek: 1,
      timezoneId: '1',
      // TODO set to default EST timezone
      customPaymentTerms: BuiltList<PaymentTermEntity>(),
      taxRates: BuiltList<TaxRateEntity>(),
      taskStatuses: BuiltList<TaskStatusEntity>(),
      taskStatusMap: BuiltMap<String, TaskStatusEntity>(),
      expenseCategories: BuiltList<ExpenseCategoryEntity>(),
      expenseCategoryMap: BuiltMap<String, ExpenseCategoryEntity>(),
      users: BuiltList<UserEntity>(),
      userMap: BuiltMap<String, UserEntity>(),
      customFields: BuiltMap<String, String>(),
      invoiceFields: '',
      countryId: kCountryUnitedStates,
      emailFooter: '',
      emailSubjectInvoice: '',
      emailSubjectQuote: '',
      emailSubjectPayment: '',
      emailBodyInvoice: '',
      emailBodyQuote: '',
      emailBodyPayment: '',
      emailSubjectReminder1: '',
      emailSubjectReminder2: '',
      emailSubjectReminder3: '',
      emailBodyReminder1: '',
      emailBodyReminder2: '',
      emailBodyReminder3: '',
      fillProducts: true,
      enablePortalPassword: false,
      hasCustomDesign1: false,
      hasCustomDesign2: false,
      hasCustomDesign3: false,
    );
  }

  CompanyEntity._();

  String get name;

  // TODO remove this
  @nullable
  String get plan;

  @BuiltValueField(wireName: 'company_key')
  String get companyKey;

  @nullable
  @BuiltValueField(wireName: 'logo')
  String get logoUrl;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'default_url')
  String get appUrl;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'currency_id')
  String get companyCurrencyId;

  SettingsEntity get settings;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'timezone_id')
  String get timezoneId;

  @BuiltValueField(wireName: 'country_id')
  String get countryId;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'date_format_id')
  String get dateFormatId;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'datetime_format_id')
  String get datetimeFormatId;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'invoice_terms')
  String get defaultInvoiceTerms;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'invoice_taxes')
  bool get enableInvoiceTaxes;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'invoice_item_taxes')
  bool get enableInvoiceItemTaxes;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'invoice_design_id')
  String get defaultInvoiceDesignId;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'quote_design_id')
  String get defaultQuoteDesignId;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'language_id')
  String get languageId;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'invoice_footer')
  String get defaultInvoiceFooter;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'show_item_taxes')
  bool get showInvoiceItemTaxes;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'military_time')
  bool get enableMilitaryTime;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'tax_name1')
  String get defaultTaxName1;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'tax_rate1')
  double get defaultTaxRate1;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'tax_name2')
  String get defaultTaxName2;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'tax_rate2')
  double get defaultTaxRate2;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'quote_terms')
  String get defaultQuoteTerms;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'show_currency_code')
  bool get showCurrencyCode;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'enable_second_tax_rate')
  bool get enableSecondTaxRate;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'start_of_week')
  int get startOfWeek;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'financial_year_start')
  int get financialYearStart;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'enabled_modules')
  int get enabledModules;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'payment_terms')
  int get defaultPaymentTerms;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'payment_type_id')
  String get defaultPaymentTypeId;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'task_rate')
  double get defaultTaskRate;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'inclusive_taxes')
  bool get enableInclusiveTaxes;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'convert_products')
  bool get convertProductExchangeRate;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'custom_invoice_taxes1')
  bool get enableCustomInvoiceTaxes1;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'custom_invoice_taxes2')
  bool get enableCustomInvoiceTaxes2;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'tax_rates')
  BuiltList<TaxRateEntity> get taxRates;

  @nullable
  @BuiltValueField(wireName: 'task_statuses')
  BuiltList<TaskStatusEntity> get taskStatuses;

  BuiltMap<String, TaskStatusEntity> get taskStatusMap;

  @nullable
  @BuiltValueField(wireName: 'expense_categories')
  BuiltList<ExpenseCategoryEntity> get expenseCategories;

  // TODO remove this
  @nullable
  BuiltMap<String, ExpenseCategoryEntity> get expenseCategoryMap;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'users')
  BuiltList<UserEntity> get users;

  // TODO remove this
  @nullable
  BuiltMap<String, UserEntity> get userMap;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'custom_fields')
  BuiltMap<String, String> get customFields;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'custom_payment_terms')
  BuiltList<PaymentTermEntity> get customPaymentTerms;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'invoice_fields')
  String get invoiceFields;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_footer')
  String get emailFooter;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_subject_invoice')
  String get emailSubjectInvoice;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_subject_quote')
  String get emailSubjectQuote;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_subject_payment')
  String get emailSubjectPayment;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_template_invoice')
  String get emailBodyInvoice;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_template_quote')
  String get emailBodyQuote;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_template_payment')
  String get emailBodyPayment;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder1')
  String get emailSubjectReminder1;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder2')
  String get emailSubjectReminder2;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder3')
  String get emailSubjectReminder3;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_template_reminder1')
  String get emailBodyReminder1;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_template_reminder2')
  String get emailBodyReminder2;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'email_template_reminder3')
  String get emailBodyReminder3;

  @nullable
  @BuiltValueField(wireName: 'fill_products')
  bool get fillProducts;

  @nullable
  @BuiltValueField(wireName: 'enable_portal_password')
  bool get enablePortalPassword;

  @nullable
  @BuiltValueField(wireName: 'has_custom_design1')
  bool get hasCustomDesign1;

  @nullable
  @BuiltValueField(wireName: 'has_custom_design2')
  bool get hasCustomDesign2;

  @nullable
  @BuiltValueField(wireName: 'has_custom_design3')
  bool get hasCustomDesign3;

  //@BuiltValueField(wireName: 'custom_messages')
  //@BuiltValueField(wireName: 'invoice_labels')

  bool hasInvoiceField(String field,
      [EntityType entityType = EntityType.product]) {
    if (invoiceFields.isNotEmpty) {
      return invoiceFields.contains('$entityType.$field');
    } else if (field == 'discount') {
      return false;
    } else {
      return true;
    }
  }

  String getCustomFieldLabel(String field) {
    if (customFields.containsKey(field)) {
      return customFields[field].split('|').first;
    } else {
      return '';
    }
  }

  List<String> getCustomFieldValues(String field, {bool excludeBlank = false}) {
    final values = customFields[field];

    if (values == null || !values.contains('|')) {
      return [];
    } else {
      final data = values.split('|').last.split(',');

      if (excludeBlank) {
        return data.where((data) => data.isNotEmpty).toList();
      } else {
        return data;
      }
    }
  }

  bool get isSelfHost =>
      appUrl != null && appUrl.isNotEmpty && appUrl != kAppUrl;

  bool get isHosted => !isSelfHost;

  bool get isProPlan => isSelfHost || plan == kPlanPro;

  bool get isEnterprisePlan => isProPlan || plan == kPlanEnterprise;

  bool isModuleEnabled(EntityType entityType) {
    if (entityType == EntityType.recurringInvoice &&
        enabledModules & kModuleRecurringInvoice == 0) {
      return false;
    } else if (entityType == EntityType.credit &&
        enabledModules & kModuleCredit == 0) {
      return false;
    } else if (entityType == EntityType.quote &&
        enabledModules & kModuleQuote == 0) {
      return false;
    } else if ([EntityType.task, EntityType.project].contains(entityType) &&
        enabledModules & kModuleTask == 0) {
      return false;
    } else if ([EntityType.expense, EntityType.vendor].contains(entityType) &&
        enabledModules & kModuleExpense == 0) {
      return false;
    }

    return true;
  }

  String get currencyId => companyCurrencyId ?? kDefaultCurrencyId;

  // Handle bug in earlier version of API
  int get firstMonthOfYear =>
      financialYearStart == 2000 ? 1 : financialYearStart;

  static Serializer<CompanyEntity> get serializer => _$companyEntitySerializer;
}

abstract class PaymentTermEntity extends Object
    with SelectableEntity
    implements Built<PaymentTermEntity, PaymentTermEntityBuilder> {
  factory PaymentTermEntity() {
    return _$PaymentTermEntity._(
      id: BaseEntity.nextId,
      numDays: 0,
    );
  }

  PaymentTermEntity._();

  static Serializer<PaymentTermEntity> get serializer =>
      _$paymentTermEntitySerializer;

  String getPaymentTerm(String netLabel) {
    if (numDays == 0) {
      return '';
    } else if (numDays == -1) {
      return '$netLabel 0';
    } else {
      return '$netLabel $numDays';
    }
  }

  @nullable
  @BuiltValueField(wireName: 'num_days')
  int get numDays;

  @nullable
  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;
}

abstract class TaxRateEntity extends Object
    with SelectableEntity
    implements Built<TaxRateEntity, TaxRateEntityBuilder> {
  factory TaxRateEntity() {
    return _$TaxRateEntity._(
      id: BaseEntity.nextId,
      name: '',
      rate: 0.0,
      isInclusive: false,
    );
  }

  TaxRateEntity._();

  static Serializer<TaxRateEntity> get serializer => _$taxRateEntitySerializer;

  String get name;

  double get rate;

  @BuiltValueField(wireName: 'is_inclusive')
  bool get isInclusive;

  @nullable
  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;
}

abstract class UserEntity implements Built<UserEntity, UserEntityBuilder> {
  factory UserEntity() {
    return _$UserEntity._(
      firstName: '',
      lastName: '',
      email: '',
      id: '',
      isAdmin: false,
      permissionsMap: BuiltMap<String, bool>(),
    );
  }

  UserEntity._();

  String get id;

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get email;

  String get fullName => (firstName + ' ' + lastName).trim();

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'is_admin')
  bool get isAdmin;

  @BuiltValueField(wireName: 'permissions')
  BuiltMap<String, bool> get permissionsMap;

  bool can(UserPermission permission, EntityType entityType) =>
      (isAdmin ?? false) ||
      permissionsMap.containsKey('${permission}_$entityType');

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
      return canEdit(entity.entityType) || (entity.isOwner ?? false);
    }
  }

  static Serializer<UserEntity> get serializer => _$userEntitySerializer;
}

abstract class UserCompanyEntity
    implements Built<UserCompanyEntity, UserCompanyEntityBuilder> {
  factory UserCompanyEntity() {
    return _$UserCompanyEntity._(
      company: CompanyEntity(),
      user: UserEntity(),
      token: TokenEntity(),
    );
  }

  UserCompanyEntity._();

  CompanyEntity get company;

  UserEntity get user;

  TokenEntity get token;

  static Serializer<UserCompanyEntity> get serializer =>
      _$userCompanyEntitySerializer;
}

abstract class TokenEntity implements Built<TokenEntity, TokenEntityBuilder> {
  factory TokenEntity() {
    return _$TokenEntity._(
      token: '',
      name: '',
    );
  }

  TokenEntity._();

  String get token;

  String get name;

  static Serializer<TokenEntity> get serializer => _$tokenEntitySerializer;
}

abstract class SettingsEntity
    implements Built<SettingsEntity, SettingsEntityBuilder> {
  factory SettingsEntity() {
    return _$SettingsEntity._(
        //timezoneId: '',
        );
  }

  SettingsEntity._();

  @BuiltValueField(wireName: 'timezone_id')
  int get timezoneIdInt;

  String get timezoneId => timezoneId.toString();

  static Serializer<SettingsEntity> get serializer =>
      _$settingsEntitySerializer;
}
