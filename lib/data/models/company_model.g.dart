// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<CompanyEntity> _$companyEntitySerializer =
    new _$CompanyEntitySerializer();
Serializer<TaxRateEntity> _$taxRateEntitySerializer =
    new _$TaxRateEntitySerializer();
Serializer<UserEntity> _$userEntitySerializer = new _$UserEntitySerializer();

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
      'country_id',
      serializers.serialize(object.countryId,
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
      'custom_invoice_taxes2',
      serializers.serialize(object.enableCustomInvoiceTaxes2,
          specifiedType: const FullType(bool)),
      'tax_rates',
      serializers.serialize(object.taxRates,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TaxRateEntity)])),
      'users',
      serializers.serialize(object.users,
          specifiedType:
              const FullType(BuiltList, const [const FullType(UserEntity)])),
      'custom_fields',
      serializers.serialize(object.customFields,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'invoice_fields',
      serializers.serialize(object.invoiceFields,
          specifiedType: const FullType(String)),
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
        case 'country_id':
          result.countryId = serializers.deserialize(value,
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
        case 'custom_invoice_taxes2':
          result.enableCustomInvoiceTaxes2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'tax_rates':
          result.taxRates.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaxRateEntity)]))
              as BuiltList);
          break;
        case 'users':
          result.users.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(UserEntity)])) as BuiltList);
          break;
        case 'custom_fields':
          result.customFields.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(String)
              ])) as BuiltMap);
          break;
        case 'invoice_fields':
          result.invoiceFields = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TaxRateEntitySerializer implements StructuredSerializer<TaxRateEntity> {
  @override
  final Iterable<Type> types = const [TaxRateEntity, _$TaxRateEntity];
  @override
  final String wireName = 'TaxRateEntity';

  @override
  Iterable serialize(Serializers serializers, TaxRateEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'rate',
      serializers.serialize(object.rate, specifiedType: const FullType(double)),
      'is_inclusive',
      serializers.serialize(object.isInclusive,
          specifiedType: const FullType(bool)),
    ];
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  TaxRateEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new TaxRateEntityBuilder();

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
        case 'rate':
          result.rate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'is_inclusive':
          result.isInclusive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$UserEntitySerializer implements StructuredSerializer<UserEntity> {
  @override
  final Iterable<Type> types = const [UserEntity, _$UserEntity];
  @override
  final String wireName = 'UserEntity';

  @override
  Iterable serialize(Serializers serializers, UserEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'first_name',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'last_name',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  UserEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new UserEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
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
  final int countryId;
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
  @override
  final BuiltList<TaxRateEntity> taxRates;
  @override
  final BuiltList<UserEntity> users;
  @override
  final BuiltMap<String, String> customFields;
  @override
  final String invoiceFields;

  factory _$CompanyEntity([void updates(CompanyEntityBuilder b)]) =>
      (new CompanyEntityBuilder()..update(updates)).build();

  _$CompanyEntity._(
      {this.name,
      this.token,
      this.plan,
      this.logoUrl,
      this.currencyId,
      this.timezoneId,
      this.countryId,
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
      this.enableCustomInvoiceTaxes2,
      this.taxRates,
      this.users,
      this.customFields,
      this.invoiceFields})
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
    if (countryId == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'countryId');
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
    if (taxRates == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'taxRates');
    if (users == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'users');
    if (customFields == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'customFields');
    if (invoiceFields == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'invoiceFields');
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
        countryId == other.countryId &&
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
        enableCustomInvoiceTaxes2 == other.enableCustomInvoiceTaxes2 &&
        taxRates == other.taxRates &&
        users == other.users &&
        customFields == other.customFields &&
        invoiceFields == other.invoiceFields;
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, name.hashCode), token.hashCode), plan.hashCode), logoUrl.hashCode), currencyId.hashCode), timezoneId.hashCode), countryId.hashCode), dateFormatId.hashCode), datetimeFormatId.hashCode), defaultInvoiceTerms.hashCode), enableInvoiceTaxes.hashCode), enableInvoiceItemTaxes.hashCode), defaultInvoiceDesignId.hashCode), defaultQuoteDesignId.hashCode), languageId.hashCode), defaultInvoiceFooter.hashCode), showInvoiceItemTaxes.hashCode), enableMilitaryTime.hashCode), defaultTaxName1.hashCode), defaultTaxRate1.hashCode),
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
                        enableCustomInvoiceTaxes2.hashCode),
                    taxRates.hashCode),
                users.hashCode),
            customFields.hashCode),
        invoiceFields.hashCode));
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
          ..add('countryId', countryId)
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
          ..add('enableCustomInvoiceTaxes2', enableCustomInvoiceTaxes2)
          ..add('taxRates', taxRates)
          ..add('users', users)
          ..add('customFields', customFields)
          ..add('invoiceFields', invoiceFields))
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

  int _countryId;
  int get countryId => _$this._countryId;
  set countryId(int countryId) => _$this._countryId = countryId;

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

  ListBuilder<TaxRateEntity> _taxRates;
  ListBuilder<TaxRateEntity> get taxRates =>
      _$this._taxRates ??= new ListBuilder<TaxRateEntity>();
  set taxRates(ListBuilder<TaxRateEntity> taxRates) =>
      _$this._taxRates = taxRates;

  ListBuilder<UserEntity> _users;
  ListBuilder<UserEntity> get users =>
      _$this._users ??= new ListBuilder<UserEntity>();
  set users(ListBuilder<UserEntity> users) => _$this._users = users;

  MapBuilder<String, String> _customFields;
  MapBuilder<String, String> get customFields =>
      _$this._customFields ??= new MapBuilder<String, String>();
  set customFields(MapBuilder<String, String> customFields) =>
      _$this._customFields = customFields;

  String _invoiceFields;
  String get invoiceFields => _$this._invoiceFields;
  set invoiceFields(String invoiceFields) =>
      _$this._invoiceFields = invoiceFields;

  CompanyEntityBuilder();

  CompanyEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _token = _$v.token;
      _plan = _$v.plan;
      _logoUrl = _$v.logoUrl;
      _currencyId = _$v.currencyId;
      _timezoneId = _$v.timezoneId;
      _countryId = _$v.countryId;
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
      _taxRates = _$v.taxRates?.toBuilder();
      _users = _$v.users?.toBuilder();
      _customFields = _$v.customFields?.toBuilder();
      _invoiceFields = _$v.invoiceFields;
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
    _$CompanyEntity _$result;
    try {
      _$result = _$v ??
          new _$CompanyEntity._(
              name: name,
              token: token,
              plan: plan,
              logoUrl: logoUrl,
              currencyId: currencyId,
              timezoneId: timezoneId,
              countryId: countryId,
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
              enableCustomInvoiceTaxes2: enableCustomInvoiceTaxes2,
              taxRates: taxRates.build(),
              users: users.build(),
              customFields: customFields.build(),
              invoiceFields: invoiceFields);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'taxRates';
        taxRates.build();
        _$failedField = 'users';
        users.build();
        _$failedField = 'customFields';
        customFields.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaxRateEntity extends TaxRateEntity {
  @override
  final String name;
  @override
  final double rate;
  @override
  final bool isInclusive;
  @override
  final int archivedAt;
  @override
  final int id;

  factory _$TaxRateEntity([void updates(TaxRateEntityBuilder b)]) =>
      (new TaxRateEntityBuilder()..update(updates)).build();

  _$TaxRateEntity._(
      {this.name, this.rate, this.isInclusive, this.archivedAt, this.id})
      : super._() {
    if (name == null)
      throw new BuiltValueNullFieldError('TaxRateEntity', 'name');
    if (rate == null)
      throw new BuiltValueNullFieldError('TaxRateEntity', 'rate');
    if (isInclusive == null)
      throw new BuiltValueNullFieldError('TaxRateEntity', 'isInclusive');
  }

  @override
  TaxRateEntity rebuild(void updates(TaxRateEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxRateEntityBuilder toBuilder() => new TaxRateEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! TaxRateEntity) return false;
    return name == other.name &&
        rate == other.rate &&
        isInclusive == other.isInclusive &&
        archivedAt == other.archivedAt &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, name.hashCode), rate.hashCode),
                isInclusive.hashCode),
            archivedAt.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaxRateEntity')
          ..add('name', name)
          ..add('rate', rate)
          ..add('isInclusive', isInclusive)
          ..add('archivedAt', archivedAt)
          ..add('id', id))
        .toString();
  }
}

class TaxRateEntityBuilder
    implements Builder<TaxRateEntity, TaxRateEntityBuilder> {
  _$TaxRateEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  double _rate;
  double get rate => _$this._rate;
  set rate(double rate) => _$this._rate = rate;

  bool _isInclusive;
  bool get isInclusive => _$this._isInclusive;
  set isInclusive(bool isInclusive) => _$this._isInclusive = isInclusive;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  TaxRateEntityBuilder();

  TaxRateEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _rate = _$v.rate;
      _isInclusive = _$v.isInclusive;
      _archivedAt = _$v.archivedAt;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxRateEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$TaxRateEntity;
  }

  @override
  void update(void updates(TaxRateEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaxRateEntity build() {
    final _$result = _$v ??
        new _$TaxRateEntity._(
            name: name,
            rate: rate,
            isInclusive: isInclusive,
            archivedAt: archivedAt,
            id: id);
    replace(_$result);
    return _$result;
  }
}

class _$UserEntity extends UserEntity {
  @override
  final int id;
  @override
  final String firstName;
  @override
  final String lastName;

  factory _$UserEntity([void updates(UserEntityBuilder b)]) =>
      (new UserEntityBuilder()..update(updates)).build();

  _$UserEntity._({this.id, this.firstName, this.lastName}) : super._() {
    if (id == null) throw new BuiltValueNullFieldError('UserEntity', 'id');
    if (firstName == null)
      throw new BuiltValueNullFieldError('UserEntity', 'firstName');
    if (lastName == null)
      throw new BuiltValueNullFieldError('UserEntity', 'lastName');
  }

  @override
  UserEntity rebuild(void updates(UserEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserEntityBuilder toBuilder() => new UserEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! UserEntity) return false;
    return id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, id.hashCode), firstName.hashCode), lastName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserEntity')
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName))
        .toString();
  }
}

class UserEntityBuilder implements Builder<UserEntity, UserEntityBuilder> {
  _$UserEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  UserEntityBuilder();

  UserEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$UserEntity;
  }

  @override
  void update(void updates(UserEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserEntity build() {
    final _$result = _$v ??
        new _$UserEntity._(id: id, firstName: firstName, lastName: lastName);
    replace(_$result);
    return _$result;
  }
}
