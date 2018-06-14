// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

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

Serializer<CountryListResponse> _$countryListResponseSerializer =
    new _$CountryListResponseSerializer();
Serializer<CountryItemResponse> _$countryItemResponseSerializer =
    new _$CountryItemResponseSerializer();
Serializer<CountryEntity> _$countryEntitySerializer =
    new _$CountryEntitySerializer();

class _$CountryListResponseSerializer
    implements StructuredSerializer<CountryListResponse> {
  @override
  final Iterable<Type> types = const [
    CountryListResponse,
    _$CountryListResponse
  ];
  @override
  final String wireName = 'CountryListResponse';

  @override
  Iterable serialize(Serializers serializers, CountryListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CountryEntity)])),
    ];

    return result;
  }

  @override
  CountryListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CountryListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CountryEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$CountryItemResponseSerializer
    implements StructuredSerializer<CountryItemResponse> {
  @override
  final Iterable<Type> types = const [
    CountryItemResponse,
    _$CountryItemResponse
  ];
  @override
  final String wireName = 'CountryItemResponse';

  @override
  Iterable serialize(Serializers serializers, CountryItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(CountryEntity)),
    ];

    return result;
  }

  @override
  CountryItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CountryItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(CountryEntity)) as CountryEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$CountryEntitySerializer implements StructuredSerializer<CountryEntity> {
  @override
  final Iterable<Type> types = const [CountryEntity, _$CountryEntity];
  @override
  final String wireName = 'CountryEntity';

  @override
  Iterable serialize(Serializers serializers, CountryEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.capital != null) {
      result
        ..add('capital')
        ..add(serializers.serialize(object.capital,
            specifiedType: const FullType(String)));
    }
    if (object.citizenship != null) {
      result
        ..add('citizenship')
        ..add(serializers.serialize(object.citizenship,
            specifiedType: const FullType(String)));
    }
    if (object.countryCode != null) {
      result
        ..add('country_code')
        ..add(serializers.serialize(object.countryCode,
            specifiedType: const FullType(String)));
    }
    if (object.currency != null) {
      result
        ..add('currency')
        ..add(serializers.serialize(object.currency,
            specifiedType: const FullType(String)));
    }
    if (object.currencyCode != null) {
      result
        ..add('currency_code')
        ..add(serializers.serialize(object.currencyCode,
            specifiedType: const FullType(String)));
    }
    if (object.currencySubUnit != null) {
      result
        ..add('currency_sub_unit')
        ..add(serializers.serialize(object.currencySubUnit,
            specifiedType: const FullType(String)));
    }
    if (object.fullName != null) {
      result
        ..add('full_name')
        ..add(serializers.serialize(object.fullName,
            specifiedType: const FullType(String)));
    }
    if (object.iso_3166_2 != null) {
      result
        ..add('iso_3166_2')
        ..add(serializers.serialize(object.iso_3166_2,
            specifiedType: const FullType(String)));
    }
    if (object.iso_3166_3 != null) {
      result
        ..add('iso_3166_3')
        ..add(serializers.serialize(object.iso_3166_3,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.regionCode != null) {
      result
        ..add('region_code')
        ..add(serializers.serialize(object.regionCode,
            specifiedType: const FullType(String)));
    }
    if (object.subRegionCode != null) {
      result
        ..add('sub_region_code')
        ..add(serializers.serialize(object.subRegionCode,
            specifiedType: const FullType(String)));
    }
    if (object.eea != null) {
      result
        ..add('eea')
        ..add(serializers.serialize(object.eea,
            specifiedType: const FullType(bool)));
    }
    if (object.swapPostalCode != null) {
      result
        ..add('swap_postal_code')
        ..add(serializers.serialize(object.swapPostalCode,
            specifiedType: const FullType(bool)));
    }
    if (object.swapCurrencySymbol != null) {
      result
        ..add('swap_currency_symbol')
        ..add(serializers.serialize(object.swapCurrencySymbol,
            specifiedType: const FullType(bool)));
    }
    if (object.thousandSeparator != null) {
      result
        ..add('thousand_separator')
        ..add(serializers.serialize(object.thousandSeparator,
            specifiedType: const FullType(String)));
    }
    if (object.decimalSeparator != null) {
      result
        ..add('decimal_separator')
        ..add(serializers.serialize(object.decimalSeparator,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  CountryEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CountryEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'capital':
          result.capital = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'citizenship':
          result.citizenship = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country_code':
          result.countryCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency_code':
          result.currencyCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency_sub_unit':
          result.currencySubUnit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'full_name':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'iso_3166_2':
          result.iso_3166_2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'iso_3166_3':
          result.iso_3166_3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'region_code':
          result.regionCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sub_region_code':
          result.subRegionCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eea':
          result.eea = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'swap_postal_code':
          result.swapPostalCode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'swap_currency_symbol':
          result.swapCurrencySymbol = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'thousand_separator':
          result.thousandSeparator = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'decimal_separator':
          result.decimalSeparator = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CountryListResponse extends CountryListResponse {
  @override
  final BuiltList<CountryEntity> data;

  factory _$CountryListResponse([void updates(CountryListResponseBuilder b)]) =>
      (new CountryListResponseBuilder()..update(updates)).build();

  _$CountryListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('CountryListResponse', 'data');
  }

  @override
  CountryListResponse rebuild(void updates(CountryListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryListResponseBuilder toBuilder() =>
      new CountryListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! CountryListResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CountryListResponse')
          ..add('data', data))
        .toString();
  }
}

class CountryListResponseBuilder
    implements Builder<CountryListResponse, CountryListResponseBuilder> {
  _$CountryListResponse _$v;

  ListBuilder<CountryEntity> _data;
  ListBuilder<CountryEntity> get data =>
      _$this._data ??= new ListBuilder<CountryEntity>();
  set data(ListBuilder<CountryEntity> data) => _$this._data = data;

  CountryListResponseBuilder();

  CountryListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryListResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$CountryListResponse;
  }

  @override
  void update(void updates(CountryListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CountryListResponse build() {
    _$CountryListResponse _$result;
    try {
      _$result = _$v ?? new _$CountryListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CountryListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CountryItemResponse extends CountryItemResponse {
  @override
  final CountryEntity data;

  factory _$CountryItemResponse([void updates(CountryItemResponseBuilder b)]) =>
      (new CountryItemResponseBuilder()..update(updates)).build();

  _$CountryItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('CountryItemResponse', 'data');
  }

  @override
  CountryItemResponse rebuild(void updates(CountryItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryItemResponseBuilder toBuilder() =>
      new CountryItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! CountryItemResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CountryItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CountryItemResponseBuilder
    implements Builder<CountryItemResponse, CountryItemResponseBuilder> {
  _$CountryItemResponse _$v;

  CountryEntityBuilder _data;
  CountryEntityBuilder get data => _$this._data ??= new CountryEntityBuilder();
  set data(CountryEntityBuilder data) => _$this._data = data;

  CountryItemResponseBuilder();

  CountryItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryItemResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$CountryItemResponse;
  }

  @override
  void update(void updates(CountryItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CountryItemResponse build() {
    _$CountryItemResponse _$result;
    try {
      _$result = _$v ?? new _$CountryItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CountryItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CountryEntity extends CountryEntity {
  @override
  final String capital;
  @override
  final String citizenship;
  @override
  final String countryCode;
  @override
  final String currency;
  @override
  final String currencyCode;
  @override
  final String currencySubUnit;
  @override
  final String fullName;
  @override
  final String iso_3166_2;
  @override
  final String iso_3166_3;
  @override
  final String name;
  @override
  final String regionCode;
  @override
  final String subRegionCode;
  @override
  final bool eea;
  @override
  final bool swapPostalCode;
  @override
  final bool swapCurrencySymbol;
  @override
  final String thousandSeparator;
  @override
  final String decimalSeparator;

  factory _$CountryEntity([void updates(CountryEntityBuilder b)]) =>
      (new CountryEntityBuilder()..update(updates)).build();

  _$CountryEntity._(
      {this.capital,
      this.citizenship,
      this.countryCode,
      this.currency,
      this.currencyCode,
      this.currencySubUnit,
      this.fullName,
      this.iso_3166_2,
      this.iso_3166_3,
      this.name,
      this.regionCode,
      this.subRegionCode,
      this.eea,
      this.swapPostalCode,
      this.swapCurrencySymbol,
      this.thousandSeparator,
      this.decimalSeparator})
      : super._();

  @override
  CountryEntity rebuild(void updates(CountryEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryEntityBuilder toBuilder() => new CountryEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! CountryEntity) return false;
    return capital == other.capital &&
        citizenship == other.citizenship &&
        countryCode == other.countryCode &&
        currency == other.currency &&
        currencyCode == other.currencyCode &&
        currencySubUnit == other.currencySubUnit &&
        fullName == other.fullName &&
        iso_3166_2 == other.iso_3166_2 &&
        iso_3166_3 == other.iso_3166_3 &&
        name == other.name &&
        regionCode == other.regionCode &&
        subRegionCode == other.subRegionCode &&
        eea == other.eea &&
        swapPostalCode == other.swapPostalCode &&
        swapCurrencySymbol == other.swapCurrencySymbol &&
        thousandSeparator == other.thousandSeparator &&
        decimalSeparator == other.decimalSeparator;
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
                                                                        0,
                                                                        capital
                                                                            .hashCode),
                                                                    citizenship
                                                                        .hashCode),
                                                                countryCode
                                                                    .hashCode),
                                                            currency.hashCode),
                                                        currencyCode.hashCode),
                                                    currencySubUnit.hashCode),
                                                fullName.hashCode),
                                            iso_3166_2.hashCode),
                                        iso_3166_3.hashCode),
                                    name.hashCode),
                                regionCode.hashCode),
                            subRegionCode.hashCode),
                        eea.hashCode),
                    swapPostalCode.hashCode),
                swapCurrencySymbol.hashCode),
            thousandSeparator.hashCode),
        decimalSeparator.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CountryEntity')
          ..add('capital', capital)
          ..add('citizenship', citizenship)
          ..add('countryCode', countryCode)
          ..add('currency', currency)
          ..add('currencyCode', currencyCode)
          ..add('currencySubUnit', currencySubUnit)
          ..add('fullName', fullName)
          ..add('iso_3166_2', iso_3166_2)
          ..add('iso_3166_3', iso_3166_3)
          ..add('name', name)
          ..add('regionCode', regionCode)
          ..add('subRegionCode', subRegionCode)
          ..add('eea', eea)
          ..add('swapPostalCode', swapPostalCode)
          ..add('swapCurrencySymbol', swapCurrencySymbol)
          ..add('thousandSeparator', thousandSeparator)
          ..add('decimalSeparator', decimalSeparator))
        .toString();
  }
}

class CountryEntityBuilder
    implements Builder<CountryEntity, CountryEntityBuilder> {
  _$CountryEntity _$v;

  String _capital;
  String get capital => _$this._capital;
  set capital(String capital) => _$this._capital = capital;

  String _citizenship;
  String get citizenship => _$this._citizenship;
  set citizenship(String citizenship) => _$this._citizenship = citizenship;

  String _countryCode;
  String get countryCode => _$this._countryCode;
  set countryCode(String countryCode) => _$this._countryCode = countryCode;

  String _currency;
  String get currency => _$this._currency;
  set currency(String currency) => _$this._currency = currency;

  String _currencyCode;
  String get currencyCode => _$this._currencyCode;
  set currencyCode(String currencyCode) => _$this._currencyCode = currencyCode;

  String _currencySubUnit;
  String get currencySubUnit => _$this._currencySubUnit;
  set currencySubUnit(String currencySubUnit) =>
      _$this._currencySubUnit = currencySubUnit;

  String _fullName;
  String get fullName => _$this._fullName;
  set fullName(String fullName) => _$this._fullName = fullName;

  String _iso_3166_2;
  String get iso_3166_2 => _$this._iso_3166_2;
  set iso_3166_2(String iso_3166_2) => _$this._iso_3166_2 = iso_3166_2;

  String _iso_3166_3;
  String get iso_3166_3 => _$this._iso_3166_3;
  set iso_3166_3(String iso_3166_3) => _$this._iso_3166_3 = iso_3166_3;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _regionCode;
  String get regionCode => _$this._regionCode;
  set regionCode(String regionCode) => _$this._regionCode = regionCode;

  String _subRegionCode;
  String get subRegionCode => _$this._subRegionCode;
  set subRegionCode(String subRegionCode) =>
      _$this._subRegionCode = subRegionCode;

  bool _eea;
  bool get eea => _$this._eea;
  set eea(bool eea) => _$this._eea = eea;

  bool _swapPostalCode;
  bool get swapPostalCode => _$this._swapPostalCode;
  set swapPostalCode(bool swapPostalCode) =>
      _$this._swapPostalCode = swapPostalCode;

  bool _swapCurrencySymbol;
  bool get swapCurrencySymbol => _$this._swapCurrencySymbol;
  set swapCurrencySymbol(bool swapCurrencySymbol) =>
      _$this._swapCurrencySymbol = swapCurrencySymbol;

  String _thousandSeparator;
  String get thousandSeparator => _$this._thousandSeparator;
  set thousandSeparator(String thousandSeparator) =>
      _$this._thousandSeparator = thousandSeparator;

  String _decimalSeparator;
  String get decimalSeparator => _$this._decimalSeparator;
  set decimalSeparator(String decimalSeparator) =>
      _$this._decimalSeparator = decimalSeparator;

  CountryEntityBuilder();

  CountryEntityBuilder get _$this {
    if (_$v != null) {
      _capital = _$v.capital;
      _citizenship = _$v.citizenship;
      _countryCode = _$v.countryCode;
      _currency = _$v.currency;
      _currencyCode = _$v.currencyCode;
      _currencySubUnit = _$v.currencySubUnit;
      _fullName = _$v.fullName;
      _iso_3166_2 = _$v.iso_3166_2;
      _iso_3166_3 = _$v.iso_3166_3;
      _name = _$v.name;
      _regionCode = _$v.regionCode;
      _subRegionCode = _$v.subRegionCode;
      _eea = _$v.eea;
      _swapPostalCode = _$v.swapPostalCode;
      _swapCurrencySymbol = _$v.swapCurrencySymbol;
      _thousandSeparator = _$v.thousandSeparator;
      _decimalSeparator = _$v.decimalSeparator;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$CountryEntity;
  }

  @override
  void update(void updates(CountryEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CountryEntity build() {
    final _$result = _$v ??
        new _$CountryEntity._(
            capital: capital,
            citizenship: citizenship,
            countryCode: countryCode,
            currency: currency,
            currencyCode: currencyCode,
            currencySubUnit: currencySubUnit,
            fullName: fullName,
            iso_3166_2: iso_3166_2,
            iso_3166_3: iso_3166_3,
            name: name,
            regionCode: regionCode,
            subRegionCode: subRegionCode,
            eea: eea,
            swapPostalCode: swapPostalCode,
            swapCurrencySymbol: swapCurrencySymbol,
            thousandSeparator: thousandSeparator,
            decimalSeparator: decimalSeparator);
    replace(_$result);
    return _$result;
  }
}
