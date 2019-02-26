// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<CompanyEntity> _$companyEntitySerializer =
    new _$CompanyEntitySerializer();
Serializer<PaymentTermEntity> _$paymentTermEntitySerializer =
    new _$PaymentTermEntitySerializer();
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
      {FullType specifiedType = FullType.unspecified}) {
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
      'default_url',
      serializers.serialize(object.appUrl,
          specifiedType: const FullType(String)),
      'currency_id',
      serializers.serialize(object.companyCurrencyId,
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
      'taskStatusMap',
      serializers.serialize(object.taskStatusMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(TaskStatusEntity)])),
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(UserEntity)),
      'custom_fields',
      serializers.serialize(object.customFields,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'custom_payment_terms',
      serializers.serialize(object.customPaymentTerms,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTermEntity)])),
      'invoice_fields',
      serializers.serialize(object.invoiceFields,
          specifiedType: const FullType(String)),
      'email_footer',
      serializers.serialize(object.emailFooter,
          specifiedType: const FullType(String)),
      'email_subject_invoice',
      serializers.serialize(object.emailSubjectInvoice,
          specifiedType: const FullType(String)),
      'email_subject_quote',
      serializers.serialize(object.emailSubjectQuote,
          specifiedType: const FullType(String)),
      'email_subject_payment',
      serializers.serialize(object.emailSubjectPayment,
          specifiedType: const FullType(String)),
      'email_template_invoice',
      serializers.serialize(object.emailBodyInvoice,
          specifiedType: const FullType(String)),
      'email_template_quote',
      serializers.serialize(object.emailBodyQuote,
          specifiedType: const FullType(String)),
      'email_template_payment',
      serializers.serialize(object.emailBodyPayment,
          specifiedType: const FullType(String)),
      'email_subject_reminder1',
      serializers.serialize(object.emailSubjectReminder1,
          specifiedType: const FullType(String)),
      'email_subject_reminder2',
      serializers.serialize(object.emailSubjectReminder2,
          specifiedType: const FullType(String)),
      'email_subject_reminder3',
      serializers.serialize(object.emailSubjectReminder3,
          specifiedType: const FullType(String)),
      'email_template_reminder1',
      serializers.serialize(object.emailBodyReminder1,
          specifiedType: const FullType(String)),
      'email_template_reminder2',
      serializers.serialize(object.emailBodyReminder2,
          specifiedType: const FullType(String)),
      'email_template_reminder3',
      serializers.serialize(object.emailBodyReminder3,
          specifiedType: const FullType(String)),
    ];
    if (object.taskStatuses != null) {
      result
        ..add('task_statuses')
        ..add(serializers.serialize(object.taskStatuses,
            specifiedType: const FullType(
                BuiltList, const [const FullType(TaskStatusEntity)])));
    }
    if (object.fillProducts != null) {
      result
        ..add('fill_products')
        ..add(serializers.serialize(object.fillProducts,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortalPassword != null) {
      result
        ..add('enable_portal_password')
        ..add(serializers.serialize(object.enablePortalPassword,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign1 != null) {
      result
        ..add('has_custom_design1')
        ..add(serializers.serialize(object.hasCustomDesign1,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign2 != null) {
      result
        ..add('has_custom_design2')
        ..add(serializers.serialize(object.hasCustomDesign2,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign3 != null) {
      result
        ..add('has_custom_design3')
        ..add(serializers.serialize(object.hasCustomDesign3,
            specifiedType: const FullType(bool)));
    }

    return result;
  }

  @override
  CompanyEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
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
        case 'default_url':
          result.appUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency_id':
          result.companyCurrencyId = serializers.deserialize(value,
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
        case 'task_statuses':
          result.taskStatuses.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaskStatusEntity)]))
              as BuiltList);
          break;
        case 'taskStatusMap':
          result.taskStatusMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(TaskStatusEntity)
              ])) as BuiltMap);
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity)) as UserEntity);
          break;
        case 'custom_fields':
          result.customFields.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(String)
              ])) as BuiltMap);
          break;
        case 'custom_payment_terms':
          result.customPaymentTerms.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTermEntity)]))
              as BuiltList);
          break;
        case 'invoice_fields':
          result.invoiceFields = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_footer':
          result.emailFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_invoice':
          result.emailSubjectInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_quote':
          result.emailSubjectQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_payment':
          result.emailSubjectPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_invoice':
          result.emailBodyInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_quote':
          result.emailBodyQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_payment':
          result.emailBodyPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder1':
          result.emailSubjectReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder2':
          result.emailSubjectReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder3':
          result.emailSubjectReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder1':
          result.emailBodyReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder2':
          result.emailBodyReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder3':
          result.emailBodyReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fill_products':
          result.fillProducts = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_portal_password':
          result.enablePortalPassword = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design1':
          result.hasCustomDesign1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design2':
          result.hasCustomDesign2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design3':
          result.hasCustomDesign3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentTermEntitySerializer
    implements StructuredSerializer<PaymentTermEntity> {
  @override
  final Iterable<Type> types = const [PaymentTermEntity, _$PaymentTermEntity];
  @override
  final String wireName = 'PaymentTermEntity';

  @override
  Iterable serialize(Serializers serializers, PaymentTermEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.numDays != null) {
      result
        ..add('num_days')
        ..add(serializers.serialize(object.numDays,
            specifiedType: const FullType(int)));
    }
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
  PaymentTermEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTermEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'num_days':
          result.numDays = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$TaxRateEntitySerializer implements StructuredSerializer<TaxRateEntity> {
  @override
  final Iterable<Type> types = const [TaxRateEntity, _$TaxRateEntity];
  @override
  final String wireName = 'TaxRateEntity';

  @override
  Iterable serialize(Serializers serializers, TaxRateEntity object,
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'first_name',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'last_name',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'is_admin',
      serializers.serialize(object.isAdmin,
          specifiedType: const FullType(bool)),
      'permissions',
      serializers.serialize(object.permissionsMap,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(String), const FullType(bool)])),
    ];

    return result;
  }

  @override
  UserEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
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
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_admin':
          result.isAdmin = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'permissions':
          result.permissionsMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(bool)
              ])) as BuiltMap);
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
  final String appUrl;
  @override
  final int companyCurrencyId;
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
  final BuiltList<TaskStatusEntity> taskStatuses;
  @override
  final BuiltMap<int, TaskStatusEntity> taskStatusMap;
  @override
  final UserEntity user;
  @override
  final BuiltMap<String, String> customFields;
  @override
  final BuiltList<PaymentTermEntity> customPaymentTerms;
  @override
  final String invoiceFields;
  @override
  final String emailFooter;
  @override
  final String emailSubjectInvoice;
  @override
  final String emailSubjectQuote;
  @override
  final String emailSubjectPayment;
  @override
  final String emailBodyInvoice;
  @override
  final String emailBodyQuote;
  @override
  final String emailBodyPayment;
  @override
  final String emailSubjectReminder1;
  @override
  final String emailSubjectReminder2;
  @override
  final String emailSubjectReminder3;
  @override
  final String emailBodyReminder1;
  @override
  final String emailBodyReminder2;
  @override
  final String emailBodyReminder3;
  @override
  final bool fillProducts;
  @override
  final bool enablePortalPassword;
  @override
  final bool hasCustomDesign1;
  @override
  final bool hasCustomDesign2;
  @override
  final bool hasCustomDesign3;

  factory _$CompanyEntity([void updates(CompanyEntityBuilder b)]) =>
      (new CompanyEntityBuilder()..update(updates)).build();

  _$CompanyEntity._(
      {this.name,
      this.token,
      this.plan,
      this.logoUrl,
      this.appUrl,
      this.companyCurrencyId,
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
      this.taskStatuses,
      this.taskStatusMap,
      this.user,
      this.customFields,
      this.customPaymentTerms,
      this.invoiceFields,
      this.emailFooter,
      this.emailSubjectInvoice,
      this.emailSubjectQuote,
      this.emailSubjectPayment,
      this.emailBodyInvoice,
      this.emailBodyQuote,
      this.emailBodyPayment,
      this.emailSubjectReminder1,
      this.emailSubjectReminder2,
      this.emailSubjectReminder3,
      this.emailBodyReminder1,
      this.emailBodyReminder2,
      this.emailBodyReminder3,
      this.fillProducts,
      this.enablePortalPassword,
      this.hasCustomDesign1,
      this.hasCustomDesign2,
      this.hasCustomDesign3})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'name');
    }
    if (token == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'token');
    }
    if (plan == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'plan');
    }
    if (logoUrl == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'logoUrl');
    }
    if (appUrl == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'appUrl');
    }
    if (companyCurrencyId == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'companyCurrencyId');
    }
    if (timezoneId == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'timezoneId');
    }
    if (countryId == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'countryId');
    }
    if (dateFormatId == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'dateFormatId');
    }
    if (datetimeFormatId == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'datetimeFormatId');
    }
    if (defaultInvoiceTerms == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultInvoiceTerms');
    }
    if (enableInvoiceTaxes == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'enableInvoiceTaxes');
    }
    if (enableInvoiceItemTaxes == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableInvoiceItemTaxes');
    }
    if (defaultInvoiceDesignId == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultInvoiceDesignId');
    }
    if (defaultQuoteDesignId == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultQuoteDesignId');
    }
    if (languageId == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'languageId');
    }
    if (defaultInvoiceFooter == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultInvoiceFooter');
    }
    if (showInvoiceItemTaxes == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'showInvoiceItemTaxes');
    }
    if (enableMilitaryTime == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'enableMilitaryTime');
    }
    if (defaultTaxName1 == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaxName1');
    }
    if (defaultTaxRate1 == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaxRate1');
    }
    if (defaultTaxName2 == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaxName2');
    }
    if (defaultTaxRate2 == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaxRate2');
    }
    if (defaultQuoteTerms == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultQuoteTerms');
    }
    if (showCurrencyCode == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'showCurrencyCode');
    }
    if (enableSecondTaxRate == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableSecondTaxRate');
    }
    if (startOfWeek == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'startOfWeek');
    }
    if (financialYearStart == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'financialYearStart');
    }
    if (enabledModules == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'enabledModules');
    }
    if (defaultPaymentTerms == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultPaymentTerms');
    }
    if (defaultPaymentTypeId == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'defaultPaymentTypeId');
    }
    if (defaultTaskRate == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'defaultTaskRate');
    }
    if (enableInclusiveTaxes == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableInclusiveTaxes');
    }
    if (convertProductExchangeRate == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'convertProductExchangeRate');
    }
    if (enableCustomInvoiceTaxes1 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableCustomInvoiceTaxes1');
    }
    if (enableCustomInvoiceTaxes2 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'enableCustomInvoiceTaxes2');
    }
    if (taxRates == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'taxRates');
    }
    if (taskStatusMap == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'taskStatusMap');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'user');
    }
    if (customFields == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'customFields');
    }
    if (customPaymentTerms == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'customPaymentTerms');
    }
    if (invoiceFields == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'invoiceFields');
    }
    if (emailFooter == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'emailFooter');
    }
    if (emailSubjectInvoice == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'emailSubjectInvoice');
    }
    if (emailSubjectQuote == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'emailSubjectQuote');
    }
    if (emailSubjectPayment == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'emailSubjectPayment');
    }
    if (emailBodyInvoice == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'emailBodyInvoice');
    }
    if (emailBodyQuote == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'emailBodyQuote');
    }
    if (emailBodyPayment == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'emailBodyPayment');
    }
    if (emailSubjectReminder1 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'emailSubjectReminder1');
    }
    if (emailSubjectReminder2 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'emailSubjectReminder2');
    }
    if (emailSubjectReminder3 == null) {
      throw new BuiltValueNullFieldError(
          'CompanyEntity', 'emailSubjectReminder3');
    }
    if (emailBodyReminder1 == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'emailBodyReminder1');
    }
    if (emailBodyReminder2 == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'emailBodyReminder2');
    }
    if (emailBodyReminder3 == null) {
      throw new BuiltValueNullFieldError('CompanyEntity', 'emailBodyReminder3');
    }
  }

  @override
  CompanyEntity rebuild(void updates(CompanyEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyEntityBuilder toBuilder() => new CompanyEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyEntity &&
        name == other.name &&
        token == other.token &&
        plan == other.plan &&
        logoUrl == other.logoUrl &&
        appUrl == other.appUrl &&
        companyCurrencyId == other.companyCurrencyId &&
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
        taskStatuses == other.taskStatuses &&
        taskStatusMap == other.taskStatusMap &&
        user == other.user &&
        customFields == other.customFields &&
        customPaymentTerms == other.customPaymentTerms &&
        invoiceFields == other.invoiceFields &&
        emailFooter == other.emailFooter &&
        emailSubjectInvoice == other.emailSubjectInvoice &&
        emailSubjectQuote == other.emailSubjectQuote &&
        emailSubjectPayment == other.emailSubjectPayment &&
        emailBodyInvoice == other.emailBodyInvoice &&
        emailBodyQuote == other.emailBodyQuote &&
        emailBodyPayment == other.emailBodyPayment &&
        emailSubjectReminder1 == other.emailSubjectReminder1 &&
        emailSubjectReminder2 == other.emailSubjectReminder2 &&
        emailSubjectReminder3 == other.emailSubjectReminder3 &&
        emailBodyReminder1 == other.emailBodyReminder1 &&
        emailBodyReminder2 == other.emailBodyReminder2 &&
        emailBodyReminder3 == other.emailBodyReminder3 &&
        fillProducts == other.fillProducts &&
        enablePortalPassword == other.enablePortalPassword &&
        hasCustomDesign1 == other.hasCustomDesign1 &&
        hasCustomDesign2 == other.hasCustomDesign2 &&
        hasCustomDesign3 == other.hasCustomDesign3;
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, name.hashCode), token.hashCode), plan.hashCode), logoUrl.hashCode), appUrl.hashCode), companyCurrencyId.hashCode), timezoneId.hashCode), countryId.hashCode), dateFormatId.hashCode), datetimeFormatId.hashCode), defaultInvoiceTerms.hashCode), enableInvoiceTaxes.hashCode), enableInvoiceItemTaxes.hashCode), defaultInvoiceDesignId.hashCode), defaultQuoteDesignId.hashCode), languageId.hashCode), defaultInvoiceFooter.hashCode), showInvoiceItemTaxes.hashCode), enableMilitaryTime.hashCode), defaultTaxName1.hashCode), defaultTaxRate1.hashCode), defaultTaxName2.hashCode), defaultTaxRate2.hashCode), defaultQuoteTerms.hashCode), showCurrencyCode.hashCode), enableSecondTaxRate.hashCode), startOfWeek.hashCode), financialYearStart.hashCode), enabledModules.hashCode), defaultPaymentTerms.hashCode), defaultPaymentTypeId.hashCode), defaultTaskRate.hashCode), enableInclusiveTaxes.hashCode), convertProductExchangeRate.hashCode), enableCustomInvoiceTaxes1.hashCode), enableCustomInvoiceTaxes2.hashCode), taxRates.hashCode), taskStatuses.hashCode), taskStatusMap.hashCode), user.hashCode), customFields.hashCode), customPaymentTerms.hashCode),
                                                                                invoiceFields.hashCode),
                                                                            emailFooter.hashCode),
                                                                        emailSubjectInvoice.hashCode),
                                                                    emailSubjectQuote.hashCode),
                                                                emailSubjectPayment.hashCode),
                                                            emailBodyInvoice.hashCode),
                                                        emailBodyQuote.hashCode),
                                                    emailBodyPayment.hashCode),
                                                emailSubjectReminder1.hashCode),
                                            emailSubjectReminder2.hashCode),
                                        emailSubjectReminder3.hashCode),
                                    emailBodyReminder1.hashCode),
                                emailBodyReminder2.hashCode),
                            emailBodyReminder3.hashCode),
                        fillProducts.hashCode),
                    enablePortalPassword.hashCode),
                hasCustomDesign1.hashCode),
            hasCustomDesign2.hashCode),
        hasCustomDesign3.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyEntity')
          ..add('name', name)
          ..add('token', token)
          ..add('plan', plan)
          ..add('logoUrl', logoUrl)
          ..add('appUrl', appUrl)
          ..add('companyCurrencyId', companyCurrencyId)
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
          ..add('taskStatuses', taskStatuses)
          ..add('taskStatusMap', taskStatusMap)
          ..add('user', user)
          ..add('customFields', customFields)
          ..add('customPaymentTerms', customPaymentTerms)
          ..add('invoiceFields', invoiceFields)
          ..add('emailFooter', emailFooter)
          ..add('emailSubjectInvoice', emailSubjectInvoice)
          ..add('emailSubjectQuote', emailSubjectQuote)
          ..add('emailSubjectPayment', emailSubjectPayment)
          ..add('emailBodyInvoice', emailBodyInvoice)
          ..add('emailBodyQuote', emailBodyQuote)
          ..add('emailBodyPayment', emailBodyPayment)
          ..add('emailSubjectReminder1', emailSubjectReminder1)
          ..add('emailSubjectReminder2', emailSubjectReminder2)
          ..add('emailSubjectReminder3', emailSubjectReminder3)
          ..add('emailBodyReminder1', emailBodyReminder1)
          ..add('emailBodyReminder2', emailBodyReminder2)
          ..add('emailBodyReminder3', emailBodyReminder3)
          ..add('fillProducts', fillProducts)
          ..add('enablePortalPassword', enablePortalPassword)
          ..add('hasCustomDesign1', hasCustomDesign1)
          ..add('hasCustomDesign2', hasCustomDesign2)
          ..add('hasCustomDesign3', hasCustomDesign3))
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

  String _appUrl;
  String get appUrl => _$this._appUrl;
  set appUrl(String appUrl) => _$this._appUrl = appUrl;

  int _companyCurrencyId;
  int get companyCurrencyId => _$this._companyCurrencyId;
  set companyCurrencyId(int companyCurrencyId) =>
      _$this._companyCurrencyId = companyCurrencyId;

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

  ListBuilder<TaskStatusEntity> _taskStatuses;
  ListBuilder<TaskStatusEntity> get taskStatuses =>
      _$this._taskStatuses ??= new ListBuilder<TaskStatusEntity>();
  set taskStatuses(ListBuilder<TaskStatusEntity> taskStatuses) =>
      _$this._taskStatuses = taskStatuses;

  MapBuilder<int, TaskStatusEntity> _taskStatusMap;
  MapBuilder<int, TaskStatusEntity> get taskStatusMap =>
      _$this._taskStatusMap ??= new MapBuilder<int, TaskStatusEntity>();
  set taskStatusMap(MapBuilder<int, TaskStatusEntity> taskStatusMap) =>
      _$this._taskStatusMap = taskStatusMap;

  UserEntityBuilder _user;
  UserEntityBuilder get user => _$this._user ??= new UserEntityBuilder();
  set user(UserEntityBuilder user) => _$this._user = user;

  MapBuilder<String, String> _customFields;
  MapBuilder<String, String> get customFields =>
      _$this._customFields ??= new MapBuilder<String, String>();
  set customFields(MapBuilder<String, String> customFields) =>
      _$this._customFields = customFields;

  ListBuilder<PaymentTermEntity> _customPaymentTerms;
  ListBuilder<PaymentTermEntity> get customPaymentTerms =>
      _$this._customPaymentTerms ??= new ListBuilder<PaymentTermEntity>();
  set customPaymentTerms(ListBuilder<PaymentTermEntity> customPaymentTerms) =>
      _$this._customPaymentTerms = customPaymentTerms;

  String _invoiceFields;
  String get invoiceFields => _$this._invoiceFields;
  set invoiceFields(String invoiceFields) =>
      _$this._invoiceFields = invoiceFields;

  String _emailFooter;
  String get emailFooter => _$this._emailFooter;
  set emailFooter(String emailFooter) => _$this._emailFooter = emailFooter;

  String _emailSubjectInvoice;
  String get emailSubjectInvoice => _$this._emailSubjectInvoice;
  set emailSubjectInvoice(String emailSubjectInvoice) =>
      _$this._emailSubjectInvoice = emailSubjectInvoice;

  String _emailSubjectQuote;
  String get emailSubjectQuote => _$this._emailSubjectQuote;
  set emailSubjectQuote(String emailSubjectQuote) =>
      _$this._emailSubjectQuote = emailSubjectQuote;

  String _emailSubjectPayment;
  String get emailSubjectPayment => _$this._emailSubjectPayment;
  set emailSubjectPayment(String emailSubjectPayment) =>
      _$this._emailSubjectPayment = emailSubjectPayment;

  String _emailBodyInvoice;
  String get emailBodyInvoice => _$this._emailBodyInvoice;
  set emailBodyInvoice(String emailBodyInvoice) =>
      _$this._emailBodyInvoice = emailBodyInvoice;

  String _emailBodyQuote;
  String get emailBodyQuote => _$this._emailBodyQuote;
  set emailBodyQuote(String emailBodyQuote) =>
      _$this._emailBodyQuote = emailBodyQuote;

  String _emailBodyPayment;
  String get emailBodyPayment => _$this._emailBodyPayment;
  set emailBodyPayment(String emailBodyPayment) =>
      _$this._emailBodyPayment = emailBodyPayment;

  String _emailSubjectReminder1;
  String get emailSubjectReminder1 => _$this._emailSubjectReminder1;
  set emailSubjectReminder1(String emailSubjectReminder1) =>
      _$this._emailSubjectReminder1 = emailSubjectReminder1;

  String _emailSubjectReminder2;
  String get emailSubjectReminder2 => _$this._emailSubjectReminder2;
  set emailSubjectReminder2(String emailSubjectReminder2) =>
      _$this._emailSubjectReminder2 = emailSubjectReminder2;

  String _emailSubjectReminder3;
  String get emailSubjectReminder3 => _$this._emailSubjectReminder3;
  set emailSubjectReminder3(String emailSubjectReminder3) =>
      _$this._emailSubjectReminder3 = emailSubjectReminder3;

  String _emailBodyReminder1;
  String get emailBodyReminder1 => _$this._emailBodyReminder1;
  set emailBodyReminder1(String emailBodyReminder1) =>
      _$this._emailBodyReminder1 = emailBodyReminder1;

  String _emailBodyReminder2;
  String get emailBodyReminder2 => _$this._emailBodyReminder2;
  set emailBodyReminder2(String emailBodyReminder2) =>
      _$this._emailBodyReminder2 = emailBodyReminder2;

  String _emailBodyReminder3;
  String get emailBodyReminder3 => _$this._emailBodyReminder3;
  set emailBodyReminder3(String emailBodyReminder3) =>
      _$this._emailBodyReminder3 = emailBodyReminder3;

  bool _fillProducts;
  bool get fillProducts => _$this._fillProducts;
  set fillProducts(bool fillProducts) => _$this._fillProducts = fillProducts;

  bool _enablePortalPassword;
  bool get enablePortalPassword => _$this._enablePortalPassword;
  set enablePortalPassword(bool enablePortalPassword) =>
      _$this._enablePortalPassword = enablePortalPassword;

  bool _hasCustomDesign1;
  bool get hasCustomDesign1 => _$this._hasCustomDesign1;
  set hasCustomDesign1(bool hasCustomDesign1) =>
      _$this._hasCustomDesign1 = hasCustomDesign1;

  bool _hasCustomDesign2;
  bool get hasCustomDesign2 => _$this._hasCustomDesign2;
  set hasCustomDesign2(bool hasCustomDesign2) =>
      _$this._hasCustomDesign2 = hasCustomDesign2;

  bool _hasCustomDesign3;
  bool get hasCustomDesign3 => _$this._hasCustomDesign3;
  set hasCustomDesign3(bool hasCustomDesign3) =>
      _$this._hasCustomDesign3 = hasCustomDesign3;

  CompanyEntityBuilder();

  CompanyEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _token = _$v.token;
      _plan = _$v.plan;
      _logoUrl = _$v.logoUrl;
      _appUrl = _$v.appUrl;
      _companyCurrencyId = _$v.companyCurrencyId;
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
      _taskStatuses = _$v.taskStatuses?.toBuilder();
      _taskStatusMap = _$v.taskStatusMap?.toBuilder();
      _user = _$v.user?.toBuilder();
      _customFields = _$v.customFields?.toBuilder();
      _customPaymentTerms = _$v.customPaymentTerms?.toBuilder();
      _invoiceFields = _$v.invoiceFields;
      _emailFooter = _$v.emailFooter;
      _emailSubjectInvoice = _$v.emailSubjectInvoice;
      _emailSubjectQuote = _$v.emailSubjectQuote;
      _emailSubjectPayment = _$v.emailSubjectPayment;
      _emailBodyInvoice = _$v.emailBodyInvoice;
      _emailBodyQuote = _$v.emailBodyQuote;
      _emailBodyPayment = _$v.emailBodyPayment;
      _emailSubjectReminder1 = _$v.emailSubjectReminder1;
      _emailSubjectReminder2 = _$v.emailSubjectReminder2;
      _emailSubjectReminder3 = _$v.emailSubjectReminder3;
      _emailBodyReminder1 = _$v.emailBodyReminder1;
      _emailBodyReminder2 = _$v.emailBodyReminder2;
      _emailBodyReminder3 = _$v.emailBodyReminder3;
      _fillProducts = _$v.fillProducts;
      _enablePortalPassword = _$v.enablePortalPassword;
      _hasCustomDesign1 = _$v.hasCustomDesign1;
      _hasCustomDesign2 = _$v.hasCustomDesign2;
      _hasCustomDesign3 = _$v.hasCustomDesign3;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              appUrl: appUrl,
              companyCurrencyId: companyCurrencyId,
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
              taskStatuses: _taskStatuses?.build(),
              taskStatusMap: taskStatusMap.build(),
              user: user.build(),
              customFields: customFields.build(),
              customPaymentTerms: customPaymentTerms.build(),
              invoiceFields: invoiceFields,
              emailFooter: emailFooter,
              emailSubjectInvoice: emailSubjectInvoice,
              emailSubjectQuote: emailSubjectQuote,
              emailSubjectPayment: emailSubjectPayment,
              emailBodyInvoice: emailBodyInvoice,
              emailBodyQuote: emailBodyQuote,
              emailBodyPayment: emailBodyPayment,
              emailSubjectReminder1: emailSubjectReminder1,
              emailSubjectReminder2: emailSubjectReminder2,
              emailSubjectReminder3: emailSubjectReminder3,
              emailBodyReminder1: emailBodyReminder1,
              emailBodyReminder2: emailBodyReminder2,
              emailBodyReminder3: emailBodyReminder3,
              fillProducts: fillProducts,
              enablePortalPassword: enablePortalPassword,
              hasCustomDesign1: hasCustomDesign1,
              hasCustomDesign2: hasCustomDesign2,
              hasCustomDesign3: hasCustomDesign3);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'taxRates';
        taxRates.build();
        _$failedField = 'taskStatuses';
        _taskStatuses?.build();
        _$failedField = 'taskStatusMap';
        taskStatusMap.build();
        _$failedField = 'user';
        user.build();
        _$failedField = 'customFields';
        customFields.build();
        _$failedField = 'customPaymentTerms';
        customPaymentTerms.build();
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

class _$PaymentTermEntity extends PaymentTermEntity {
  @override
  final int numDays;
  @override
  final int archivedAt;
  @override
  final int id;

  factory _$PaymentTermEntity([void updates(PaymentTermEntityBuilder b)]) =>
      (new PaymentTermEntityBuilder()..update(updates)).build();

  _$PaymentTermEntity._({this.numDays, this.archivedAt, this.id}) : super._();

  @override
  PaymentTermEntity rebuild(void updates(PaymentTermEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTermEntityBuilder toBuilder() =>
      new PaymentTermEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTermEntity &&
        numDays == other.numDays &&
        archivedAt == other.archivedAt &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, numDays.hashCode), archivedAt.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentTermEntity')
          ..add('numDays', numDays)
          ..add('archivedAt', archivedAt)
          ..add('id', id))
        .toString();
  }
}

class PaymentTermEntityBuilder
    implements Builder<PaymentTermEntity, PaymentTermEntityBuilder> {
  _$PaymentTermEntity _$v;

  int _numDays;
  int get numDays => _$this._numDays;
  set numDays(int numDays) => _$this._numDays = numDays;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  PaymentTermEntityBuilder();

  PaymentTermEntityBuilder get _$this {
    if (_$v != null) {
      _numDays = _$v.numDays;
      _archivedAt = _$v.archivedAt;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTermEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentTermEntity;
  }

  @override
  void update(void updates(PaymentTermEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTermEntity build() {
    final _$result = _$v ??
        new _$PaymentTermEntity._(
            numDays: numDays, archivedAt: archivedAt, id: id);
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
    if (name == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'name');
    }
    if (rate == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'rate');
    }
    if (isInclusive == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'isInclusive');
    }
  }

  @override
  TaxRateEntity rebuild(void updates(TaxRateEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxRateEntityBuilder toBuilder() => new TaxRateEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxRateEntity &&
        name == other.name &&
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
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
  @override
  final String email;
  @override
  final bool isAdmin;
  @override
  final BuiltMap<String, bool> permissionsMap;

  factory _$UserEntity([void updates(UserEntityBuilder b)]) =>
      (new UserEntityBuilder()..update(updates)).build();

  _$UserEntity._(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.isAdmin,
      this.permissionsMap})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'id');
    }
    if (firstName == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'firstName');
    }
    if (lastName == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'lastName');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'email');
    }
    if (isAdmin == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'isAdmin');
    }
    if (permissionsMap == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'permissionsMap');
    }
  }

  @override
  UserEntity rebuild(void updates(UserEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserEntityBuilder toBuilder() => new UserEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserEntity &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        isAdmin == other.isAdmin &&
        permissionsMap == other.permissionsMap;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), firstName.hashCode),
                    lastName.hashCode),
                email.hashCode),
            isAdmin.hashCode),
        permissionsMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserEntity')
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('isAdmin', isAdmin)
          ..add('permissionsMap', permissionsMap))
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

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  bool _isAdmin;
  bool get isAdmin => _$this._isAdmin;
  set isAdmin(bool isAdmin) => _$this._isAdmin = isAdmin;

  MapBuilder<String, bool> _permissionsMap;
  MapBuilder<String, bool> get permissionsMap =>
      _$this._permissionsMap ??= new MapBuilder<String, bool>();
  set permissionsMap(MapBuilder<String, bool> permissionsMap) =>
      _$this._permissionsMap = permissionsMap;

  UserEntityBuilder();

  UserEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _email = _$v.email;
      _isAdmin = _$v.isAdmin;
      _permissionsMap = _$v.permissionsMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserEntity;
  }

  @override
  void update(void updates(UserEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserEntity build() {
    _$UserEntity _$result;
    try {
      _$result = _$v ??
          new _$UserEntity._(
              id: id,
              firstName: firstName,
              lastName: lastName,
              email: email,
              isAdmin: isAdmin,
              permissionsMap: permissionsMap.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'permissionsMap';
        permissionsMap.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
