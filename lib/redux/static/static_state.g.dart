// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<StaticState> _$staticStateSerializer = new _$StaticStateSerializer();

class _$StaticStateSerializer implements StructuredSerializer<StaticState> {
  @override
  final Iterable<Type> types = const [StaticState, _$StaticState];
  @override
  final String wireName = 'StaticState';

  @override
  Iterable<Object> serialize(Serializers serializers, StaticState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'currencyMap',
      serializers.serialize(object.currencyMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(CurrencyEntity)])),
      'sizeMap',
      serializers.serialize(object.sizeMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(SizeEntity)])),
      'gatewayMap',
      serializers.serialize(object.gatewayMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(GatewayEntity)])),
      'industryMap',
      serializers.serialize(object.industryMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(IndustryEntity)])),
      'timezoneMap',
      serializers.serialize(object.timezoneMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(TimezoneEntity)])),
      'dateFormatMap',
      serializers.serialize(object.dateFormatMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(DateFormatEntity)
          ])),
      'datetimeFormatMap',
      serializers.serialize(object.datetimeFormatMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(DatetimeFormatEntity)
          ])),
      'languageMap',
      serializers.serialize(object.languageMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(LanguageEntity)])),
      'paymentTypeMap',
      serializers.serialize(object.paymentTypeMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(PaymentTypeEntity)
          ])),
      'countryMap',
      serializers.serialize(object.countryMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(CountryEntity)])),
      'invoiceStatusMap',
      serializers.serialize(object.invoiceStatusMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(InvoiceStatusEntity)
          ])),
      'frequencyMap',
      serializers.serialize(object.frequencyMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(FrequencyEntity)])),
    ];
    if (object.updatedAt != null) {
      result
        ..add('updatedAt')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  StaticState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StaticStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'currencyMap':
          result.currencyMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(CurrencyEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'sizeMap':
          result.sizeMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(SizeEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'gatewayMap':
          result.gatewayMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(GatewayEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'industryMap':
          result.industryMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(IndustryEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'timezoneMap':
          result.timezoneMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TimezoneEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'dateFormatMap':
          result.dateFormatMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(DateFormatEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'datetimeFormatMap':
          result.datetimeFormatMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(DatetimeFormatEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'languageMap':
          result.languageMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(LanguageEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'paymentTypeMap':
          result.paymentTypeMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(PaymentTypeEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'countryMap':
          result.countryMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(CountryEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'invoiceStatusMap':
          result.invoiceStatusMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(InvoiceStatusEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
        case 'frequencyMap':
          result.frequencyMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(FrequencyEntity)
              ])) as BuiltMap<dynamic, dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$StaticState extends StaticState {
  @override
  final int updatedAt;
  @override
  final BuiltMap<String, CurrencyEntity> currencyMap;
  @override
  final BuiltMap<String, SizeEntity> sizeMap;
  @override
  final BuiltMap<String, GatewayEntity> gatewayMap;
  @override
  final BuiltMap<String, IndustryEntity> industryMap;
  @override
  final BuiltMap<String, TimezoneEntity> timezoneMap;
  @override
  final BuiltMap<String, DateFormatEntity> dateFormatMap;
  @override
  final BuiltMap<String, DatetimeFormatEntity> datetimeFormatMap;
  @override
  final BuiltMap<String, LanguageEntity> languageMap;
  @override
  final BuiltMap<String, PaymentTypeEntity> paymentTypeMap;
  @override
  final BuiltMap<String, CountryEntity> countryMap;
  @override
  final BuiltMap<String, InvoiceStatusEntity> invoiceStatusMap;
  @override
  final BuiltMap<String, FrequencyEntity> frequencyMap;

  factory _$StaticState([void Function(StaticStateBuilder) updates]) =>
      (new StaticStateBuilder()..update(updates)).build();

  _$StaticState._(
      {this.updatedAt,
      this.currencyMap,
      this.sizeMap,
      this.gatewayMap,
      this.industryMap,
      this.timezoneMap,
      this.dateFormatMap,
      this.datetimeFormatMap,
      this.languageMap,
      this.paymentTypeMap,
      this.countryMap,
      this.invoiceStatusMap,
      this.frequencyMap})
      : super._() {
    if (currencyMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'currencyMap');
    }
    if (sizeMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'sizeMap');
    }
    if (gatewayMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'gatewayMap');
    }
    if (industryMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'industryMap');
    }
    if (timezoneMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'timezoneMap');
    }
    if (dateFormatMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'dateFormatMap');
    }
    if (datetimeFormatMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'datetimeFormatMap');
    }
    if (languageMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'languageMap');
    }
    if (paymentTypeMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'paymentTypeMap');
    }
    if (countryMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'countryMap');
    }
    if (invoiceStatusMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'invoiceStatusMap');
    }
    if (frequencyMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'frequencyMap');
    }
  }

  @override
  StaticState rebuild(void Function(StaticStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticStateBuilder toBuilder() => new StaticStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticState &&
        updatedAt == other.updatedAt &&
        currencyMap == other.currencyMap &&
        sizeMap == other.sizeMap &&
        gatewayMap == other.gatewayMap &&
        industryMap == other.industryMap &&
        timezoneMap == other.timezoneMap &&
        dateFormatMap == other.dateFormatMap &&
        datetimeFormatMap == other.datetimeFormatMap &&
        languageMap == other.languageMap &&
        paymentTypeMap == other.paymentTypeMap &&
        countryMap == other.countryMap &&
        invoiceStatusMap == other.invoiceStatusMap &&
        frequencyMap == other.frequencyMap;
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
                                                $jc($jc(0, updatedAt.hashCode),
                                                    currencyMap.hashCode),
                                                sizeMap.hashCode),
                                            gatewayMap.hashCode),
                                        industryMap.hashCode),
                                    timezoneMap.hashCode),
                                dateFormatMap.hashCode),
                            datetimeFormatMap.hashCode),
                        languageMap.hashCode),
                    paymentTypeMap.hashCode),
                countryMap.hashCode),
            invoiceStatusMap.hashCode),
        frequencyMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticState')
          ..add('updatedAt', updatedAt)
          ..add('currencyMap', currencyMap)
          ..add('sizeMap', sizeMap)
          ..add('gatewayMap', gatewayMap)
          ..add('industryMap', industryMap)
          ..add('timezoneMap', timezoneMap)
          ..add('dateFormatMap', dateFormatMap)
          ..add('datetimeFormatMap', datetimeFormatMap)
          ..add('languageMap', languageMap)
          ..add('paymentTypeMap', paymentTypeMap)
          ..add('countryMap', countryMap)
          ..add('invoiceStatusMap', invoiceStatusMap)
          ..add('frequencyMap', frequencyMap))
        .toString();
  }
}

class StaticStateBuilder implements Builder<StaticState, StaticStateBuilder> {
  _$StaticState _$v;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  MapBuilder<String, CurrencyEntity> _currencyMap;
  MapBuilder<String, CurrencyEntity> get currencyMap =>
      _$this._currencyMap ??= new MapBuilder<String, CurrencyEntity>();
  set currencyMap(MapBuilder<String, CurrencyEntity> currencyMap) =>
      _$this._currencyMap = currencyMap;

  MapBuilder<String, SizeEntity> _sizeMap;
  MapBuilder<String, SizeEntity> get sizeMap =>
      _$this._sizeMap ??= new MapBuilder<String, SizeEntity>();
  set sizeMap(MapBuilder<String, SizeEntity> sizeMap) =>
      _$this._sizeMap = sizeMap;

  MapBuilder<String, GatewayEntity> _gatewayMap;
  MapBuilder<String, GatewayEntity> get gatewayMap =>
      _$this._gatewayMap ??= new MapBuilder<String, GatewayEntity>();
  set gatewayMap(MapBuilder<String, GatewayEntity> gatewayMap) =>
      _$this._gatewayMap = gatewayMap;

  MapBuilder<String, IndustryEntity> _industryMap;
  MapBuilder<String, IndustryEntity> get industryMap =>
      _$this._industryMap ??= new MapBuilder<String, IndustryEntity>();
  set industryMap(MapBuilder<String, IndustryEntity> industryMap) =>
      _$this._industryMap = industryMap;

  MapBuilder<String, TimezoneEntity> _timezoneMap;
  MapBuilder<String, TimezoneEntity> get timezoneMap =>
      _$this._timezoneMap ??= new MapBuilder<String, TimezoneEntity>();
  set timezoneMap(MapBuilder<String, TimezoneEntity> timezoneMap) =>
      _$this._timezoneMap = timezoneMap;

  MapBuilder<String, DateFormatEntity> _dateFormatMap;
  MapBuilder<String, DateFormatEntity> get dateFormatMap =>
      _$this._dateFormatMap ??= new MapBuilder<String, DateFormatEntity>();
  set dateFormatMap(MapBuilder<String, DateFormatEntity> dateFormatMap) =>
      _$this._dateFormatMap = dateFormatMap;

  MapBuilder<String, DatetimeFormatEntity> _datetimeFormatMap;
  MapBuilder<String, DatetimeFormatEntity> get datetimeFormatMap =>
      _$this._datetimeFormatMap ??=
          new MapBuilder<String, DatetimeFormatEntity>();
  set datetimeFormatMap(
          MapBuilder<String, DatetimeFormatEntity> datetimeFormatMap) =>
      _$this._datetimeFormatMap = datetimeFormatMap;

  MapBuilder<String, LanguageEntity> _languageMap;
  MapBuilder<String, LanguageEntity> get languageMap =>
      _$this._languageMap ??= new MapBuilder<String, LanguageEntity>();
  set languageMap(MapBuilder<String, LanguageEntity> languageMap) =>
      _$this._languageMap = languageMap;

  MapBuilder<String, PaymentTypeEntity> _paymentTypeMap;
  MapBuilder<String, PaymentTypeEntity> get paymentTypeMap =>
      _$this._paymentTypeMap ??= new MapBuilder<String, PaymentTypeEntity>();
  set paymentTypeMap(MapBuilder<String, PaymentTypeEntity> paymentTypeMap) =>
      _$this._paymentTypeMap = paymentTypeMap;

  MapBuilder<String, CountryEntity> _countryMap;
  MapBuilder<String, CountryEntity> get countryMap =>
      _$this._countryMap ??= new MapBuilder<String, CountryEntity>();
  set countryMap(MapBuilder<String, CountryEntity> countryMap) =>
      _$this._countryMap = countryMap;

  MapBuilder<String, InvoiceStatusEntity> _invoiceStatusMap;
  MapBuilder<String, InvoiceStatusEntity> get invoiceStatusMap =>
      _$this._invoiceStatusMap ??=
          new MapBuilder<String, InvoiceStatusEntity>();
  set invoiceStatusMap(
          MapBuilder<String, InvoiceStatusEntity> invoiceStatusMap) =>
      _$this._invoiceStatusMap = invoiceStatusMap;

  MapBuilder<String, FrequencyEntity> _frequencyMap;
  MapBuilder<String, FrequencyEntity> get frequencyMap =>
      _$this._frequencyMap ??= new MapBuilder<String, FrequencyEntity>();
  set frequencyMap(MapBuilder<String, FrequencyEntity> frequencyMap) =>
      _$this._frequencyMap = frequencyMap;

  StaticStateBuilder();

  StaticStateBuilder get _$this {
    if (_$v != null) {
      _updatedAt = _$v.updatedAt;
      _currencyMap = _$v.currencyMap?.toBuilder();
      _sizeMap = _$v.sizeMap?.toBuilder();
      _gatewayMap = _$v.gatewayMap?.toBuilder();
      _industryMap = _$v.industryMap?.toBuilder();
      _timezoneMap = _$v.timezoneMap?.toBuilder();
      _dateFormatMap = _$v.dateFormatMap?.toBuilder();
      _datetimeFormatMap = _$v.datetimeFormatMap?.toBuilder();
      _languageMap = _$v.languageMap?.toBuilder();
      _paymentTypeMap = _$v.paymentTypeMap?.toBuilder();
      _countryMap = _$v.countryMap?.toBuilder();
      _invoiceStatusMap = _$v.invoiceStatusMap?.toBuilder();
      _frequencyMap = _$v.frequencyMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StaticState;
  }

  @override
  void update(void Function(StaticStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticState build() {
    _$StaticState _$result;
    try {
      _$result = _$v ??
          new _$StaticState._(
              updatedAt: updatedAt,
              currencyMap: currencyMap.build(),
              sizeMap: sizeMap.build(),
              gatewayMap: gatewayMap.build(),
              industryMap: industryMap.build(),
              timezoneMap: timezoneMap.build(),
              dateFormatMap: dateFormatMap.build(),
              datetimeFormatMap: datetimeFormatMap.build(),
              languageMap: languageMap.build(),
              paymentTypeMap: paymentTypeMap.build(),
              countryMap: countryMap.build(),
              invoiceStatusMap: invoiceStatusMap.build(),
              frequencyMap: frequencyMap.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currencyMap';
        currencyMap.build();
        _$failedField = 'sizeMap';
        sizeMap.build();
        _$failedField = 'gatewayMap';
        gatewayMap.build();
        _$failedField = 'industryMap';
        industryMap.build();
        _$failedField = 'timezoneMap';
        timezoneMap.build();
        _$failedField = 'dateFormatMap';
        dateFormatMap.build();
        _$failedField = 'datetimeFormatMap';
        datetimeFormatMap.build();
        _$failedField = 'languageMap';
        languageMap.build();
        _$failedField = 'paymentTypeMap';
        paymentTypeMap.build();
        _$failedField = 'countryMap';
        countryMap.build();
        _$failedField = 'invoiceStatusMap';
        invoiceStatusMap.build();
        _$failedField = 'frequencyMap';
        frequencyMap.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StaticState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
