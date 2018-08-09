import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'company_model.g.dart';

abstract class CompanyEntity
    implements Built<CompanyEntity, CompanyEntityBuilder> {
  factory CompanyEntity() {
    return _$CompanyEntity._(
      name: '',
      token: '',
      plan: '',
      logoUrl: '',
      convertProductExchangeRate: false,
      currencyId: 1,
      dateFormatId: 1,
      datetimeFormatId: 1,
      defaultInvoiceDesignId: 1,
      defaultInvoiceFooter: '',
      defaultInvoiceTerms: '',
      defaultPaymentTerms: 0,
      defaultPaymentTypeId: 0,
      defaultQuoteDesignId: 1,
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
      languageId: 1,
      showCurrencyCode: false,
      showInvoiceItemTaxes: false,
      startOfWeek: 1,
      timezoneId: 1,
      customPaymentTerms: BuiltList<PaymentTermEntity>(),
      taxRates: BuiltList<TaxRateEntity>(),
      users: BuiltList<UserEntity>(),
      userMap: BuiltMap<int, UserEntity>(),
      customFields: BuiltMap<String, String>(),
      invoiceFields: '',
      countryId: kCountryUnitedStates,
    );
  }

  CompanyEntity._();

  String get name;

  String get token;

  String get plan;

  @BuiltValueField(wireName: 'logo_url')
  String get logoUrl;

  @BuiltValueField(wireName: 'currency_id')
  int get currencyId;

  @BuiltValueField(wireName: 'timezone_id')
  int get timezoneId;

  @BuiltValueField(wireName: 'country_id')
  int get countryId;

  @BuiltValueField(wireName: 'date_format_id')
  int get dateFormatId;

  @BuiltValueField(wireName: 'datetime_format_id')
  int get datetimeFormatId;

  @BuiltValueField(wireName: 'invoice_terms')
  String get defaultInvoiceTerms;

  @BuiltValueField(wireName: 'invoice_taxes')
  bool get enableInvoiceTaxes;

  @BuiltValueField(wireName: 'invoice_item_taxes')
  bool get enableInvoiceItemTaxes;

  @BuiltValueField(wireName: 'invoice_design_id')
  int get defaultInvoiceDesignId;

  @BuiltValueField(wireName: 'quote_design_id')
  int get defaultQuoteDesignId;

  @BuiltValueField(wireName: 'language_id')
  int get languageId;

  @BuiltValueField(wireName: 'invoice_footer')
  String get defaultInvoiceFooter;

  @BuiltValueField(wireName: 'show_item_taxes')
  bool get showInvoiceItemTaxes;

  @BuiltValueField(wireName: 'military_time')
  bool get enableMilitaryTime;

  @BuiltValueField(wireName: 'tax_name1')
  String get defaultTaxName1;

  @BuiltValueField(wireName: 'tax_rate1')
  double get defaultTaxRate1;

  @BuiltValueField(wireName: 'tax_name2')
  String get defaultTaxName2;

  @BuiltValueField(wireName: 'tax_rate2')
  double get defaultTaxRate2;

  @BuiltValueField(wireName: 'quote_terms')
  String get defaultQuoteTerms;

  @BuiltValueField(wireName: 'show_currency_code')
  bool get showCurrencyCode;

  @BuiltValueField(wireName: 'enable_second_tax_rate')
  bool get enableSecondTaxRate;

  @BuiltValueField(wireName: 'start_of_week')
  int get startOfWeek;

  @BuiltValueField(wireName: 'financial_year_start')
  int get financialYearStart;

  @BuiltValueField(wireName: 'enabled_modules')
  int get enabledModules;

  @BuiltValueField(wireName: 'payment_terms')
  int get defaultPaymentTerms;

  @BuiltValueField(wireName: 'payment_type_id')
  int get defaultPaymentTypeId;

  @BuiltValueField(wireName: 'task_rate')
  double get defaultTaskRate;

  @BuiltValueField(wireName: 'inclusive_taxes')
  bool get enableInclusiveTaxes;

  @BuiltValueField(wireName: 'convert_products')
  bool get convertProductExchangeRate;

  @BuiltValueField(wireName: 'custom_invoice_taxes1')
  bool get enableCustomInvoiceTaxes1;

  @BuiltValueField(wireName: 'custom_invoice_taxes2')
  bool get enableCustomInvoiceTaxes2;

  @BuiltValueField(wireName: 'tax_rates')
  BuiltList<TaxRateEntity> get taxRates;

  @BuiltValueField(wireName: 'users')
  BuiltList<UserEntity> get users;

  BuiltMap<int, UserEntity> get userMap;

  @BuiltValueField(wireName: 'custom_fields')
  BuiltMap<String, String> get customFields;

  @BuiltValueField(wireName: 'custom_payment_terms')
  BuiltList<PaymentTermEntity> get customPaymentTerms;

  @BuiltValueField(wireName: 'invoice_fields')
  String get invoiceFields;

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

  List<String> getCustomFieldValues(String field) {
    final values = customFields[field];

    if (values == null || !values.contains('|')) {
      return [];
    } else {
      return values.split('|').last.split(',');
    }
  }

  static Serializer<CompanyEntity> get serializer => _$companyEntitySerializer;
}

abstract class PaymentTermEntity extends Object
    with SelectableEntity
    implements Built<PaymentTermEntity, PaymentTermEntityBuilder> {
  static int counter = 0;

  factory PaymentTermEntity() {
    return _$PaymentTermEntity._(
      id: --PaymentTermEntity.counter,
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
  static int counter = 0;

  factory TaxRateEntity() {
    return _$TaxRateEntity._(
      id: --TaxRateEntity.counter,
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
  factory UserEntity([void updates(UserEntityBuilder b)]) = _$UserEntity;

  UserEntity._();

  int get id;

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get fullName => (firstName + ' ' + lastName).trim();

  static Serializer<UserEntity> get serializer => _$userEntitySerializer;
}
