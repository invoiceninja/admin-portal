// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

const EntityType _$invoice = const EntityType._('invoice');
const EntityType _$invoiceItem = const EntityType._('invoiceItem');
const EntityType _$quote = const EntityType._('quote');
const EntityType _$product = const EntityType._('product');
const EntityType _$client = const EntityType._('client');
const EntityType _$contact = const EntityType._('contact');
const EntityType _$task = const EntityType._('task');
const EntityType _$project = const EntityType._('project');
const EntityType _$expense = const EntityType._('expense');
const EntityType _$vendor = const EntityType._('vendor');
const EntityType _$credit = const EntityType._('credit');
const EntityType _$payment = const EntityType._('payment');

EntityType _$typeValueOf(String name) {
  switch (name) {
    case 'invoice':
      return _$invoice;
    case 'invoiceItem':
      return _$invoiceItem;
    case 'quote':
      return _$quote;
    case 'product':
      return _$product;
    case 'client':
      return _$client;
    case 'contact':
      return _$contact;
    case 'task':
      return _$task;
    case 'project':
      return _$project;
    case 'expense':
      return _$expense;
    case 'vendor':
      return _$vendor;
    case 'credit':
      return _$credit;
    case 'payment':
      return _$payment;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntityType> _$typeValues =
    new BuiltSet<EntityType>(const <EntityType>[
  _$invoice,
  _$invoiceItem,
  _$quote,
  _$product,
  _$client,
  _$contact,
  _$task,
  _$project,
  _$expense,
  _$vendor,
  _$credit,
  _$payment,
]);

const EntityState _$active = const EntityState._('active');
const EntityState _$archived = const EntityState._('archived');
const EntityState _$deleted = const EntityState._('deleted');

EntityState _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'archived':
      return _$archived;
    case 'deleted':
      return _$deleted;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntityState> _$values =
    new BuiltSet<EntityState>(const <EntityState>[
  _$active,
  _$archived,
  _$deleted,
]);

Serializer<EntityType> _$entityTypeSerializer = new _$EntityTypeSerializer();
Serializer<EntityState> _$entityStateSerializer = new _$EntityStateSerializer();
Serializer<ErrorMessage> _$errorMessageSerializer =
    new _$ErrorMessageSerializer();
Serializer<LoginResponse> _$loginResponseSerializer =
    new _$LoginResponseSerializer();
Serializer<LoginResponseData> _$loginResponseDataSerializer =
    new _$LoginResponseDataSerializer();
Serializer<StaticData> _$staticDataSerializer = new _$StaticDataSerializer();
Serializer<CompanyEntity> _$companyEntitySerializer =
    new _$CompanyEntitySerializer();
Serializer<DashboardResponse> _$dashboardResponseSerializer =
    new _$DashboardResponseSerializer();
Serializer<DashboardEntity> _$dashboardEntitySerializer =
    new _$DashboardEntitySerializer();

class _$EntityTypeSerializer implements PrimitiveSerializer<EntityType> {
  @override
  final Iterable<Type> types = const <Type>[EntityType];
  @override
  final String wireName = 'EntityType';

  @override
  Object serialize(Serializers serializers, EntityType object,
          {FullType specifiedType: FullType.unspecified}) =>
      object.name;

  @override
  EntityType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      EntityType.valueOf(serialized as String);
}

class _$EntityStateSerializer implements PrimitiveSerializer<EntityState> {
  @override
  final Iterable<Type> types = const <Type>[EntityState];
  @override
  final String wireName = 'EntityState';

  @override
  Object serialize(Serializers serializers, EntityState object,
          {FullType specifiedType: FullType.unspecified}) =>
      object.name;

  @override
  EntityState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      EntityState.valueOf(serialized as String);
}

class _$ErrorMessageSerializer implements StructuredSerializer<ErrorMessage> {
  @override
  final Iterable<Type> types = const [ErrorMessage, _$ErrorMessage];
  @override
  final String wireName = 'ErrorMessage';

  @override
  Iterable serialize(Serializers serializers, ErrorMessage object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ErrorMessage deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ErrorMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LoginResponseSerializer implements StructuredSerializer<LoginResponse> {
  @override
  final Iterable<Type> types = const [LoginResponse, _$LoginResponse];
  @override
  final String wireName = 'LoginResponse';

  @override
  Iterable serialize(Serializers serializers, LoginResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(LoginResponseData)),
    ];
    if (object.error != null) {
      result
        ..add('error')
        ..add(serializers.serialize(object.error,
            specifiedType: const FullType(ErrorMessage)));
    }

    return result;
  }

  @override
  LoginResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new LoginResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(LoginResponseData))
              as LoginResponseData);
          break;
        case 'error':
          result.error.replace(serializers.deserialize(value,
              specifiedType: const FullType(ErrorMessage)) as ErrorMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$LoginResponseDataSerializer
    implements StructuredSerializer<LoginResponseData> {
  @override
  final Iterable<Type> types = const [LoginResponseData, _$LoginResponseData];
  @override
  final String wireName = 'LoginResponseData';

  @override
  Iterable serialize(Serializers serializers, LoginResponseData object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'accounts',
      serializers.serialize(object.accounts,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CompanyEntity)])),
      'version',
      serializers.serialize(object.version,
          specifiedType: const FullType(String)),
      'static',
      serializers.serialize(object.static,
          specifiedType: const FullType(StaticData)),
    ];

    return result;
  }

  @override
  LoginResponseData deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new LoginResponseDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'accounts':
          result.accounts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CompanyEntity)]))
              as BuiltList);
          break;
        case 'version':
          result.version = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'static':
          result.static.replace(serializers.deserialize(value,
              specifiedType: const FullType(StaticData)) as StaticData);
          break;
      }
    }

    return result.build();
  }
}

class _$StaticDataSerializer implements StructuredSerializer<StaticData> {
  @override
  final Iterable<Type> types = const [StaticData, _$StaticData];
  @override
  final String wireName = 'StaticData';

  @override
  Iterable serialize(Serializers serializers, StaticData object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'currencies',
      serializers.serialize(object.currencies,
          specifiedType: const FullType(
              BuiltList, const [const FullType(CurrencyEntity)])),
      'sizes',
      serializers.serialize(object.sizes,
          specifiedType:
              const FullType(BuiltList, const [const FullType(SizeEntity)])),
      'industries',
      serializers.serialize(object.industries,
          specifiedType: const FullType(
              BuiltList, const [const FullType(IndustryEntity)])),
      'timezones',
      serializers.serialize(object.timezones,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TimezoneEntity)])),
      'dateFormats',
      serializers.serialize(object.dateFormats,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DateFormatEntity)])),
      'datetimeFormats',
      serializers.serialize(object.datetimeFormats,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DatetimeFormatEntity)])),
      'languages',
      serializers.serialize(object.languages,
          specifiedType: const FullType(
              BuiltList, const [const FullType(LanguageEntity)])),
      'paymentTypes',
      serializers.serialize(object.paymentTypes,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTypeEntity)])),
      'countries',
      serializers.serialize(object.countries,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CountryEntity)])),
      'invoiceStatus',
      serializers.serialize(object.invoiceStatus,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceStatusEntity)])),
      'frequencies',
      serializers.serialize(object.frequencies,
          specifiedType: const FullType(
              BuiltList, const [const FullType(FrequencyEntity)])),
    ];

    return result;
  }

  @override
  StaticData deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new StaticDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currencies':
          result.currencies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CurrencyEntity)]))
              as BuiltList);
          break;
        case 'sizes':
          result.sizes.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(SizeEntity)])) as BuiltList);
          break;
        case 'industries':
          result.industries.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(IndustryEntity)]))
              as BuiltList);
          break;
        case 'timezones':
          result.timezones.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimezoneEntity)]))
              as BuiltList);
          break;
        case 'dateFormats':
          result.dateFormats.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DateFormatEntity)]))
              as BuiltList);
          break;
        case 'datetimeFormats':
          result.datetimeFormats.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DatetimeFormatEntity)]))
              as BuiltList);
          break;
        case 'languages':
          result.languages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LanguageEntity)]))
              as BuiltList);
          break;
        case 'paymentTypes':
          result.paymentTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTypeEntity)]))
              as BuiltList);
          break;
        case 'countries':
          result.countries.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CountryEntity)]))
              as BuiltList);
          break;
        case 'invoiceStatus':
          result.invoiceStatus.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceStatusEntity)]))
              as BuiltList);
          break;
        case 'frequencies':
          result.frequencies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(FrequencyEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyEntitySerializer implements StructuredSerializer<CompanyEntity> {
  @override
  final Iterable<Type> types = const [CompanyEntity, _$CompanyEntity];
  @override
  final String wireName = 'CompanyEntity';

  @override
  Iterable serialize(Serializers serializers, CompanyEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'plan',
      serializers.serialize(object.plan, specifiedType: const FullType(String)),
      'logo_url',
      serializers.serialize(object.logoUrl,
          specifiedType: const FullType(String)),
      'currency_id',
      serializers.serialize(object.currencyId,
          specifiedType: const FullType(int)),
      'timezone_id',
      serializers.serialize(object.timezoneId,
          specifiedType: const FullType(int)),
      'date_format_id',
      serializers.serialize(object.dateFormatId,
          specifiedType: const FullType(int)),
      'datetime_format_id',
      serializers.serialize(object.datetimeFormatId,
          specifiedType: const FullType(int)),
      'invoice_terms',
      serializers.serialize(object.defaultInvoiceTerms,
          specifiedType: const FullType(String)),
      'invoice_taxes',
      serializers.serialize(object.enableInvoiceTaxes,
          specifiedType: const FullType(bool)),
      'invoice_item_taxes',
      serializers.serialize(object.enableInvoiceItemTaxes,
          specifiedType: const FullType(bool)),
      'invoice_design_id',
      serializers.serialize(object.defaultInvoiceDesignId,
          specifiedType: const FullType(int)),
      'quote_design_id',
      serializers.serialize(object.defaultQuoteDesignId,
          specifiedType: const FullType(int)),
      'language_id',
      serializers.serialize(object.languageId,
          specifiedType: const FullType(int)),
      'invoice_footer',
      serializers.serialize(object.defaultInvoiceFooter,
          specifiedType: const FullType(String)),
      'show_item_taxes',
      serializers.serialize(object.showInvoiceItemTaxes,
          specifiedType: const FullType(bool)),
      'military_time',
      serializers.serialize(object.enableMilitaryTime,
          specifiedType: const FullType(bool)),
      'tax_name1',
      serializers.serialize(object.defaultTaxName1,
          specifiedType: const FullType(String)),
      'tax_rate1',
      serializers.serialize(object.defaultTaxRate1,
          specifiedType: const FullType(double)),
      'tax_name2',
      serializers.serialize(object.defaultTaxName2,
          specifiedType: const FullType(String)),
      'tax_rate2',
      serializers.serialize(object.defaultTaxRate2,
          specifiedType: const FullType(double)),
      'quote_terms',
      serializers.serialize(object.defaultQuoteTerms,
          specifiedType: const FullType(String)),
      'show_currency_code',
      serializers.serialize(object.showCurrencyCode,
          specifiedType: const FullType(bool)),
      'enable_second_tax_rate',
      serializers.serialize(object.enableSecondTaxRate,
          specifiedType: const FullType(bool)),
      'start_of_week',
      serializers.serialize(object.startOfWeek,
          specifiedType: const FullType(int)),
      'financial_year_start',
      serializers.serialize(object.financialYearStart,
          specifiedType: const FullType(int)),
      'enabled_modules',
      serializers.serialize(object.enabledModules,
          specifiedType: const FullType(int)),
      'payment_terms',
      serializers.serialize(object.defaultPaymentTerms,
          specifiedType: const FullType(int)),
      'payment_type_id',
      serializers.serialize(object.defaultPaymentTypeId,
          specifiedType: const FullType(int)),
      'task_rate',
      serializers.serialize(object.defaultTaskRate,
          specifiedType: const FullType(double)),
      'inclusive_taxes',
      serializers.serialize(object.enableInclusiveTaxes,
          specifiedType: const FullType(bool)),
      'convert_products',
      serializers.serialize(object.convertProductExchangeRate,
          specifiedType: const FullType(bool)),
      'custom_invoice_taxes1',
      serializers.serialize(object.enableCustomInvoiceTaxes1,
          specifiedType: const FullType(bool)),
      'custom_invoice_taxes1',
      serializers.serialize(object.enableCustomInvoiceTaxes2,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  CompanyEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CompanyEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plan':
          result.plan = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'logo_url':
          result.logoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'timezone_id':
          result.timezoneId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'date_format_id':
          result.dateFormatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'datetime_format_id':
          result.datetimeFormatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_terms':
          result.defaultInvoiceTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_taxes':
          result.enableInvoiceTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_item_taxes':
          result.enableInvoiceItemTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_design_id':
          result.defaultInvoiceDesignId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'quote_design_id':
          result.defaultQuoteDesignId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'language_id':
          result.languageId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_footer':
          result.defaultInvoiceFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'show_item_taxes':
          result.showInvoiceItemTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'military_time':
          result.enableMilitaryTime = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'tax_name1':
          result.defaultTaxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate1':
          result.defaultTaxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name2':
          result.defaultTaxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate2':
          result.defaultTaxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'quote_terms':
          result.defaultQuoteTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'show_currency_code':
          result.showCurrencyCode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_second_tax_rate':
          result.enableSecondTaxRate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'start_of_week':
          result.startOfWeek = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'financial_year_start':
          result.financialYearStart = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'enabled_modules':
          result.enabledModules = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'payment_terms':
          result.defaultPaymentTerms = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'payment_type_id':
          result.defaultPaymentTypeId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'task_rate':
          result.defaultTaskRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'inclusive_taxes':
          result.enableInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'convert_products':
          result.convertProductExchangeRate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_invoice_taxes1':
          result.enableCustomInvoiceTaxes1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_invoice_taxes1':
          result.enableCustomInvoiceTaxes2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardResponseSerializer
    implements StructuredSerializer<DashboardResponse> {
  @override
  final Iterable<Type> types = const [DashboardResponse, _$DashboardResponse];
  @override
  final String wireName = 'DashboardResponse';

  @override
  Iterable serialize(Serializers serializers, DashboardResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DashboardEntity)),
    ];

    return result;
  }

  @override
  DashboardResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new DashboardResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DashboardEntity))
              as DashboardEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardEntitySerializer
    implements StructuredSerializer<DashboardEntity> {
  @override
  final Iterable<Type> types = const [DashboardEntity, _$DashboardEntity];
  @override
  final String wireName = 'DashboardEntity';

  @override
  Iterable serialize(Serializers serializers, DashboardEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.paidToDate != null) {
      result
        ..add('paidToDate')
        ..add(serializers.serialize(object.paidToDate,
            specifiedType: const FullType(double)));
    }
    if (object.paidToDateCurrency != null) {
      result
        ..add('paidToDateCurrency')
        ..add(serializers.serialize(object.paidToDateCurrency,
            specifiedType: const FullType(int)));
    }
    if (object.balances != null) {
      result
        ..add('balances')
        ..add(serializers.serialize(object.balances,
            specifiedType: const FullType(double)));
    }
    if (object.balancesCurrency != null) {
      result
        ..add('balancesCurrency')
        ..add(serializers.serialize(object.balancesCurrency,
            specifiedType: const FullType(int)));
    }
    if (object.averageInvoice != null) {
      result
        ..add('averageInvoice')
        ..add(serializers.serialize(object.averageInvoice,
            specifiedType: const FullType(double)));
    }
    if (object.averageInvoiceCurrency != null) {
      result
        ..add('averageInvoiceCurrency')
        ..add(serializers.serialize(object.averageInvoiceCurrency,
            specifiedType: const FullType(int)));
    }
    if (object.invoicesSent != null) {
      result
        ..add('invoicesSent')
        ..add(serializers.serialize(object.invoicesSent,
            specifiedType: const FullType(int)));
    }
    if (object.activeClients != null) {
      result
        ..add('activeClients')
        ..add(serializers.serialize(object.activeClients,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  DashboardEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new DashboardEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'paidToDate':
          result.paidToDate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'paidToDateCurrency':
          result.paidToDateCurrency = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'balances':
          result.balances = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'balancesCurrency':
          result.balancesCurrency = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'averageInvoice':
          result.averageInvoice = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'averageInvoiceCurrency':
          result.averageInvoiceCurrency = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoicesSent':
          result.invoicesSent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'activeClients':
          result.activeClients = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ErrorMessage extends ErrorMessage {
  @override
  final String message;

  factory _$ErrorMessage([void updates(ErrorMessageBuilder b)]) =>
      (new ErrorMessageBuilder()..update(updates)).build();

  _$ErrorMessage._({this.message}) : super._() {
    if (message == null)
      throw new BuiltValueNullFieldError('ErrorMessage', 'message');
  }

  @override
  ErrorMessage rebuild(void updates(ErrorMessageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorMessageBuilder toBuilder() => new ErrorMessageBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ErrorMessage) return false;
    return message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(0, message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ErrorMessage')
          ..add('message', message))
        .toString();
  }
}

class ErrorMessageBuilder
    implements Builder<ErrorMessage, ErrorMessageBuilder> {
  _$ErrorMessage _$v;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ErrorMessageBuilder();

  ErrorMessageBuilder get _$this {
    if (_$v != null) {
      _message = _$v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorMessage other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ErrorMessage;
  }

  @override
  void update(void updates(ErrorMessageBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ErrorMessage build() {
    final _$result = _$v ?? new _$ErrorMessage._(message: message);
    replace(_$result);
    return _$result;
  }
}

class _$LoginResponse extends LoginResponse {
  @override
  final LoginResponseData data;
  @override
  final ErrorMessage error;

  factory _$LoginResponse([void updates(LoginResponseBuilder b)]) =>
      (new LoginResponseBuilder()..update(updates)).build();

  _$LoginResponse._({this.data, this.error}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('LoginResponse', 'data');
  }

  @override
  LoginResponse rebuild(void updates(LoginResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResponseBuilder toBuilder() => new LoginResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! LoginResponse) return false;
    return data == other.data && error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, data.hashCode), error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginResponse')
          ..add('data', data)
          ..add('error', error))
        .toString();
  }
}

class LoginResponseBuilder
    implements Builder<LoginResponse, LoginResponseBuilder> {
  _$LoginResponse _$v;

  LoginResponseDataBuilder _data;
  LoginResponseDataBuilder get data =>
      _$this._data ??= new LoginResponseDataBuilder();
  set data(LoginResponseDataBuilder data) => _$this._data = data;

  ErrorMessageBuilder _error;
  ErrorMessageBuilder get error => _$this._error ??= new ErrorMessageBuilder();
  set error(ErrorMessageBuilder error) => _$this._error = error;

  LoginResponseBuilder();

  LoginResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _error = _$v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$LoginResponse;
  }

  @override
  void update(void updates(LoginResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginResponse build() {
    _$LoginResponse _$result;
    try {
      _$result = _$v ??
          new _$LoginResponse._(data: data.build(), error: _error?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LoginResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LoginResponseData extends LoginResponseData {
  @override
  final BuiltList<CompanyEntity> accounts;
  @override
  final String version;
  @override
  final StaticData static;

  factory _$LoginResponseData([void updates(LoginResponseDataBuilder b)]) =>
      (new LoginResponseDataBuilder()..update(updates)).build();

  _$LoginResponseData._({this.accounts, this.version, this.static})
      : super._() {
    if (accounts == null)
      throw new BuiltValueNullFieldError('LoginResponseData', 'accounts');
    if (version == null)
      throw new BuiltValueNullFieldError('LoginResponseData', 'version');
    if (static == null)
      throw new BuiltValueNullFieldError('LoginResponseData', 'static');
  }

  @override
  LoginResponseData rebuild(void updates(LoginResponseDataBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResponseDataBuilder toBuilder() =>
      new LoginResponseDataBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! LoginResponseData) return false;
    return accounts == other.accounts &&
        version == other.version &&
        static == other.static;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, accounts.hashCode), version.hashCode), static.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginResponseData')
          ..add('accounts', accounts)
          ..add('version', version)
          ..add('static', static))
        .toString();
  }
}

class LoginResponseDataBuilder
    implements Builder<LoginResponseData, LoginResponseDataBuilder> {
  _$LoginResponseData _$v;

  ListBuilder<CompanyEntity> _accounts;
  ListBuilder<CompanyEntity> get accounts =>
      _$this._accounts ??= new ListBuilder<CompanyEntity>();
  set accounts(ListBuilder<CompanyEntity> accounts) =>
      _$this._accounts = accounts;

  String _version;
  String get version => _$this._version;
  set version(String version) => _$this._version = version;

  StaticDataBuilder _static;
  StaticDataBuilder get static => _$this._static ??= new StaticDataBuilder();
  set static(StaticDataBuilder static) => _$this._static = static;

  LoginResponseDataBuilder();

  LoginResponseDataBuilder get _$this {
    if (_$v != null) {
      _accounts = _$v.accounts?.toBuilder();
      _version = _$v.version;
      _static = _$v.static?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResponseData other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$LoginResponseData;
  }

  @override
  void update(void updates(LoginResponseDataBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginResponseData build() {
    _$LoginResponseData _$result;
    try {
      _$result = _$v ??
          new _$LoginResponseData._(
              accounts: accounts.build(),
              version: version,
              static: static.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'accounts';
        accounts.build();

        _$failedField = 'static';
        static.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LoginResponseData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StaticData extends StaticData {
  @override
  final BuiltList<CurrencyEntity> currencies;
  @override
  final BuiltList<SizeEntity> sizes;
  @override
  final BuiltList<IndustryEntity> industries;
  @override
  final BuiltList<TimezoneEntity> timezones;
  @override
  final BuiltList<DateFormatEntity> dateFormats;
  @override
  final BuiltList<DatetimeFormatEntity> datetimeFormats;
  @override
  final BuiltList<LanguageEntity> languages;
  @override
  final BuiltList<PaymentTypeEntity> paymentTypes;
  @override
  final BuiltList<CountryEntity> countries;
  @override
  final BuiltList<InvoiceStatusEntity> invoiceStatus;
  @override
  final BuiltList<FrequencyEntity> frequencies;

  factory _$StaticData([void updates(StaticDataBuilder b)]) =>
      (new StaticDataBuilder()..update(updates)).build();

  _$StaticData._(
      {this.currencies,
      this.sizes,
      this.industries,
      this.timezones,
      this.dateFormats,
      this.datetimeFormats,
      this.languages,
      this.paymentTypes,
      this.countries,
      this.invoiceStatus,
      this.frequencies})
      : super._() {
    if (currencies == null)
      throw new BuiltValueNullFieldError('StaticData', 'currencies');
    if (sizes == null)
      throw new BuiltValueNullFieldError('StaticData', 'sizes');
    if (industries == null)
      throw new BuiltValueNullFieldError('StaticData', 'industries');
    if (timezones == null)
      throw new BuiltValueNullFieldError('StaticData', 'timezones');
    if (dateFormats == null)
      throw new BuiltValueNullFieldError('StaticData', 'dateFormats');
    if (datetimeFormats == null)
      throw new BuiltValueNullFieldError('StaticData', 'datetimeFormats');
    if (languages == null)
      throw new BuiltValueNullFieldError('StaticData', 'languages');
    if (paymentTypes == null)
      throw new BuiltValueNullFieldError('StaticData', 'paymentTypes');
    if (countries == null)
      throw new BuiltValueNullFieldError('StaticData', 'countries');
    if (invoiceStatus == null)
      throw new BuiltValueNullFieldError('StaticData', 'invoiceStatus');
    if (frequencies == null)
      throw new BuiltValueNullFieldError('StaticData', 'frequencies');
  }

  @override
  StaticData rebuild(void updates(StaticDataBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataBuilder toBuilder() => new StaticDataBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! StaticData) return false;
    return currencies == other.currencies &&
        sizes == other.sizes &&
        industries == other.industries &&
        timezones == other.timezones &&
        dateFormats == other.dateFormats &&
        datetimeFormats == other.datetimeFormats &&
        languages == other.languages &&
        paymentTypes == other.paymentTypes &&
        countries == other.countries &&
        invoiceStatus == other.invoiceStatus &&
        frequencies == other.frequencies;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, currencies.hashCode),
                                            sizes.hashCode),
                                        industries.hashCode),
                                    timezones.hashCode),
                                dateFormats.hashCode),
                            datetimeFormats.hashCode),
                        languages.hashCode),
                    paymentTypes.hashCode),
                countries.hashCode),
            invoiceStatus.hashCode),
        frequencies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticData')
          ..add('currencies', currencies)
          ..add('sizes', sizes)
          ..add('industries', industries)
          ..add('timezones', timezones)
          ..add('dateFormats', dateFormats)
          ..add('datetimeFormats', datetimeFormats)
          ..add('languages', languages)
          ..add('paymentTypes', paymentTypes)
          ..add('countries', countries)
          ..add('invoiceStatus', invoiceStatus)
          ..add('frequencies', frequencies))
        .toString();
  }
}

class StaticDataBuilder implements Builder<StaticData, StaticDataBuilder> {
  _$StaticData _$v;

  ListBuilder<CurrencyEntity> _currencies;
  ListBuilder<CurrencyEntity> get currencies =>
      _$this._currencies ??= new ListBuilder<CurrencyEntity>();
  set currencies(ListBuilder<CurrencyEntity> currencies) =>
      _$this._currencies = currencies;

  ListBuilder<SizeEntity> _sizes;
  ListBuilder<SizeEntity> get sizes =>
      _$this._sizes ??= new ListBuilder<SizeEntity>();
  set sizes(ListBuilder<SizeEntity> sizes) => _$this._sizes = sizes;

  ListBuilder<IndustryEntity> _industries;
  ListBuilder<IndustryEntity> get industries =>
      _$this._industries ??= new ListBuilder<IndustryEntity>();
  set industries(ListBuilder<IndustryEntity> industries) =>
      _$this._industries = industries;

  ListBuilder<TimezoneEntity> _timezones;
  ListBuilder<TimezoneEntity> get timezones =>
      _$this._timezones ??= new ListBuilder<TimezoneEntity>();
  set timezones(ListBuilder<TimezoneEntity> timezones) =>
      _$this._timezones = timezones;

  ListBuilder<DateFormatEntity> _dateFormats;
  ListBuilder<DateFormatEntity> get dateFormats =>
      _$this._dateFormats ??= new ListBuilder<DateFormatEntity>();
  set dateFormats(ListBuilder<DateFormatEntity> dateFormats) =>
      _$this._dateFormats = dateFormats;

  ListBuilder<DatetimeFormatEntity> _datetimeFormats;
  ListBuilder<DatetimeFormatEntity> get datetimeFormats =>
      _$this._datetimeFormats ??= new ListBuilder<DatetimeFormatEntity>();
  set datetimeFormats(ListBuilder<DatetimeFormatEntity> datetimeFormats) =>
      _$this._datetimeFormats = datetimeFormats;

  ListBuilder<LanguageEntity> _languages;
  ListBuilder<LanguageEntity> get languages =>
      _$this._languages ??= new ListBuilder<LanguageEntity>();
  set languages(ListBuilder<LanguageEntity> languages) =>
      _$this._languages = languages;

  ListBuilder<PaymentTypeEntity> _paymentTypes;
  ListBuilder<PaymentTypeEntity> get paymentTypes =>
      _$this._paymentTypes ??= new ListBuilder<PaymentTypeEntity>();
  set paymentTypes(ListBuilder<PaymentTypeEntity> paymentTypes) =>
      _$this._paymentTypes = paymentTypes;

  ListBuilder<CountryEntity> _countries;
  ListBuilder<CountryEntity> get countries =>
      _$this._countries ??= new ListBuilder<CountryEntity>();
  set countries(ListBuilder<CountryEntity> countries) =>
      _$this._countries = countries;

  ListBuilder<InvoiceStatusEntity> _invoiceStatus;
  ListBuilder<InvoiceStatusEntity> get invoiceStatus =>
      _$this._invoiceStatus ??= new ListBuilder<InvoiceStatusEntity>();
  set invoiceStatus(ListBuilder<InvoiceStatusEntity> invoiceStatus) =>
      _$this._invoiceStatus = invoiceStatus;

  ListBuilder<FrequencyEntity> _frequencies;
  ListBuilder<FrequencyEntity> get frequencies =>
      _$this._frequencies ??= new ListBuilder<FrequencyEntity>();
  set frequencies(ListBuilder<FrequencyEntity> frequencies) =>
      _$this._frequencies = frequencies;

  StaticDataBuilder();

  StaticDataBuilder get _$this {
    if (_$v != null) {
      _currencies = _$v.currencies?.toBuilder();
      _sizes = _$v.sizes?.toBuilder();
      _industries = _$v.industries?.toBuilder();
      _timezones = _$v.timezones?.toBuilder();
      _dateFormats = _$v.dateFormats?.toBuilder();
      _datetimeFormats = _$v.datetimeFormats?.toBuilder();
      _languages = _$v.languages?.toBuilder();
      _paymentTypes = _$v.paymentTypes?.toBuilder();
      _countries = _$v.countries?.toBuilder();
      _invoiceStatus = _$v.invoiceStatus?.toBuilder();
      _frequencies = _$v.frequencies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticData other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$StaticData;
  }

  @override
  void update(void updates(StaticDataBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticData build() {
    _$StaticData _$result;
    try {
      _$result = _$v ??
          new _$StaticData._(
              currencies: currencies.build(),
              sizes: sizes.build(),
              industries: industries.build(),
              timezones: timezones.build(),
              dateFormats: dateFormats.build(),
              datetimeFormats: datetimeFormats.build(),
              languages: languages.build(),
              paymentTypes: paymentTypes.build(),
              countries: countries.build(),
              invoiceStatus: invoiceStatus.build(),
              frequencies: frequencies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currencies';
        currencies.build();
        _$failedField = 'sizes';
        sizes.build();
        _$failedField = 'industries';
        industries.build();
        _$failedField = 'timezones';
        timezones.build();
        _$failedField = 'dateFormats';
        dateFormats.build();
        _$failedField = 'datetimeFormats';
        datetimeFormats.build();
        _$failedField = 'languages';
        languages.build();
        _$failedField = 'paymentTypes';
        paymentTypes.build();
        _$failedField = 'countries';
        countries.build();
        _$failedField = 'invoiceStatus';
        invoiceStatus.build();
        _$failedField = 'frequencies';
        frequencies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StaticData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CompanyEntity extends CompanyEntity {
  @override
  final String name;
  @override
  final String token;
  @override
  final String plan;
  @override
  final String logoUrl;
  @override
  final int currencyId;
  @override
  final int timezoneId;
  @override
  final int dateFormatId;
  @override
  final int datetimeFormatId;
  @override
  final String defaultInvoiceTerms;
  @override
  final bool enableInvoiceTaxes;
  @override
  final bool enableInvoiceItemTaxes;
  @override
  final int defaultInvoiceDesignId;
  @override
  final int defaultQuoteDesignId;
  @override
  final int languageId;
  @override
  final String defaultInvoiceFooter;
  @override
  final bool showInvoiceItemTaxes;
  @override
  final bool enableMilitaryTime;
  @override
  final String defaultTaxName1;
  @override
  final double defaultTaxRate1;
  @override
  final String defaultTaxName2;
  @override
  final double defaultTaxRate2;
  @override
  final String defaultQuoteTerms;
  @override
  final bool showCurrencyCode;
  @override
  final bool enableSecondTaxRate;
  @override
  final int startOfWeek;
  @override
  final int financialYearStart;
  @override
  final int enabledModules;
  @override
  final int defaultPaymentTerms;
  @override
  final int defaultPaymentTypeId;
  @override
  final double defaultTaskRate;
  @override
  final bool enableInclusiveTaxes;
  @override
  final bool convertProductExchangeRate;
  @override
  final bool enableCustomInvoiceTaxes1;
  @override
  final bool enableCustomInvoiceTaxes2;

  factory _$CompanyEntity([void updates(CompanyEntityBuilder b)]) =>
      (new CompanyEntityBuilder()..update(updates)).build();

  _$CompanyEntity._(
      {this.name,
      this.token,
      this.plan,
      this.logoUrl,
      this.currencyId,
      this.timezoneId,
      this.dateFormatId,
      this.datetimeFormatId,
      this.defaultInvoiceTerms,
      this.enableInvoiceTaxes,
      this.enableInvoiceItemTaxes,
      this.defaultInvoiceDesignId,
      this.defaultQuoteDesignId,
      this.languageId,
      this.defaultInvoiceFooter,
      this.showInvoiceItemTaxes,
      this.enableMilitaryTime,
      this.defaultTaxName1,
      this.defaultTaxRate1,
      this.defaultTaxName2,
      this.defaultTaxRate2,
      this.defaultQuoteTerms,
      this.showCurrencyCode,
      this.enableSecondTaxRate,
      this.startOfWeek,
      this.financialYearStart,
      this.enabledModules,
      this.defaultPaymentTerms,
      this.defaultPaymentTypeId,
      this.defaultTaskRate,
      this.enableInclusiveTaxes,
      this.convertProductExchangeRate,
      this.enableCustomInvoiceTaxes1,
      this.enableCustomInvoiceTaxes2})
      : super._() {
    if (name == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'name');
    if (token == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'token');
    if (plan == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'plan');
    if (logoUrl == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'logoUrl');
    if (currencyId == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'currencyId');
    if (timezoneId == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'timezoneId');
    if (dateFormatId == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'dateFormatId');
    if (datetimeFormatId == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'datetimeFormatId');
    if (defaultInvoiceTerms == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultInvoiceTerms');
    if (enableInvoiceTaxes == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'enableInvoiceTaxes');
    if (enableInvoiceItemTaxes == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableInvoiceItemTaxes');
    if (defaultInvoiceDesignId == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultInvoiceDesignId');
    if (defaultQuoteDesignId == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultQuoteDesignId');
    if (languageId == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'languageId');
    if (defaultInvoiceFooter == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultInvoiceFooter');
    if (showInvoiceItemTaxes == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'showInvoiceItemTaxes');
    if (enableMilitaryTime == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'enableMilitaryTime');
    if (defaultTaxName1 == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaxName1');
    if (defaultTaxRate1 == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaxRate1');
    if (defaultTaxName2 == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaxName2');
    if (defaultTaxRate2 == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaxRate2');
    if (defaultQuoteTerms == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultQuoteTerms');
    if (showCurrencyCode == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'showCurrencyCode');
    if (enableSecondTaxRate == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableSecondTaxRate');
    if (startOfWeek == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'startOfWeek');
    if (financialYearStart == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'financialYearStart');
    if (enabledModules == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'enabledModules');
    if (defaultPaymentTerms == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultPaymentTerms');
    if (defaultPaymentTypeId == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultPaymentTypeId');
    if (defaultTaskRate == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaskRate');
    if (enableInclusiveTaxes == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableInclusiveTaxes');
    if (convertProductExchangeRate == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'convertProductExchangeRate');
    if (enableCustomInvoiceTaxes1 == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableCustomInvoiceTaxes1');
    if (enableCustomInvoiceTaxes2 == null)
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableCustomInvoiceTaxes2');
  }

  @override
  CompanyEntity rebuild(void updates(CompanyEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyEntityBuilder toBuilder() => new CompanyEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! CompanyEntity) return false;
    return name == other.name &&
        token == other.token &&
        plan == other.plan &&
        logoUrl == other.logoUrl &&
        currencyId == other.currencyId &&
        timezoneId == other.timezoneId &&
        dateFormatId == other.dateFormatId &&
        datetimeFormatId == other.datetimeFormatId &&
        defaultInvoiceTerms == other.defaultInvoiceTerms &&
        enableInvoiceTaxes == other.enableInvoiceTaxes &&
        enableInvoiceItemTaxes == other.enableInvoiceItemTaxes &&
        defaultInvoiceDesignId == other.defaultInvoiceDesignId &&
        defaultQuoteDesignId == other.defaultQuoteDesignId &&
        languageId == other.languageId &&
        defaultInvoiceFooter == other.defaultInvoiceFooter &&
        showInvoiceItemTaxes == other.showInvoiceItemTaxes &&
        enableMilitaryTime == other.enableMilitaryTime &&
        defaultTaxName1 == other.defaultTaxName1 &&
        defaultTaxRate1 == other.defaultTaxRate1 &&
        defaultTaxName2 == other.defaultTaxName2 &&
        defaultTaxRate2 == other.defaultTaxRate2 &&
        defaultQuoteTerms == other.defaultQuoteTerms &&
        showCurrencyCode == other.showCurrencyCode &&
        enableSecondTaxRate == other.enableSecondTaxRate &&
        startOfWeek == other.startOfWeek &&
        financialYearStart == other.financialYearStart &&
        enabledModules == other.enabledModules &&
        defaultPaymentTerms == other.defaultPaymentTerms &&
        defaultPaymentTypeId == other.defaultPaymentTypeId &&
        defaultTaskRate == other.defaultTaskRate &&
        enableInclusiveTaxes == other.enableInclusiveTaxes &&
        convertProductExchangeRate == other.convertProductExchangeRate &&
        enableCustomInvoiceTaxes1 == other.enableCustomInvoiceTaxes1 &&
        enableCustomInvoiceTaxes2 == other.enableCustomInvoiceTaxes2;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, name.hashCode), token.hashCode), plan.hashCode), logoUrl.hashCode), currencyId.hashCode), timezoneId.hashCode), dateFormatId.hashCode), datetimeFormatId.hashCode), defaultInvoiceTerms.hashCode), enableInvoiceTaxes.hashCode), enableInvoiceItemTaxes.hashCode), defaultInvoiceDesignId.hashCode), defaultQuoteDesignId.hashCode), languageId.hashCode), defaultInvoiceFooter.hashCode),
                                                                                showInvoiceItemTaxes.hashCode),
                                                                            enableMilitaryTime.hashCode),
                                                                        defaultTaxName1.hashCode),
                                                                    defaultTaxRate1.hashCode),
                                                                defaultTaxName2.hashCode),
                                                            defaultTaxRate2.hashCode),
                                                        defaultQuoteTerms.hashCode),
                                                    showCurrencyCode.hashCode),
                                                enableSecondTaxRate.hashCode),
                                            startOfWeek.hashCode),
                                        financialYearStart.hashCode),
                                    enabledModules.hashCode),
                                defaultPaymentTerms.hashCode),
                            defaultPaymentTypeId.hashCode),
                        defaultTaskRate.hashCode),
                    enableInclusiveTaxes.hashCode),
                convertProductExchangeRate.hashCode),
            enableCustomInvoiceTaxes1.hashCode),
        enableCustomInvoiceTaxes2.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyEntity')
          ..add('name', name)
          ..add('token', token)
          ..add('plan', plan)
          ..add('logoUrl', logoUrl)
          ..add('currencyId', currencyId)
          ..add('timezoneId', timezoneId)
          ..add('dateFormatId', dateFormatId)
          ..add('datetimeFormatId', datetimeFormatId)
          ..add('defaultInvoiceTerms', defaultInvoiceTerms)
          ..add('enableInvoiceTaxes', enableInvoiceTaxes)
          ..add('enableInvoiceItemTaxes', enableInvoiceItemTaxes)
          ..add('defaultInvoiceDesignId', defaultInvoiceDesignId)
          ..add('defaultQuoteDesignId', defaultQuoteDesignId)
          ..add('languageId', languageId)
          ..add('defaultInvoiceFooter', defaultInvoiceFooter)
          ..add('showInvoiceItemTaxes', showInvoiceItemTaxes)
          ..add('enableMilitaryTime', enableMilitaryTime)
          ..add('defaultTaxName1', defaultTaxName1)
          ..add('defaultTaxRate1', defaultTaxRate1)
          ..add('defaultTaxName2', defaultTaxName2)
          ..add('defaultTaxRate2', defaultTaxRate2)
          ..add('defaultQuoteTerms', defaultQuoteTerms)
          ..add('showCurrencyCode', showCurrencyCode)
          ..add('enableSecondTaxRate', enableSecondTaxRate)
          ..add('startOfWeek', startOfWeek)
          ..add('financialYearStart', financialYearStart)
          ..add('enabledModules', enabledModules)
          ..add('defaultPaymentTerms', defaultPaymentTerms)
          ..add('defaultPaymentTypeId', defaultPaymentTypeId)
          ..add('defaultTaskRate', defaultTaskRate)
          ..add('enableInclusiveTaxes', enableInclusiveTaxes)
          ..add('convertProductExchangeRate', convertProductExchangeRate)
          ..add('enableCustomInvoiceTaxes1', enableCustomInvoiceTaxes1)
          ..add('enableCustomInvoiceTaxes2', enableCustomInvoiceTaxes2))
        .toString();
  }
}

class CompanyEntityBuilder
    implements Builder<CompanyEntity, CompanyEntityBuilder> {
  _$CompanyEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  String _plan;
  String get plan => _$this._plan;
  set plan(String plan) => _$this._plan = plan;

  String _logoUrl;
  String get logoUrl => _$this._logoUrl;
  set logoUrl(String logoUrl) => _$this._logoUrl = logoUrl;

  int _currencyId;
  int get currencyId => _$this._currencyId;
  set currencyId(int currencyId) => _$this._currencyId = currencyId;

  int _timezoneId;
  int get timezoneId => _$this._timezoneId;
  set timezoneId(int timezoneId) => _$this._timezoneId = timezoneId;

  int _dateFormatId;
  int get dateFormatId => _$this._dateFormatId;
  set dateFormatId(int dateFormatId) => _$this._dateFormatId = dateFormatId;

  int _datetimeFormatId;
  int get datetimeFormatId => _$this._datetimeFormatId;
  set datetimeFormatId(int datetimeFormatId) =>
      _$this._datetimeFormatId = datetimeFormatId;

  String _defaultInvoiceTerms;
  String get defaultInvoiceTerms => _$this._defaultInvoiceTerms;
  set defaultInvoiceTerms(String defaultInvoiceTerms) =>
      _$this._defaultInvoiceTerms = defaultInvoiceTerms;

  bool _enableInvoiceTaxes;
  bool get enableInvoiceTaxes => _$this._enableInvoiceTaxes;
  set enableInvoiceTaxes(bool enableInvoiceTaxes) =>
      _$this._enableInvoiceTaxes = enableInvoiceTaxes;

  bool _enableInvoiceItemTaxes;
  bool get enableInvoiceItemTaxes => _$this._enableInvoiceItemTaxes;
  set enableInvoiceItemTaxes(bool enableInvoiceItemTaxes) =>
      _$this._enableInvoiceItemTaxes = enableInvoiceItemTaxes;

  int _defaultInvoiceDesignId;
  int get defaultInvoiceDesignId => _$this._defaultInvoiceDesignId;
  set defaultInvoiceDesignId(int defaultInvoiceDesignId) =>
      _$this._defaultInvoiceDesignId = defaultInvoiceDesignId;

  int _defaultQuoteDesignId;
  int get defaultQuoteDesignId => _$this._defaultQuoteDesignId;
  set defaultQuoteDesignId(int defaultQuoteDesignId) =>
      _$this._defaultQuoteDesignId = defaultQuoteDesignId;

  int _languageId;
  int get languageId => _$this._languageId;
  set languageId(int languageId) => _$this._languageId = languageId;

  String _defaultInvoiceFooter;
  String get defaultInvoiceFooter => _$this._defaultInvoiceFooter;
  set defaultInvoiceFooter(String defaultInvoiceFooter) =>
      _$this._defaultInvoiceFooter = defaultInvoiceFooter;

  bool _showInvoiceItemTaxes;
  bool get showInvoiceItemTaxes => _$this._showInvoiceItemTaxes;
  set showInvoiceItemTaxes(bool showInvoiceItemTaxes) =>
      _$this._showInvoiceItemTaxes = showInvoiceItemTaxes;

  bool _enableMilitaryTime;
  bool get enableMilitaryTime => _$this._enableMilitaryTime;
  set enableMilitaryTime(bool enableMilitaryTime) =>
      _$this._enableMilitaryTime = enableMilitaryTime;

  String _defaultTaxName1;
  String get defaultTaxName1 => _$this._defaultTaxName1;
  set defaultTaxName1(String defaultTaxName1) =>
      _$this._defaultTaxName1 = defaultTaxName1;

  double _defaultTaxRate1;
  double get defaultTaxRate1 => _$this._defaultTaxRate1;
  set defaultTaxRate1(double defaultTaxRate1) =>
      _$this._defaultTaxRate1 = defaultTaxRate1;

  String _defaultTaxName2;
  String get defaultTaxName2 => _$this._defaultTaxName2;
  set defaultTaxName2(String defaultTaxName2) =>
      _$this._defaultTaxName2 = defaultTaxName2;

  double _defaultTaxRate2;
  double get defaultTaxRate2 => _$this._defaultTaxRate2;
  set defaultTaxRate2(double defaultTaxRate2) =>
      _$this._defaultTaxRate2 = defaultTaxRate2;

  String _defaultQuoteTerms;
  String get defaultQuoteTerms => _$this._defaultQuoteTerms;
  set defaultQuoteTerms(String defaultQuoteTerms) =>
      _$this._defaultQuoteTerms = defaultQuoteTerms;

  bool _showCurrencyCode;
  bool get showCurrencyCode => _$this._showCurrencyCode;
  set showCurrencyCode(bool showCurrencyCode) =>
      _$this._showCurrencyCode = showCurrencyCode;

  bool _enableSecondTaxRate;
  bool get enableSecondTaxRate => _$this._enableSecondTaxRate;
  set enableSecondTaxRate(bool enableSecondTaxRate) =>
      _$this._enableSecondTaxRate = enableSecondTaxRate;

  int _startOfWeek;
  int get startOfWeek => _$this._startOfWeek;
  set startOfWeek(int startOfWeek) => _$this._startOfWeek = startOfWeek;

  int _financialYearStart;
  int get financialYearStart => _$this._financialYearStart;
  set financialYearStart(int financialYearStart) =>
      _$this._financialYearStart = financialYearStart;

  int _enabledModules;
  int get enabledModules => _$this._enabledModules;
  set enabledModules(int enabledModules) =>
      _$this._enabledModules = enabledModules;

  int _defaultPaymentTerms;
  int get defaultPaymentTerms => _$this._defaultPaymentTerms;
  set defaultPaymentTerms(int defaultPaymentTerms) =>
      _$this._defaultPaymentTerms = defaultPaymentTerms;

  int _defaultPaymentTypeId;
  int get defaultPaymentTypeId => _$this._defaultPaymentTypeId;
  set defaultPaymentTypeId(int defaultPaymentTypeId) =>
      _$this._defaultPaymentTypeId = defaultPaymentTypeId;

  double _defaultTaskRate;
  double get defaultTaskRate => _$this._defaultTaskRate;
  set defaultTaskRate(double defaultTaskRate) =>
      _$this._defaultTaskRate = defaultTaskRate;

  bool _enableInclusiveTaxes;
  bool get enableInclusiveTaxes => _$this._enableInclusiveTaxes;
  set enableInclusiveTaxes(bool enableInclusiveTaxes) =>
      _$this._enableInclusiveTaxes = enableInclusiveTaxes;

  bool _convertProductExchangeRate;
  bool get convertProductExchangeRate => _$this._convertProductExchangeRate;
  set convertProductExchangeRate(bool convertProductExchangeRate) =>
      _$this._convertProductExchangeRate = convertProductExchangeRate;

  bool _enableCustomInvoiceTaxes1;
  bool get enableCustomInvoiceTaxes1 => _$this._enableCustomInvoiceTaxes1;
  set enableCustomInvoiceTaxes1(bool enableCustomInvoiceTaxes1) =>
      _$this._enableCustomInvoiceTaxes1 = enableCustomInvoiceTaxes1;

  bool _enableCustomInvoiceTaxes2;
  bool get enableCustomInvoiceTaxes2 => _$this._enableCustomInvoiceTaxes2;
  set enableCustomInvoiceTaxes2(bool enableCustomInvoiceTaxes2) =>
      _$this._enableCustomInvoiceTaxes2 = enableCustomInvoiceTaxes2;

  CompanyEntityBuilder();

  CompanyEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _token = _$v.token;
      _plan = _$v.plan;
      _logoUrl = _$v.logoUrl;
      _currencyId = _$v.currencyId;
      _timezoneId = _$v.timezoneId;
      _dateFormatId = _$v.dateFormatId;
      _datetimeFormatId = _$v.datetimeFormatId;
      _defaultInvoiceTerms = _$v.defaultInvoiceTerms;
      _enableInvoiceTaxes = _$v.enableInvoiceTaxes;
      _enableInvoiceItemTaxes = _$v.enableInvoiceItemTaxes;
      _defaultInvoiceDesignId = _$v.defaultInvoiceDesignId;
      _defaultQuoteDesignId = _$v.defaultQuoteDesignId;
      _languageId = _$v.languageId;
      _defaultInvoiceFooter = _$v.defaultInvoiceFooter;
      _showInvoiceItemTaxes = _$v.showInvoiceItemTaxes;
      _enableMilitaryTime = _$v.enableMilitaryTime;
      _defaultTaxName1 = _$v.defaultTaxName1;
      _defaultTaxRate1 = _$v.defaultTaxRate1;
      _defaultTaxName2 = _$v.defaultTaxName2;
      _defaultTaxRate2 = _$v.defaultTaxRate2;
      _defaultQuoteTerms = _$v.defaultQuoteTerms;
      _showCurrencyCode = _$v.showCurrencyCode;
      _enableSecondTaxRate = _$v.enableSecondTaxRate;
      _startOfWeek = _$v.startOfWeek;
      _financialYearStart = _$v.financialYearStart;
      _enabledModules = _$v.enabledModules;
      _defaultPaymentTerms = _$v.defaultPaymentTerms;
      _defaultPaymentTypeId = _$v.defaultPaymentTypeId;
      _defaultTaskRate = _$v.defaultTaskRate;
      _enableInclusiveTaxes = _$v.enableInclusiveTaxes;
      _convertProductExchangeRate = _$v.convertProductExchangeRate;
      _enableCustomInvoiceTaxes1 = _$v.enableCustomInvoiceTaxes1;
      _enableCustomInvoiceTaxes2 = _$v.enableCustomInvoiceTaxes2;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$CompanyEntity;
  }

  @override
  void update(void updates(CompanyEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyEntity build() {
    final _$result = _$v ??
        new _$CompanyEntity._(
            name: name,
            token: token,
            plan: plan,
            logoUrl: logoUrl,
            currencyId: currencyId,
            timezoneId: timezoneId,
            dateFormatId: dateFormatId,
            datetimeFormatId: datetimeFormatId,
            defaultInvoiceTerms: defaultInvoiceTerms,
            enableInvoiceTaxes: enableInvoiceTaxes,
            enableInvoiceItemTaxes: enableInvoiceItemTaxes,
            defaultInvoiceDesignId: defaultInvoiceDesignId,
            defaultQuoteDesignId: defaultQuoteDesignId,
            languageId: languageId,
            defaultInvoiceFooter: defaultInvoiceFooter,
            showInvoiceItemTaxes: showInvoiceItemTaxes,
            enableMilitaryTime: enableMilitaryTime,
            defaultTaxName1: defaultTaxName1,
            defaultTaxRate1: defaultTaxRate1,
            defaultTaxName2: defaultTaxName2,
            defaultTaxRate2: defaultTaxRate2,
            defaultQuoteTerms: defaultQuoteTerms,
            showCurrencyCode: showCurrencyCode,
            enableSecondTaxRate: enableSecondTaxRate,
            startOfWeek: startOfWeek,
            financialYearStart: financialYearStart,
            enabledModules: enabledModules,
            defaultPaymentTerms: defaultPaymentTerms,
            defaultPaymentTypeId: defaultPaymentTypeId,
            defaultTaskRate: defaultTaskRate,
            enableInclusiveTaxes: enableInclusiveTaxes,
            convertProductExchangeRate: convertProductExchangeRate,
            enableCustomInvoiceTaxes1: enableCustomInvoiceTaxes1,
            enableCustomInvoiceTaxes2: enableCustomInvoiceTaxes2);
    replace(_$result);
    return _$result;
  }
}

class _$DashboardResponse extends DashboardResponse {
  @override
  final DashboardEntity data;

  factory _$DashboardResponse([void updates(DashboardResponseBuilder b)]) =>
      (new DashboardResponseBuilder()..update(updates)).build();

  _$DashboardResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('DashboardResponse', 'data');
  }

  @override
  DashboardResponse rebuild(void updates(DashboardResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardResponseBuilder toBuilder() =>
      new DashboardResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! DashboardResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardResponse')..add('data', data))
        .toString();
  }
}

class DashboardResponseBuilder
    implements Builder<DashboardResponse, DashboardResponseBuilder> {
  _$DashboardResponse _$v;

  DashboardEntityBuilder _data;
  DashboardEntityBuilder get data =>
      _$this._data ??= new DashboardEntityBuilder();
  set data(DashboardEntityBuilder data) => _$this._data = data;

  DashboardResponseBuilder();

  DashboardResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$DashboardResponse;
  }

  @override
  void update(void updates(DashboardResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardResponse build() {
    _$DashboardResponse _$result;
    try {
      _$result = _$v ?? new _$DashboardResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DashboardResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DashboardEntity extends DashboardEntity {
  @override
  final double paidToDate;
  @override
  final int paidToDateCurrency;
  @override
  final double balances;
  @override
  final int balancesCurrency;
  @override
  final double averageInvoice;
  @override
  final int averageInvoiceCurrency;
  @override
  final int invoicesSent;
  @override
  final int activeClients;

  factory _$DashboardEntity([void updates(DashboardEntityBuilder b)]) =>
      (new DashboardEntityBuilder()..update(updates)).build();

  _$DashboardEntity._(
      {this.paidToDate,
      this.paidToDateCurrency,
      this.balances,
      this.balancesCurrency,
      this.averageInvoice,
      this.averageInvoiceCurrency,
      this.invoicesSent,
      this.activeClients})
      : super._();

  @override
  DashboardEntity rebuild(void updates(DashboardEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardEntityBuilder toBuilder() =>
      new DashboardEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! DashboardEntity) return false;
    return paidToDate == other.paidToDate &&
        paidToDateCurrency == other.paidToDateCurrency &&
        balances == other.balances &&
        balancesCurrency == other.balancesCurrency &&
        averageInvoice == other.averageInvoice &&
        averageInvoiceCurrency == other.averageInvoiceCurrency &&
        invoicesSent == other.invoicesSent &&
        activeClients == other.activeClients;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, paidToDate.hashCode),
                                paidToDateCurrency.hashCode),
                            balances.hashCode),
                        balancesCurrency.hashCode),
                    averageInvoice.hashCode),
                averageInvoiceCurrency.hashCode),
            invoicesSent.hashCode),
        activeClients.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardEntity')
          ..add('paidToDate', paidToDate)
          ..add('paidToDateCurrency', paidToDateCurrency)
          ..add('balances', balances)
          ..add('balancesCurrency', balancesCurrency)
          ..add('averageInvoice', averageInvoice)
          ..add('averageInvoiceCurrency', averageInvoiceCurrency)
          ..add('invoicesSent', invoicesSent)
          ..add('activeClients', activeClients))
        .toString();
  }
}

class DashboardEntityBuilder
    implements Builder<DashboardEntity, DashboardEntityBuilder> {
  _$DashboardEntity _$v;

  double _paidToDate;
  double get paidToDate => _$this._paidToDate;
  set paidToDate(double paidToDate) => _$this._paidToDate = paidToDate;

  int _paidToDateCurrency;
  int get paidToDateCurrency => _$this._paidToDateCurrency;
  set paidToDateCurrency(int paidToDateCurrency) =>
      _$this._paidToDateCurrency = paidToDateCurrency;

  double _balances;
  double get balances => _$this._balances;
  set balances(double balances) => _$this._balances = balances;

  int _balancesCurrency;
  int get balancesCurrency => _$this._balancesCurrency;
  set balancesCurrency(int balancesCurrency) =>
      _$this._balancesCurrency = balancesCurrency;

  double _averageInvoice;
  double get averageInvoice => _$this._averageInvoice;
  set averageInvoice(double averageInvoice) =>
      _$this._averageInvoice = averageInvoice;

  int _averageInvoiceCurrency;
  int get averageInvoiceCurrency => _$this._averageInvoiceCurrency;
  set averageInvoiceCurrency(int averageInvoiceCurrency) =>
      _$this._averageInvoiceCurrency = averageInvoiceCurrency;

  int _invoicesSent;
  int get invoicesSent => _$this._invoicesSent;
  set invoicesSent(int invoicesSent) => _$this._invoicesSent = invoicesSent;

  int _activeClients;
  int get activeClients => _$this._activeClients;
  set activeClients(int activeClients) => _$this._activeClients = activeClients;

  DashboardEntityBuilder();

  DashboardEntityBuilder get _$this {
    if (_$v != null) {
      _paidToDate = _$v.paidToDate;
      _paidToDateCurrency = _$v.paidToDateCurrency;
      _balances = _$v.balances;
      _balancesCurrency = _$v.balancesCurrency;
      _averageInvoice = _$v.averageInvoice;
      _averageInvoiceCurrency = _$v.averageInvoiceCurrency;
      _invoicesSent = _$v.invoicesSent;
      _activeClients = _$v.activeClients;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$DashboardEntity;
  }

  @override
  void update(void updates(DashboardEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardEntity build() {
    final _$result = _$v ??
        new _$DashboardEntity._(
            paidToDate: paidToDate,
            paidToDateCurrency: paidToDateCurrency,
            balances: balances,
            balancesCurrency: balancesCurrency,
            averageInvoice: averageInvoice,
            averageInvoiceCurrency: averageInvoiceCurrency,
            invoicesSent: invoicesSent,
            activeClients: activeClients);
    replace(_$result);
    return _$result;
  }
}
