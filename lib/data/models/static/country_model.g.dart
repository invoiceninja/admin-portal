// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
  Iterable<Object?> serialize(
      Serializers serializers, CountryListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CountryEntity)])),
    ];

    return result;
  }

  @override
  CountryListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CountryListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CountryEntity)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(
      Serializers serializers, CountryItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(CountryEntity)),
    ];

    return result;
  }

  @override
  CountryItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CountryItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(CountryEntity))! as CountryEntity);
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
  Iterable<Object?> serialize(Serializers serializers, CountryEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'swap_postal_code',
      serializers.serialize(object.swapPostalCode,
          specifiedType: const FullType(bool)),
      'swap_currency_symbol',
      serializers.serialize(object.swapCurrencySymbol,
          specifiedType: const FullType(bool)),
      'thousand_separator',
      serializers.serialize(object.thousandSeparator,
          specifiedType: const FullType(String)),
      'decimal_separator',
      serializers.serialize(object.decimalSeparator,
          specifiedType: const FullType(String)),
      'iso_3166_2',
      serializers.serialize(object.iso2, specifiedType: const FullType(String)),
      'iso_3166_3',
      serializers.serialize(object.iso3, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  CountryEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CountryEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'swap_postal_code':
          result.swapPostalCode = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'swap_currency_symbol':
          result.swapCurrencySymbol = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'thousand_separator':
          result.thousandSeparator = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'decimal_separator':
          result.decimalSeparator = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'iso_3166_2':
          result.iso2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'iso_3166_3':
          result.iso3 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CountryListResponse extends CountryListResponse {
  @override
  final BuiltList<CountryEntity> data;

  factory _$CountryListResponse(
          [void Function(CountryListResponseBuilder)? updates]) =>
      (new CountryListResponseBuilder()..update(updates))._build();

  _$CountryListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'CountryListResponse', 'data');
  }

  @override
  CountryListResponse rebuild(
          void Function(CountryListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryListResponseBuilder toBuilder() =>
      new CountryListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountryListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'CountryListResponse')
          ..add('data', data))
        .toString();
  }
}

class CountryListResponseBuilder
    implements Builder<CountryListResponse, CountryListResponseBuilder> {
  _$CountryListResponse? _$v;

  ListBuilder<CountryEntity>? _data;
  ListBuilder<CountryEntity> get data =>
      _$this._data ??= new ListBuilder<CountryEntity>();
  set data(ListBuilder<CountryEntity>? data) => _$this._data = data;

  CountryListResponseBuilder();

  CountryListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CountryListResponse;
  }

  @override
  void update(void Function(CountryListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CountryListResponse build() => _build();

  _$CountryListResponse _build() {
    _$CountryListResponse _$result;
    try {
      _$result = _$v ?? new _$CountryListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CountryListResponse', _$failedField, e.toString());
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

  factory _$CountryItemResponse(
          [void Function(CountryItemResponseBuilder)? updates]) =>
      (new CountryItemResponseBuilder()..update(updates))._build();

  _$CountryItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'CountryItemResponse', 'data');
  }

  @override
  CountryItemResponse rebuild(
          void Function(CountryItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryItemResponseBuilder toBuilder() =>
      new CountryItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountryItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'CountryItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CountryItemResponseBuilder
    implements Builder<CountryItemResponse, CountryItemResponseBuilder> {
  _$CountryItemResponse? _$v;

  CountryEntityBuilder? _data;
  CountryEntityBuilder get data => _$this._data ??= new CountryEntityBuilder();
  set data(CountryEntityBuilder? data) => _$this._data = data;

  CountryItemResponseBuilder();

  CountryItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CountryItemResponse;
  }

  @override
  void update(void Function(CountryItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CountryItemResponse build() => _build();

  _$CountryItemResponse _build() {
    _$CountryItemResponse _$result;
    try {
      _$result = _$v ?? new _$CountryItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CountryItemResponse', _$failedField, e.toString());
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
  final String id;

  factory _$CountryEntity([void Function(CountryEntityBuilder)? updates]) =>
      (new CountryEntityBuilder()..update(updates))._build();

  _$CountryEntity._(
      {required this.name,
      required this.swapPostalCode,
      required this.swapCurrencySymbol,
      required this.thousandSeparator,
      required this.decimalSeparator,
      required this.iso2,
      required this.iso3,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'CountryEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        swapPostalCode, r'CountryEntity', 'swapPostalCode');
    BuiltValueNullFieldError.checkNotNull(
        swapCurrencySymbol, r'CountryEntity', 'swapCurrencySymbol');
    BuiltValueNullFieldError.checkNotNull(
        thousandSeparator, r'CountryEntity', 'thousandSeparator');
    BuiltValueNullFieldError.checkNotNull(
        decimalSeparator, r'CountryEntity', 'decimalSeparator');
    BuiltValueNullFieldError.checkNotNull(iso2, r'CountryEntity', 'iso2');
    BuiltValueNullFieldError.checkNotNull(iso3, r'CountryEntity', 'iso3');
    BuiltValueNullFieldError.checkNotNull(id, r'CountryEntity', 'id');
  }

  @override
  CountryEntity rebuild(void Function(CountryEntityBuilder) updates) =>
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, swapPostalCode.hashCode);
    _$hash = $jc(_$hash, swapCurrencySymbol.hashCode);
    _$hash = $jc(_$hash, thousandSeparator.hashCode);
    _$hash = $jc(_$hash, decimalSeparator.hashCode);
    _$hash = $jc(_$hash, iso2.hashCode);
    _$hash = $jc(_$hash, iso3.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CountryEntity')
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
  _$CountryEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _swapPostalCode;
  bool? get swapPostalCode => _$this._swapPostalCode;
  set swapPostalCode(bool? swapPostalCode) =>
      _$this._swapPostalCode = swapPostalCode;

  bool? _swapCurrencySymbol;
  bool? get swapCurrencySymbol => _$this._swapCurrencySymbol;
  set swapCurrencySymbol(bool? swapCurrencySymbol) =>
      _$this._swapCurrencySymbol = swapCurrencySymbol;

  String? _thousandSeparator;
  String? get thousandSeparator => _$this._thousandSeparator;
  set thousandSeparator(String? thousandSeparator) =>
      _$this._thousandSeparator = thousandSeparator;

  String? _decimalSeparator;
  String? get decimalSeparator => _$this._decimalSeparator;
  set decimalSeparator(String? decimalSeparator) =>
      _$this._decimalSeparator = decimalSeparator;

  String? _iso2;
  String? get iso2 => _$this._iso2;
  set iso2(String? iso2) => _$this._iso2 = iso2;

  String? _iso3;
  String? get iso3 => _$this._iso3;
  set iso3(String? iso3) => _$this._iso3 = iso3;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  CountryEntityBuilder();

  CountryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _swapPostalCode = $v.swapPostalCode;
      _swapCurrencySymbol = $v.swapCurrencySymbol;
      _thousandSeparator = $v.thousandSeparator;
      _decimalSeparator = $v.decimalSeparator;
      _iso2 = $v.iso2;
      _iso3 = $v.iso3;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CountryEntity;
  }

  @override
  void update(void Function(CountryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CountryEntity build() => _build();

  _$CountryEntity _build() {
    final _$result = _$v ??
        new _$CountryEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CountryEntity', 'name'),
            swapPostalCode: BuiltValueNullFieldError.checkNotNull(
                swapPostalCode, r'CountryEntity', 'swapPostalCode'),
            swapCurrencySymbol: BuiltValueNullFieldError.checkNotNull(
                swapCurrencySymbol, r'CountryEntity', 'swapCurrencySymbol'),
            thousandSeparator: BuiltValueNullFieldError.checkNotNull(
                thousandSeparator, r'CountryEntity', 'thousandSeparator'),
            decimalSeparator: BuiltValueNullFieldError.checkNotNull(
                decimalSeparator, r'CountryEntity', 'decimalSeparator'),
            iso2: BuiltValueNullFieldError.checkNotNull(
                iso2, r'CountryEntity', 'iso2'),
            iso3: BuiltValueNullFieldError.checkNotNull(
                iso3, r'CountryEntity', 'iso3'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'CountryEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
