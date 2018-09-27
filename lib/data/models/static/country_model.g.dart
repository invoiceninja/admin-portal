// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

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
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(CountryEntity)),
    ];

    return result;
  }

  @override
  CountryItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'swap_postal_code',
      serializers.serialize(object.swapPostalCode,
          specifiedType: const FullType(bool)),
      'swap_currency_symbol',
      serializers.serialize(object.swapCurrencySymbol,
          specifiedType: const FullType(bool)),
      'iso_3166_2',
      serializers.serialize(object.iso2, specifiedType: const FullType(String)),
      'iso_3166_3',
      serializers.serialize(object.iso3, specifiedType: const FullType(String)),
    ];
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
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  CountryEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CountryEntityBuilder();

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
        case 'iso_3166_2':
          result.iso2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'iso_3166_3':
          result.iso3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$CountryListResponse extends CountryListResponse {
  @override
  final BuiltList<CountryEntity> data;

  factory _$CountryListResponse([void updates(CountryListResponseBuilder b)]) =>
      (new CountryListResponseBuilder()..update(updates)).build();

  _$CountryListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('CountryListResponse', 'data');
    }
  }

  @override
  CountryListResponse rebuild(void updates(CountryListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryListResponseBuilder toBuilder() =>
      new CountryListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountryListResponse && data == other.data;
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
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
    if (data == null) {
      throw new BuiltValueNullFieldError('CountryItemResponse', 'data');
    }
  }

  @override
  CountryItemResponse rebuild(void updates(CountryItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryItemResponseBuilder toBuilder() =>
      new CountryItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountryItemResponse && data == other.data;
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
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
  final String name;
  @override
  final bool swapPostalCode;
  @override
  final bool swapCurrencySymbol;
  @override
  final String thousandSeparator;
  @override
  final String decimalSeparator;
  @override
  final String iso2;
  @override
  final String iso3;
  @override
  final int id;

  factory _$CountryEntity([void updates(CountryEntityBuilder b)]) =>
      (new CountryEntityBuilder()..update(updates)).build();

  _$CountryEntity._(
      {this.name,
      this.swapPostalCode,
      this.swapCurrencySymbol,
      this.thousandSeparator,
      this.decimalSeparator,
      this.iso2,
      this.iso3,
      this.id})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('CountryEntity', 'name');
    }
    if (swapPostalCode == null) {
      throw new BuiltValueNullFieldError('CountryEntity', 'swapPostalCode');
    }
    if (swapCurrencySymbol == null) {
      throw new BuiltValueNullFieldError('CountryEntity', 'swapCurrencySymbol');
    }
    if (iso2 == null) {
      throw new BuiltValueNullFieldError('CountryEntity', 'iso2');
    }
    if (iso3 == null) {
      throw new BuiltValueNullFieldError('CountryEntity', 'iso3');
    }
  }

  @override
  CountryEntity rebuild(void updates(CountryEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryEntityBuilder toBuilder() => new CountryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountryEntity &&
        name == other.name &&
        swapPostalCode == other.swapPostalCode &&
        swapCurrencySymbol == other.swapCurrencySymbol &&
        thousandSeparator == other.thousandSeparator &&
        decimalSeparator == other.decimalSeparator &&
        iso2 == other.iso2 &&
        iso3 == other.iso3 &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, name.hashCode), swapPostalCode.hashCode),
                            swapCurrencySymbol.hashCode),
                        thousandSeparator.hashCode),
                    decimalSeparator.hashCode),
                iso2.hashCode),
            iso3.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CountryEntity')
          ..add('name', name)
          ..add('swapPostalCode', swapPostalCode)
          ..add('swapCurrencySymbol', swapCurrencySymbol)
          ..add('thousandSeparator', thousandSeparator)
          ..add('decimalSeparator', decimalSeparator)
          ..add('iso2', iso2)
          ..add('iso3', iso3)
          ..add('id', id))
        .toString();
  }
}

class CountryEntityBuilder
    implements Builder<CountryEntity, CountryEntityBuilder> {
  _$CountryEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

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

  String _iso2;
  String get iso2 => _$this._iso2;
  set iso2(String iso2) => _$this._iso2 = iso2;

  String _iso3;
  String get iso3 => _$this._iso3;
  set iso3(String iso3) => _$this._iso3 = iso3;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  CountryEntityBuilder();

  CountryEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _swapPostalCode = _$v.swapPostalCode;
      _swapCurrencySymbol = _$v.swapCurrencySymbol;
      _thousandSeparator = _$v.thousandSeparator;
      _decimalSeparator = _$v.decimalSeparator;
      _iso2 = _$v.iso2;
      _iso3 = _$v.iso3;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
            name: name,
            swapPostalCode: swapPostalCode,
            swapCurrencySymbol: swapCurrencySymbol,
            thousandSeparator: thousandSeparator,
            decimalSeparator: decimalSeparator,
            iso2: iso2,
            iso3: iso3,
            id: id);
    replace(_$result);
    return _$result;
  }
}
