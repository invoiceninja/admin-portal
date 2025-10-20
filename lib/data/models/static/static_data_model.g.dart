// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_data_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<StaticDataListResponse> _$staticDataListResponseSerializer =
    _$StaticDataListResponseSerializer();
Serializer<StaticDataItemResponse> _$staticDataItemResponseSerializer =
    _$StaticDataItemResponseSerializer();
Serializer<StaticDataEntity> _$staticDataEntitySerializer =
    _$StaticDataEntitySerializer();
Serializer<TemplateEntity> _$templateEntitySerializer =
    _$TemplateEntitySerializer();

class _$StaticDataListResponseSerializer
    implements StructuredSerializer<StaticDataListResponse> {
  @override
  final Iterable<Type> types = const [
    StaticDataListResponse,
    _$StaticDataListResponse
  ];
  @override
  final String wireName = 'StaticDataListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, StaticDataListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(StaticDataEntity)])),
    ];

    return result;
  }

  @override
  StaticDataListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = StaticDataListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(StaticDataEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$StaticDataItemResponseSerializer
    implements StructuredSerializer<StaticDataItemResponse> {
  @override
  final Iterable<Type> types = const [
    StaticDataItemResponse,
    _$StaticDataItemResponse
  ];
  @override
  final String wireName = 'StaticDataItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, StaticDataItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(StaticDataEntity)),
    ];

    return result;
  }

  @override
  StaticDataItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = StaticDataItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(StaticDataEntity))!
              as StaticDataEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$StaticDataEntitySerializer
    implements StructuredSerializer<StaticDataEntity> {
  @override
  final Iterable<Type> types = const [StaticDataEntity, _$StaticDataEntity];
  @override
  final String wireName = 'StaticDataEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, StaticDataEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      'gateways',
      serializers.serialize(object.gateways,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GatewayEntity)])),
      'date_formats',
      serializers.serialize(object.dateFormats,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DateFormatEntity)])),
      'languages',
      serializers.serialize(object.languages,
          specifiedType: const FullType(
              BuiltList, const [const FullType(LanguageEntity)])),
      'payment_types',
      serializers.serialize(object.paymentTypes,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTypeEntity)])),
      'countries',
      serializers.serialize(object.countries,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CountryEntity)])),
      'invoice_status',
      serializers.serialize(object.invoiceStatus,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceStatusEntity)])),
      'bulk_updates',
      serializers.serialize(object.bulkUpdates,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltList, const [const FullType(String)])
          ])),
      'templates',
      serializers.serialize(object.templates,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(TemplateEntity)])),
      'einvoice_schema',
      serializers.serialize(object.eInvoiceSchema,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(EInvoiceFieldEntity)
          ])),
    ];

    return result;
  }

  @override
  StaticDataEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = StaticDataEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'currencies':
          result.currencies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CurrencyEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'sizes':
          result.sizes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SizeEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'industries':
          result.industries.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(IndustryEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'timezones':
          result.timezones.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimezoneEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'gateways':
          result.gateways.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GatewayEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'date_formats':
          result.dateFormats.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DateFormatEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'languages':
          result.languages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LanguageEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'payment_types':
          result.paymentTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTypeEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'countries':
          result.countries.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CountryEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'invoice_status':
          result.invoiceStatus.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceStatusEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'bulk_updates':
          result.bulkUpdates.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(String)])
              ]))!);
          break;
        case 'templates':
          result.templates.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TemplateEntity)
              ]))!);
          break;
        case 'einvoice_schema':
          result.eInvoiceSchema.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(EInvoiceFieldEntity)
              ]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$TemplateEntitySerializer
    implements StructuredSerializer<TemplateEntity> {
  @override
  final Iterable<Type> types = const [TemplateEntity, _$TemplateEntity];
  @override
  final String wireName = 'TemplateEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, TemplateEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TemplateEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = TemplateEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$StaticDataListResponse extends StaticDataListResponse {
  @override
  final BuiltList<StaticDataEntity> data;

  factory _$StaticDataListResponse(
          [void Function(StaticDataListResponseBuilder)? updates]) =>
      (StaticDataListResponseBuilder()..update(updates))._build();

  _$StaticDataListResponse._({required this.data}) : super._();
  @override
  StaticDataListResponse rebuild(
          void Function(StaticDataListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataListResponseBuilder toBuilder() =>
      StaticDataListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticDataListResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StaticDataListResponse')
          ..add('data', data))
        .toString();
  }
}

class StaticDataListResponseBuilder
    implements Builder<StaticDataListResponse, StaticDataListResponseBuilder> {
  _$StaticDataListResponse? _$v;

  ListBuilder<StaticDataEntity>? _data;
  ListBuilder<StaticDataEntity> get data =>
      _$this._data ??= ListBuilder<StaticDataEntity>();
  set data(ListBuilder<StaticDataEntity>? data) => _$this._data = data;

  StaticDataListResponseBuilder();

  StaticDataListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticDataListResponse other) {
    _$v = other as _$StaticDataListResponse;
  }

  @override
  void update(void Function(StaticDataListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StaticDataListResponse build() => _build();

  _$StaticDataListResponse _build() {
    _$StaticDataListResponse _$result;
    try {
      _$result = _$v ??
          _$StaticDataListResponse._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StaticDataListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StaticDataItemResponse extends StaticDataItemResponse {
  @override
  final StaticDataEntity data;

  factory _$StaticDataItemResponse(
          [void Function(StaticDataItemResponseBuilder)? updates]) =>
      (StaticDataItemResponseBuilder()..update(updates))._build();

  _$StaticDataItemResponse._({required this.data}) : super._();
  @override
  StaticDataItemResponse rebuild(
          void Function(StaticDataItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataItemResponseBuilder toBuilder() =>
      StaticDataItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticDataItemResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StaticDataItemResponse')
          ..add('data', data))
        .toString();
  }
}

class StaticDataItemResponseBuilder
    implements Builder<StaticDataItemResponse, StaticDataItemResponseBuilder> {
  _$StaticDataItemResponse? _$v;

  StaticDataEntityBuilder? _data;
  StaticDataEntityBuilder get data =>
      _$this._data ??= StaticDataEntityBuilder();
  set data(StaticDataEntityBuilder? data) => _$this._data = data;

  StaticDataItemResponseBuilder();

  StaticDataItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticDataItemResponse other) {
    _$v = other as _$StaticDataItemResponse;
  }

  @override
  void update(void Function(StaticDataItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StaticDataItemResponse build() => _build();

  _$StaticDataItemResponse _build() {
    _$StaticDataItemResponse _$result;
    try {
      _$result = _$v ??
          _$StaticDataItemResponse._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StaticDataItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StaticDataEntity extends StaticDataEntity {
  @override
  final BuiltList<CurrencyEntity> currencies;
  @override
  final BuiltList<SizeEntity> sizes;
  @override
  final BuiltList<IndustryEntity> industries;
  @override
  final BuiltList<TimezoneEntity> timezones;
  @override
  final BuiltList<GatewayEntity> gateways;
  @override
  final BuiltList<DateFormatEntity> dateFormats;
  @override
  final BuiltList<LanguageEntity> languages;
  @override
  final BuiltList<PaymentTypeEntity> paymentTypes;
  @override
  final BuiltList<CountryEntity> countries;
  @override
  final BuiltList<InvoiceStatusEntity> invoiceStatus;
  @override
  final BuiltMap<String, BuiltList<String>> bulkUpdates;
  @override
  final BuiltMap<String, TemplateEntity> templates;
  @override
  final BuiltMap<String, EInvoiceFieldEntity> eInvoiceSchema;

  factory _$StaticDataEntity(
          [void Function(StaticDataEntityBuilder)? updates]) =>
      (StaticDataEntityBuilder()..update(updates))._build();

  _$StaticDataEntity._(
      {required this.currencies,
      required this.sizes,
      required this.industries,
      required this.timezones,
      required this.gateways,
      required this.dateFormats,
      required this.languages,
      required this.paymentTypes,
      required this.countries,
      required this.invoiceStatus,
      required this.bulkUpdates,
      required this.templates,
      required this.eInvoiceSchema})
      : super._();
  @override
  StaticDataEntity rebuild(void Function(StaticDataEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataEntityBuilder toBuilder() =>
      StaticDataEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticDataEntity &&
        currencies == other.currencies &&
        sizes == other.sizes &&
        industries == other.industries &&
        timezones == other.timezones &&
        gateways == other.gateways &&
        dateFormats == other.dateFormats &&
        languages == other.languages &&
        paymentTypes == other.paymentTypes &&
        countries == other.countries &&
        invoiceStatus == other.invoiceStatus &&
        bulkUpdates == other.bulkUpdates &&
        templates == other.templates &&
        eInvoiceSchema == other.eInvoiceSchema;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, currencies.hashCode);
    _$hash = $jc(_$hash, sizes.hashCode);
    _$hash = $jc(_$hash, industries.hashCode);
    _$hash = $jc(_$hash, timezones.hashCode);
    _$hash = $jc(_$hash, gateways.hashCode);
    _$hash = $jc(_$hash, dateFormats.hashCode);
    _$hash = $jc(_$hash, languages.hashCode);
    _$hash = $jc(_$hash, paymentTypes.hashCode);
    _$hash = $jc(_$hash, countries.hashCode);
    _$hash = $jc(_$hash, invoiceStatus.hashCode);
    _$hash = $jc(_$hash, bulkUpdates.hashCode);
    _$hash = $jc(_$hash, templates.hashCode);
    _$hash = $jc(_$hash, eInvoiceSchema.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StaticDataEntity')
          ..add('currencies', currencies)
          ..add('sizes', sizes)
          ..add('industries', industries)
          ..add('timezones', timezones)
          ..add('gateways', gateways)
          ..add('dateFormats', dateFormats)
          ..add('languages', languages)
          ..add('paymentTypes', paymentTypes)
          ..add('countries', countries)
          ..add('invoiceStatus', invoiceStatus)
          ..add('bulkUpdates', bulkUpdates)
          ..add('templates', templates)
          ..add('eInvoiceSchema', eInvoiceSchema))
        .toString();
  }
}

class StaticDataEntityBuilder
    implements Builder<StaticDataEntity, StaticDataEntityBuilder> {
  _$StaticDataEntity? _$v;

  ListBuilder<CurrencyEntity>? _currencies;
  ListBuilder<CurrencyEntity> get currencies =>
      _$this._currencies ??= ListBuilder<CurrencyEntity>();
  set currencies(ListBuilder<CurrencyEntity>? currencies) =>
      _$this._currencies = currencies;

  ListBuilder<SizeEntity>? _sizes;
  ListBuilder<SizeEntity> get sizes =>
      _$this._sizes ??= ListBuilder<SizeEntity>();
  set sizes(ListBuilder<SizeEntity>? sizes) => _$this._sizes = sizes;

  ListBuilder<IndustryEntity>? _industries;
  ListBuilder<IndustryEntity> get industries =>
      _$this._industries ??= ListBuilder<IndustryEntity>();
  set industries(ListBuilder<IndustryEntity>? industries) =>
      _$this._industries = industries;

  ListBuilder<TimezoneEntity>? _timezones;
  ListBuilder<TimezoneEntity> get timezones =>
      _$this._timezones ??= ListBuilder<TimezoneEntity>();
  set timezones(ListBuilder<TimezoneEntity>? timezones) =>
      _$this._timezones = timezones;

  ListBuilder<GatewayEntity>? _gateways;
  ListBuilder<GatewayEntity> get gateways =>
      _$this._gateways ??= ListBuilder<GatewayEntity>();
  set gateways(ListBuilder<GatewayEntity>? gateways) =>
      _$this._gateways = gateways;

  ListBuilder<DateFormatEntity>? _dateFormats;
  ListBuilder<DateFormatEntity> get dateFormats =>
      _$this._dateFormats ??= ListBuilder<DateFormatEntity>();
  set dateFormats(ListBuilder<DateFormatEntity>? dateFormats) =>
      _$this._dateFormats = dateFormats;

  ListBuilder<LanguageEntity>? _languages;
  ListBuilder<LanguageEntity> get languages =>
      _$this._languages ??= ListBuilder<LanguageEntity>();
  set languages(ListBuilder<LanguageEntity>? languages) =>
      _$this._languages = languages;

  ListBuilder<PaymentTypeEntity>? _paymentTypes;
  ListBuilder<PaymentTypeEntity> get paymentTypes =>
      _$this._paymentTypes ??= ListBuilder<PaymentTypeEntity>();
  set paymentTypes(ListBuilder<PaymentTypeEntity>? paymentTypes) =>
      _$this._paymentTypes = paymentTypes;

  ListBuilder<CountryEntity>? _countries;
  ListBuilder<CountryEntity> get countries =>
      _$this._countries ??= ListBuilder<CountryEntity>();
  set countries(ListBuilder<CountryEntity>? countries) =>
      _$this._countries = countries;

  ListBuilder<InvoiceStatusEntity>? _invoiceStatus;
  ListBuilder<InvoiceStatusEntity> get invoiceStatus =>
      _$this._invoiceStatus ??= ListBuilder<InvoiceStatusEntity>();
  set invoiceStatus(ListBuilder<InvoiceStatusEntity>? invoiceStatus) =>
      _$this._invoiceStatus = invoiceStatus;

  MapBuilder<String, BuiltList<String>>? _bulkUpdates;
  MapBuilder<String, BuiltList<String>> get bulkUpdates =>
      _$this._bulkUpdates ??= MapBuilder<String, BuiltList<String>>();
  set bulkUpdates(MapBuilder<String, BuiltList<String>>? bulkUpdates) =>
      _$this._bulkUpdates = bulkUpdates;

  MapBuilder<String, TemplateEntity>? _templates;
  MapBuilder<String, TemplateEntity> get templates =>
      _$this._templates ??= MapBuilder<String, TemplateEntity>();
  set templates(MapBuilder<String, TemplateEntity>? templates) =>
      _$this._templates = templates;

  MapBuilder<String, EInvoiceFieldEntity>? _eInvoiceSchema;
  MapBuilder<String, EInvoiceFieldEntity> get eInvoiceSchema =>
      _$this._eInvoiceSchema ??= MapBuilder<String, EInvoiceFieldEntity>();
  set eInvoiceSchema(MapBuilder<String, EInvoiceFieldEntity>? eInvoiceSchema) =>
      _$this._eInvoiceSchema = eInvoiceSchema;

  StaticDataEntityBuilder() {
    StaticDataEntity._initializeBuilder(this);
  }

  StaticDataEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currencies = $v.currencies.toBuilder();
      _sizes = $v.sizes.toBuilder();
      _industries = $v.industries.toBuilder();
      _timezones = $v.timezones.toBuilder();
      _gateways = $v.gateways.toBuilder();
      _dateFormats = $v.dateFormats.toBuilder();
      _languages = $v.languages.toBuilder();
      _paymentTypes = $v.paymentTypes.toBuilder();
      _countries = $v.countries.toBuilder();
      _invoiceStatus = $v.invoiceStatus.toBuilder();
      _bulkUpdates = $v.bulkUpdates.toBuilder();
      _templates = $v.templates.toBuilder();
      _eInvoiceSchema = $v.eInvoiceSchema.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticDataEntity other) {
    _$v = other as _$StaticDataEntity;
  }

  @override
  void update(void Function(StaticDataEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StaticDataEntity build() => _build();

  _$StaticDataEntity _build() {
    _$StaticDataEntity _$result;
    try {
      _$result = _$v ??
          _$StaticDataEntity._(
            currencies: currencies.build(),
            sizes: sizes.build(),
            industries: industries.build(),
            timezones: timezones.build(),
            gateways: gateways.build(),
            dateFormats: dateFormats.build(),
            languages: languages.build(),
            paymentTypes: paymentTypes.build(),
            countries: countries.build(),
            invoiceStatus: invoiceStatus.build(),
            bulkUpdates: bulkUpdates.build(),
            templates: templates.build(),
            eInvoiceSchema: eInvoiceSchema.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'currencies';
        currencies.build();
        _$failedField = 'sizes';
        sizes.build();
        _$failedField = 'industries';
        industries.build();
        _$failedField = 'timezones';
        timezones.build();
        _$failedField = 'gateways';
        gateways.build();
        _$failedField = 'dateFormats';
        dateFormats.build();
        _$failedField = 'languages';
        languages.build();
        _$failedField = 'paymentTypes';
        paymentTypes.build();
        _$failedField = 'countries';
        countries.build();
        _$failedField = 'invoiceStatus';
        invoiceStatus.build();
        _$failedField = 'bulkUpdates';
        bulkUpdates.build();
        _$failedField = 'templates';
        templates.build();
        _$failedField = 'eInvoiceSchema';
        eInvoiceSchema.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StaticDataEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TemplateEntity extends TemplateEntity {
  @override
  final String subject;
  @override
  final String body;

  factory _$TemplateEntity([void Function(TemplateEntityBuilder)? updates]) =>
      (TemplateEntityBuilder()..update(updates))._build();

  _$TemplateEntity._({required this.subject, required this.body}) : super._();
  @override
  TemplateEntity rebuild(void Function(TemplateEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TemplateEntityBuilder toBuilder() => TemplateEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TemplateEntity &&
        subject == other.subject &&
        body == other.body;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TemplateEntity')
          ..add('subject', subject)
          ..add('body', body))
        .toString();
  }
}

class TemplateEntityBuilder
    implements Builder<TemplateEntity, TemplateEntityBuilder> {
  _$TemplateEntity? _$v;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  TemplateEntityBuilder();

  TemplateEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subject = $v.subject;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TemplateEntity other) {
    _$v = other as _$TemplateEntity;
  }

  @override
  void update(void Function(TemplateEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TemplateEntity build() => _build();

  _$TemplateEntity _build() {
    final _$result = _$v ??
        _$TemplateEntity._(
          subject: BuiltValueNullFieldError.checkNotNull(
              subject, r'TemplateEntity', 'subject'),
          body: BuiltValueNullFieldError.checkNotNull(
              body, r'TemplateEntity', 'body'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
