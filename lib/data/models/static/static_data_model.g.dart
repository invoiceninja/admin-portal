// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_data_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<StaticDataListResponse> _$staticDataListResponseSerializer =
    new _$StaticDataListResponseSerializer();
Serializer<StaticDataItemResponse> _$staticDataItemResponseSerializer =
    new _$StaticDataItemResponseSerializer();
Serializer<StaticDataEntity> _$staticDataEntitySerializer =
    new _$StaticDataEntitySerializer();
Serializer<TemplateEntity> _$templateEntitySerializer =
    new _$TemplateEntitySerializer();

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
  Iterable<Object> serialize(
      Serializers serializers, StaticDataListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(StaticDataEntity)])),
    ];

    return result;
  }

  @override
  StaticDataListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StaticDataListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(StaticDataEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(
      Serializers serializers, StaticDataItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(StaticDataEntity)),
    ];

    return result;
  }

  @override
  StaticDataItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StaticDataItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(StaticDataEntity))
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
  Iterable<Object> serialize(Serializers serializers, StaticDataEntity object,
      {FullType specifiedType = FullType.unspecified}) {
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
      'gateways',
      serializers.serialize(object.gateways,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GatewayEntity)])),
      'date_formats',
      serializers.serialize(object.dateFormats,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DateFormatEntity)])),
      'datetime_formats',
      serializers.serialize(object.datetimeFormats,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DatetimeFormatEntity)])),
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
      'templates',
      serializers.serialize(object.templates,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(TemplateEntity)])),
    ];

    return result;
  }

  @override
  StaticDataEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StaticDataEntityBuilder();

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
              as BuiltList<Object>);
          break;
        case 'sizes':
          result.sizes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SizeEntity)]))
              as BuiltList<Object>);
          break;
        case 'industries':
          result.industries.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(IndustryEntity)]))
              as BuiltList<Object>);
          break;
        case 'timezones':
          result.timezones.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimezoneEntity)]))
              as BuiltList<Object>);
          break;
        case 'gateways':
          result.gateways.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GatewayEntity)]))
              as BuiltList<Object>);
          break;
        case 'date_formats':
          result.dateFormats.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DateFormatEntity)]))
              as BuiltList<Object>);
          break;
        case 'datetime_formats':
          result.datetimeFormats.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DatetimeFormatEntity)]))
              as BuiltList<Object>);
          break;
        case 'languages':
          result.languages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LanguageEntity)]))
              as BuiltList<Object>);
          break;
        case 'payment_types':
          result.paymentTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTypeEntity)]))
              as BuiltList<Object>);
          break;
        case 'countries':
          result.countries.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CountryEntity)]))
              as BuiltList<Object>);
          break;
        case 'invoice_status':
          result.invoiceStatus.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceStatusEntity)]))
              as BuiltList<Object>);
          break;
        case 'templates':
          result.templates.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TemplateEntity)
              ])));
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
  Iterable<Object> serialize(Serializers serializers, TemplateEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TemplateEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
          [void Function(StaticDataListResponseBuilder) updates]) =>
      (new StaticDataListResponseBuilder()..update(updates)).build();

  _$StaticDataListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('StaticDataListResponse', 'data');
    }
  }

  @override
  StaticDataListResponse rebuild(
          void Function(StaticDataListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataListResponseBuilder toBuilder() =>
      new StaticDataListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticDataListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticDataListResponse')
          ..add('data', data))
        .toString();
  }
}

class StaticDataListResponseBuilder
    implements Builder<StaticDataListResponse, StaticDataListResponseBuilder> {
  _$StaticDataListResponse _$v;

  ListBuilder<StaticDataEntity> _data;
  ListBuilder<StaticDataEntity> get data =>
      _$this._data ??= new ListBuilder<StaticDataEntity>();
  set data(ListBuilder<StaticDataEntity> data) => _$this._data = data;

  StaticDataListResponseBuilder();

  StaticDataListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticDataListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StaticDataListResponse;
  }

  @override
  void update(void Function(StaticDataListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticDataListResponse build() {
    _$StaticDataListResponse _$result;
    try {
      _$result = _$v ?? new _$StaticDataListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StaticDataListResponse', _$failedField, e.toString());
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
          [void Function(StaticDataItemResponseBuilder) updates]) =>
      (new StaticDataItemResponseBuilder()..update(updates)).build();

  _$StaticDataItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('StaticDataItemResponse', 'data');
    }
  }

  @override
  StaticDataItemResponse rebuild(
          void Function(StaticDataItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataItemResponseBuilder toBuilder() =>
      new StaticDataItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticDataItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticDataItemResponse')
          ..add('data', data))
        .toString();
  }
}

class StaticDataItemResponseBuilder
    implements Builder<StaticDataItemResponse, StaticDataItemResponseBuilder> {
  _$StaticDataItemResponse _$v;

  StaticDataEntityBuilder _data;
  StaticDataEntityBuilder get data =>
      _$this._data ??= new StaticDataEntityBuilder();
  set data(StaticDataEntityBuilder data) => _$this._data = data;

  StaticDataItemResponseBuilder();

  StaticDataItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticDataItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StaticDataItemResponse;
  }

  @override
  void update(void Function(StaticDataItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticDataItemResponse build() {
    _$StaticDataItemResponse _$result;
    try {
      _$result = _$v ?? new _$StaticDataItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StaticDataItemResponse', _$failedField, e.toString());
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
  final BuiltMap<String, TemplateEntity> templates;

  factory _$StaticDataEntity(
          [void Function(StaticDataEntityBuilder) updates]) =>
      (new StaticDataEntityBuilder()..update(updates)).build();

  _$StaticDataEntity._(
      {this.currencies,
      this.sizes,
      this.industries,
      this.timezones,
      this.gateways,
      this.dateFormats,
      this.datetimeFormats,
      this.languages,
      this.paymentTypes,
      this.countries,
      this.invoiceStatus,
      this.templates})
      : super._() {
    if (currencies == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'currencies');
    }
    if (sizes == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'sizes');
    }
    if (industries == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'industries');
    }
    if (timezones == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'timezones');
    }
    if (gateways == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'gateways');
    }
    if (dateFormats == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'dateFormats');
    }
    if (datetimeFormats == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'datetimeFormats');
    }
    if (languages == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'languages');
    }
    if (paymentTypes == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'paymentTypes');
    }
    if (countries == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'countries');
    }
    if (invoiceStatus == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'invoiceStatus');
    }
    if (templates == null) {
      throw new BuiltValueNullFieldError('StaticDataEntity', 'templates');
    }
  }

  @override
  StaticDataEntity rebuild(void Function(StaticDataEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataEntityBuilder toBuilder() =>
      new StaticDataEntityBuilder()..replace(this);

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
        datetimeFormats == other.datetimeFormats &&
        languages == other.languages &&
        paymentTypes == other.paymentTypes &&
        countries == other.countries &&
        invoiceStatus == other.invoiceStatus &&
        templates == other.templates;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
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
                                    gateways.hashCode),
                                dateFormats.hashCode),
                            datetimeFormats.hashCode),
                        languages.hashCode),
                    paymentTypes.hashCode),
                countries.hashCode),
            invoiceStatus.hashCode),
        templates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticDataEntity')
          ..add('currencies', currencies)
          ..add('sizes', sizes)
          ..add('industries', industries)
          ..add('timezones', timezones)
          ..add('gateways', gateways)
          ..add('dateFormats', dateFormats)
          ..add('datetimeFormats', datetimeFormats)
          ..add('languages', languages)
          ..add('paymentTypes', paymentTypes)
          ..add('countries', countries)
          ..add('invoiceStatus', invoiceStatus)
          ..add('templates', templates))
        .toString();
  }
}

class StaticDataEntityBuilder
    implements Builder<StaticDataEntity, StaticDataEntityBuilder> {
  _$StaticDataEntity _$v;

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

  ListBuilder<GatewayEntity> _gateways;
  ListBuilder<GatewayEntity> get gateways =>
      _$this._gateways ??= new ListBuilder<GatewayEntity>();
  set gateways(ListBuilder<GatewayEntity> gateways) =>
      _$this._gateways = gateways;

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

  MapBuilder<String, TemplateEntity> _templates;
  MapBuilder<String, TemplateEntity> get templates =>
      _$this._templates ??= new MapBuilder<String, TemplateEntity>();
  set templates(MapBuilder<String, TemplateEntity> templates) =>
      _$this._templates = templates;

  StaticDataEntityBuilder();

  StaticDataEntityBuilder get _$this {
    if (_$v != null) {
      _currencies = _$v.currencies?.toBuilder();
      _sizes = _$v.sizes?.toBuilder();
      _industries = _$v.industries?.toBuilder();
      _timezones = _$v.timezones?.toBuilder();
      _gateways = _$v.gateways?.toBuilder();
      _dateFormats = _$v.dateFormats?.toBuilder();
      _datetimeFormats = _$v.datetimeFormats?.toBuilder();
      _languages = _$v.languages?.toBuilder();
      _paymentTypes = _$v.paymentTypes?.toBuilder();
      _countries = _$v.countries?.toBuilder();
      _invoiceStatus = _$v.invoiceStatus?.toBuilder();
      _templates = _$v.templates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticDataEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StaticDataEntity;
  }

  @override
  void update(void Function(StaticDataEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticDataEntity build() {
    _$StaticDataEntity _$result;
    try {
      _$result = _$v ??
          new _$StaticDataEntity._(
              currencies: currencies.build(),
              sizes: sizes.build(),
              industries: industries.build(),
              timezones: timezones.build(),
              gateways: gateways.build(),
              dateFormats: dateFormats.build(),
              datetimeFormats: datetimeFormats.build(),
              languages: languages.build(),
              paymentTypes: paymentTypes.build(),
              countries: countries.build(),
              invoiceStatus: invoiceStatus.build(),
              templates: templates.build());
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
        _$failedField = 'gateways';
        gateways.build();
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
        _$failedField = 'templates';
        templates.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StaticDataEntity', _$failedField, e.toString());
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

  factory _$TemplateEntity([void Function(TemplateEntityBuilder) updates]) =>
      (new TemplateEntityBuilder()..update(updates)).build();

  _$TemplateEntity._({this.subject, this.body}) : super._() {
    if (subject == null) {
      throw new BuiltValueNullFieldError('TemplateEntity', 'subject');
    }
    if (body == null) {
      throw new BuiltValueNullFieldError('TemplateEntity', 'body');
    }
  }

  @override
  TemplateEntity rebuild(void Function(TemplateEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TemplateEntityBuilder toBuilder() =>
      new TemplateEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TemplateEntity &&
        subject == other.subject &&
        body == other.body;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, subject.hashCode), body.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TemplateEntity')
          ..add('subject', subject)
          ..add('body', body))
        .toString();
  }
}

class TemplateEntityBuilder
    implements Builder<TemplateEntity, TemplateEntityBuilder> {
  _$TemplateEntity _$v;

  String _subject;
  String get subject => _$this._subject;
  set subject(String subject) => _$this._subject = subject;

  String _body;
  String get body => _$this._body;
  set body(String body) => _$this._body = body;

  TemplateEntityBuilder();

  TemplateEntityBuilder get _$this {
    if (_$v != null) {
      _subject = _$v.subject;
      _body = _$v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TemplateEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TemplateEntity;
  }

  @override
  void update(void Function(TemplateEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TemplateEntity build() {
    final _$result =
        _$v ?? new _$TemplateEntity._(subject: subject, body: body);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
