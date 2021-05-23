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
      'templateMap',
      serializers.serialize(object.templateMap,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(TemplateEntity)])),
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
              ])));
          break;
        case 'sizeMap':
          result.sizeMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(SizeEntity)])));
          break;
        case 'gatewayMap':
          result.gatewayMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(GatewayEntity)
              ])));
          break;
        case 'industryMap':
          result.industryMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(IndustryEntity)
              ])));
          break;
        case 'timezoneMap':
          result.timezoneMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TimezoneEntity)
              ])));
          break;
        case 'dateFormatMap':
          result.dateFormatMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(DateFormatEntity)
              ])));
          break;
        case 'languageMap':
          result.languageMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(LanguageEntity)
              ])));
          break;
        case 'paymentTypeMap':
          result.paymentTypeMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(PaymentTypeEntity)
              ])));
          break;
        case 'countryMap':
          result.countryMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(CountryEntity)
              ])));
          break;
        case 'templateMap':
          result.templateMap.replace(serializers.deserialize(value,
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
  final BuiltMap<String, LanguageEntity> languageMap;
  @override
  final BuiltMap<String, PaymentTypeEntity> paymentTypeMap;
  @override
  final BuiltMap<String, CountryEntity> countryMap;
  @override
  final BuiltMap<String, TemplateEntity> templateMap;

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
      this.languageMap,
      this.paymentTypeMap,
      this.countryMap,
      this.templateMap})
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
    if (languageMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'languageMap');
    }
    if (paymentTypeMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'paymentTypeMap');
    }
    if (countryMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'countryMap');
    }
    if (templateMap == null) {
      throw new BuiltValueNullFieldError('StaticState', 'templateMap');
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
        languageMap == other.languageMap &&
        paymentTypeMap == other.paymentTypeMap &&
        countryMap == other.countryMap &&
        templateMap == other.templateMap;
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
                                        $jc($jc(0, updatedAt.hashCode),
                                            currencyMap.hashCode),
                                        sizeMap.hashCode),
                                    gatewayMap.hashCode),
                                industryMap.hashCode),
                            timezoneMap.hashCode),
                        dateFormatMap.hashCode),
                    languageMap.hashCode),
                paymentTypeMap.hashCode),
            countryMap.hashCode),
        templateMap.hashCode));
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
          ..add('languageMap', languageMap)
          ..add('paymentTypeMap', paymentTypeMap)
          ..add('countryMap', countryMap)
          ..add('templateMap', templateMap))
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

  MapBuilder<String, TemplateEntity> _templateMap;
  MapBuilder<String, TemplateEntity> get templateMap =>
      _$this._templateMap ??= new MapBuilder<String, TemplateEntity>();
  set templateMap(MapBuilder<String, TemplateEntity> templateMap) =>
      _$this._templateMap = templateMap;

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
      _languageMap = _$v.languageMap?.toBuilder();
      _paymentTypeMap = _$v.paymentTypeMap?.toBuilder();
      _countryMap = _$v.countryMap?.toBuilder();
      _templateMap = _$v.templateMap?.toBuilder();
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
              languageMap: languageMap.build(),
              paymentTypeMap: paymentTypeMap.build(),
              countryMap: countryMap.build(),
              templateMap: templateMap.build());
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
        _$failedField = 'languageMap';
        languageMap.build();
        _$failedField = 'paymentTypeMap';
        paymentTypeMap.build();
        _$failedField = 'countryMap';
        countryMap.build();
        _$failedField = 'templateMap';
        templateMap.build();
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
