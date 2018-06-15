// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_data_model.dart';

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

Serializer<StaticDataListResponse> _$staticDataListResponseSerializer =
    new _$StaticDataListResponseSerializer();
Serializer<StaticDataItemResponse> _$staticDataItemResponseSerializer =
    new _$StaticDataItemResponseSerializer();
Serializer<StaticDataEntity> _$staticDataEntitySerializer =
    new _$StaticDataEntitySerializer();

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
  Iterable serialize(Serializers serializers, StaticDataListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
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
      Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
              as BuiltList);
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
  Iterable serialize(Serializers serializers, StaticDataItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(StaticDataEntity)),
    ];

    return result;
  }

  @override
  StaticDataItemResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
  Iterable serialize(Serializers serializers, StaticDataEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.currencies != null) {
      result
        ..add('currencies')
        ..add(serializers.serialize(object.currencies,
            specifiedType: const FullType(
                BuiltList, const [const FullType(CurrencyEntity)])));
    }
    if (object.sizes != null) {
      result
        ..add('sizes')
        ..add(serializers.serialize(object.sizes,
            specifiedType:
                const FullType(BuiltList, const [const FullType(SizeEntity)])));
    }
    if (object.industries != null) {
      result
        ..add('industries')
        ..add(serializers.serialize(object.industries,
            specifiedType: const FullType(
                BuiltList, const [const FullType(IndustryEntity)])));
    }
    if (object.timezones != null) {
      result
        ..add('timezones')
        ..add(serializers.serialize(object.timezones,
            specifiedType: const FullType(
                BuiltList, const [const FullType(TimezoneEntity)])));
    }
    if (object.dateFormats != null) {
      result
        ..add('dateFormats')
        ..add(serializers.serialize(object.dateFormats,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DateFormatEntity)])));
    }
    if (object.datetimeFormats != null) {
      result
        ..add('datetimeFormats')
        ..add(serializers.serialize(object.datetimeFormats,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DatetimeFormatEntity)])));
    }
    if (object.languages != null) {
      result
        ..add('languages')
        ..add(serializers.serialize(object.languages,
            specifiedType: const FullType(
                BuiltList, const [const FullType(LanguageEntity)])));
    }
    if (object.paymentTypes != null) {
      result
        ..add('paymentTypes')
        ..add(serializers.serialize(object.paymentTypes,
            specifiedType: const FullType(
                BuiltList, const [const FullType(PaymentTypeEntity)])));
    }
    if (object.countries != null) {
      result
        ..add('countries')
        ..add(serializers.serialize(object.countries,
            specifiedType: const FullType(
                BuiltList, const [const FullType(CountryEntity)])));
    }
    if (object.invoiceDesigns != null) {
      result
        ..add('invoiceDesigns')
        ..add(serializers.serialize(object.invoiceDesigns,
            specifiedType: const FullType(
                BuiltList, const [const FullType(InvoiceDesignEntity)])));
    }
    if (object.invoiceStatus != null) {
      result
        ..add('invoiceStatus')
        ..add(serializers.serialize(object.invoiceStatus,
            specifiedType: const FullType(
                BuiltList, const [const FullType(InvoiceStatusEntity)])));
    }
    if (object.frequencies != null) {
      result
        ..add('frequencies')
        ..add(serializers.serialize(object.frequencies,
            specifiedType: const FullType(
                BuiltList, const [const FullType(FrequencyEntity)])));
    }

    return result;
  }

  @override
  StaticDataEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
        case 'invoiceDesigns':
          result.invoiceDesigns.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceDesignEntity)]))
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

class _$StaticDataListResponse extends StaticDataListResponse {
  @override
  final BuiltList<StaticDataEntity> data;

  factory _$StaticDataListResponse(
          [void updates(StaticDataListResponseBuilder b)]) =>
      (new StaticDataListResponseBuilder()..update(updates)).build();

  _$StaticDataListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('StaticDataListResponse', 'data');
  }

  @override
  StaticDataListResponse rebuild(
          void updates(StaticDataListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataListResponseBuilder toBuilder() =>
      new StaticDataListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! StaticDataListResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$StaticDataListResponse;
  }

  @override
  void update(void updates(StaticDataListResponseBuilder b)) {
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
          [void updates(StaticDataItemResponseBuilder b)]) =>
      (new StaticDataItemResponseBuilder()..update(updates)).build();

  _$StaticDataItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('StaticDataItemResponse', 'data');
  }

  @override
  StaticDataItemResponse rebuild(
          void updates(StaticDataItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataItemResponseBuilder toBuilder() =>
      new StaticDataItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! StaticDataItemResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$StaticDataItemResponse;
  }

  @override
  void update(void updates(StaticDataItemResponseBuilder b)) {
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
  final BuiltList<InvoiceDesignEntity> invoiceDesigns;
  @override
  final BuiltList<InvoiceStatusEntity> invoiceStatus;
  @override
  final BuiltList<FrequencyEntity> frequencies;

  factory _$StaticDataEntity([void updates(StaticDataEntityBuilder b)]) =>
      (new StaticDataEntityBuilder()..update(updates)).build();

  _$StaticDataEntity._(
      {this.currencies,
      this.sizes,
      this.industries,
      this.timezones,
      this.dateFormats,
      this.datetimeFormats,
      this.languages,
      this.paymentTypes,
      this.countries,
      this.invoiceDesigns,
      this.invoiceStatus,
      this.frequencies})
      : super._();

  @override
  StaticDataEntity rebuild(void updates(StaticDataEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticDataEntityBuilder toBuilder() =>
      new StaticDataEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! StaticDataEntity) return false;
    return currencies == other.currencies &&
        sizes == other.sizes &&
        industries == other.industries &&
        timezones == other.timezones &&
        dateFormats == other.dateFormats &&
        datetimeFormats == other.datetimeFormats &&
        languages == other.languages &&
        paymentTypes == other.paymentTypes &&
        countries == other.countries &&
        invoiceDesigns == other.invoiceDesigns &&
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
                invoiceDesigns.hashCode),
            invoiceStatus.hashCode),
        frequencies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticDataEntity')
          ..add('currencies', currencies)
          ..add('sizes', sizes)
          ..add('industries', industries)
          ..add('timezones', timezones)
          ..add('dateFormats', dateFormats)
          ..add('datetimeFormats', datetimeFormats)
          ..add('languages', languages)
          ..add('paymentTypes', paymentTypes)
          ..add('countries', countries)
          ..add('invoiceDesigns', invoiceDesigns)
          ..add('invoiceStatus', invoiceStatus)
          ..add('frequencies', frequencies))
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

  ListBuilder<InvoiceDesignEntity> _invoiceDesigns;
  ListBuilder<InvoiceDesignEntity> get invoiceDesigns =>
      _$this._invoiceDesigns ??= new ListBuilder<InvoiceDesignEntity>();
  set invoiceDesigns(ListBuilder<InvoiceDesignEntity> invoiceDesigns) =>
      _$this._invoiceDesigns = invoiceDesigns;

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

  StaticDataEntityBuilder();

  StaticDataEntityBuilder get _$this {
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
      _invoiceDesigns = _$v.invoiceDesigns?.toBuilder();
      _invoiceStatus = _$v.invoiceStatus?.toBuilder();
      _frequencies = _$v.frequencies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticDataEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$StaticDataEntity;
  }

  @override
  void update(void updates(StaticDataEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticDataEntity build() {
    _$StaticDataEntity _$result;
    try {
      _$result = _$v ??
          new _$StaticDataEntity._(
              currencies: _currencies?.build(),
              sizes: _sizes?.build(),
              industries: _industries?.build(),
              timezones: _timezones?.build(),
              dateFormats: _dateFormats?.build(),
              datetimeFormats: _datetimeFormats?.build(),
              languages: _languages?.build(),
              paymentTypes: _paymentTypes?.build(),
              countries: _countries?.build(),
              invoiceDesigns: _invoiceDesigns?.build(),
              invoiceStatus: _invoiceStatus?.build(),
              frequencies: _frequencies?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currencies';
        _currencies?.build();
        _$failedField = 'sizes';
        _sizes?.build();
        _$failedField = 'industries';
        _industries?.build();
        _$failedField = 'timezones';
        _timezones?.build();
        _$failedField = 'dateFormats';
        _dateFormats?.build();
        _$failedField = 'datetimeFormats';
        _datetimeFormats?.build();
        _$failedField = 'languages';
        _languages?.build();
        _$failedField = 'paymentTypes';
        _paymentTypes?.build();
        _$failedField = 'countries';
        _countries?.build();
        _$failedField = 'invoiceDesigns';
        _invoiceDesigns?.build();
        _$failedField = 'invoiceStatus';
        _invoiceStatus?.build();
        _$failedField = 'frequencies';
        _frequencies?.build();
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
