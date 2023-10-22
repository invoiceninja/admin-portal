// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CurrencyListResponse> _$currencyListResponseSerializer =
    new _$CurrencyListResponseSerializer();
Serializer<CurrencyItemResponse> _$currencyItemResponseSerializer =
    new _$CurrencyItemResponseSerializer();
Serializer<CurrencyEntity> _$currencyEntitySerializer =
    new _$CurrencyEntitySerializer();

class _$CurrencyListResponseSerializer
    implements StructuredSerializer<CurrencyListResponse> {
  @override
  final Iterable<Type> types = const [
    CurrencyListResponse,
    _$CurrencyListResponse
  ];
  @override
  final String wireName = 'CurrencyListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CurrencyListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(CurrencyEntity)])),
    ];

    return result;
  }

  @override
  CurrencyListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CurrencyEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$CurrencyItemResponseSerializer
    implements StructuredSerializer<CurrencyItemResponse> {
  @override
  final Iterable<Type> types = const [
    CurrencyItemResponse,
    _$CurrencyItemResponse
  ];
  @override
  final String wireName = 'CurrencyItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CurrencyItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(CurrencyEntity)),
    ];

    return result;
  }

  @override
  CurrencyItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CurrencyEntity))!
              as CurrencyEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$CurrencyEntitySerializer
    implements StructuredSerializer<CurrencyEntity> {
  @override
  final Iterable<Type> types = const [CurrencyEntity, _$CurrencyEntity];
  @override
  final String wireName = 'CurrencyEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, CurrencyEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'symbol',
      serializers.serialize(object.symbol,
          specifiedType: const FullType(String)),
      'precision',
      serializers.serialize(object.precision,
          specifiedType: const FullType(int)),
      'thousand_separator',
      serializers.serialize(object.thousandSeparator,
          specifiedType: const FullType(String)),
      'decimal_separator',
      serializers.serialize(object.decimalSeparator,
          specifiedType: const FullType(String)),
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(String)),
      'swap_currency_symbol',
      serializers.serialize(object.swapCurrencySymbol,
          specifiedType: const FullType(bool)),
      'exchange_rate',
      serializers.serialize(object.exchangeRate,
          specifiedType: const FullType(double)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  CurrencyEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyEntityBuilder();

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
        case 'symbol':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'precision':
          result.precision = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'thousand_separator':
          result.thousandSeparator = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'decimal_separator':
          result.decimalSeparator = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'swap_currency_symbol':
          result.swapCurrencySymbol = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'exchange_rate':
          result.exchangeRate = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
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

class _$CurrencyListResponse extends CurrencyListResponse {
  @override
  final BuiltList<CurrencyEntity> data;

  factory _$CurrencyListResponse(
          [void Function(CurrencyListResponseBuilder)? updates]) =>
      (new CurrencyListResponseBuilder()..update(updates))._build();

  _$CurrencyListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'CurrencyListResponse', 'data');
  }

  @override
  CurrencyListResponse rebuild(
          void Function(CurrencyListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyListResponseBuilder toBuilder() =>
      new CurrencyListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrencyListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'CurrencyListResponse')
          ..add('data', data))
        .toString();
  }
}

class CurrencyListResponseBuilder
    implements Builder<CurrencyListResponse, CurrencyListResponseBuilder> {
  _$CurrencyListResponse? _$v;

  ListBuilder<CurrencyEntity>? _data;
  ListBuilder<CurrencyEntity> get data =>
      _$this._data ??= new ListBuilder<CurrencyEntity>();
  set data(ListBuilder<CurrencyEntity>? data) => _$this._data = data;

  CurrencyListResponseBuilder();

  CurrencyListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrencyListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CurrencyListResponse;
  }

  @override
  void update(void Function(CurrencyListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrencyListResponse build() => _build();

  _$CurrencyListResponse _build() {
    _$CurrencyListResponse _$result;
    try {
      _$result = _$v ?? new _$CurrencyListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CurrencyListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CurrencyItemResponse extends CurrencyItemResponse {
  @override
  final CurrencyEntity data;

  factory _$CurrencyItemResponse(
          [void Function(CurrencyItemResponseBuilder)? updates]) =>
      (new CurrencyItemResponseBuilder()..update(updates))._build();

  _$CurrencyItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'CurrencyItemResponse', 'data');
  }

  @override
  CurrencyItemResponse rebuild(
          void Function(CurrencyItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyItemResponseBuilder toBuilder() =>
      new CurrencyItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrencyItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'CurrencyItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CurrencyItemResponseBuilder
    implements Builder<CurrencyItemResponse, CurrencyItemResponseBuilder> {
  _$CurrencyItemResponse? _$v;

  CurrencyEntityBuilder? _data;
  CurrencyEntityBuilder get data =>
      _$this._data ??= new CurrencyEntityBuilder();
  set data(CurrencyEntityBuilder? data) => _$this._data = data;

  CurrencyItemResponseBuilder();

  CurrencyItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrencyItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CurrencyItemResponse;
  }

  @override
  void update(void Function(CurrencyItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrencyItemResponse build() => _build();

  _$CurrencyItemResponse _build() {
    _$CurrencyItemResponse _$result;
    try {
      _$result = _$v ?? new _$CurrencyItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CurrencyItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CurrencyEntity extends CurrencyEntity {
  @override
  final String name;
  @override
  final String symbol;
  @override
  final int precision;
  @override
  final String thousandSeparator;
  @override
  final String decimalSeparator;
  @override
  final String code;
  @override
  final bool swapCurrencySymbol;
  @override
  final double exchangeRate;
  @override
  final String id;

  factory _$CurrencyEntity([void Function(CurrencyEntityBuilder)? updates]) =>
      (new CurrencyEntityBuilder()..update(updates))._build();

  _$CurrencyEntity._(
      {required this.name,
      required this.symbol,
      required this.precision,
      required this.thousandSeparator,
      required this.decimalSeparator,
      required this.code,
      required this.swapCurrencySymbol,
      required this.exchangeRate,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'CurrencyEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(symbol, r'CurrencyEntity', 'symbol');
    BuiltValueNullFieldError.checkNotNull(
        precision, r'CurrencyEntity', 'precision');
    BuiltValueNullFieldError.checkNotNull(
        thousandSeparator, r'CurrencyEntity', 'thousandSeparator');
    BuiltValueNullFieldError.checkNotNull(
        decimalSeparator, r'CurrencyEntity', 'decimalSeparator');
    BuiltValueNullFieldError.checkNotNull(code, r'CurrencyEntity', 'code');
    BuiltValueNullFieldError.checkNotNull(
        swapCurrencySymbol, r'CurrencyEntity', 'swapCurrencySymbol');
    BuiltValueNullFieldError.checkNotNull(
        exchangeRate, r'CurrencyEntity', 'exchangeRate');
    BuiltValueNullFieldError.checkNotNull(id, r'CurrencyEntity', 'id');
  }

  @override
  CurrencyEntity rebuild(void Function(CurrencyEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyEntityBuilder toBuilder() =>
      new CurrencyEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrencyEntity &&
        name == other.name &&
        symbol == other.symbol &&
        precision == other.precision &&
        thousandSeparator == other.thousandSeparator &&
        decimalSeparator == other.decimalSeparator &&
        code == other.code &&
        swapCurrencySymbol == other.swapCurrencySymbol &&
        exchangeRate == other.exchangeRate &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, precision.hashCode);
    _$hash = $jc(_$hash, thousandSeparator.hashCode);
    _$hash = $jc(_$hash, decimalSeparator.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, swapCurrencySymbol.hashCode);
    _$hash = $jc(_$hash, exchangeRate.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CurrencyEntity')
          ..add('name', name)
          ..add('symbol', symbol)
          ..add('precision', precision)
          ..add('thousandSeparator', thousandSeparator)
          ..add('decimalSeparator', decimalSeparator)
          ..add('code', code)
          ..add('swapCurrencySymbol', swapCurrencySymbol)
          ..add('exchangeRate', exchangeRate)
          ..add('id', id))
        .toString();
  }
}

class CurrencyEntityBuilder
    implements Builder<CurrencyEntity, CurrencyEntityBuilder> {
  _$CurrencyEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  int? _precision;
  int? get precision => _$this._precision;
  set precision(int? precision) => _$this._precision = precision;

  String? _thousandSeparator;
  String? get thousandSeparator => _$this._thousandSeparator;
  set thousandSeparator(String? thousandSeparator) =>
      _$this._thousandSeparator = thousandSeparator;

  String? _decimalSeparator;
  String? get decimalSeparator => _$this._decimalSeparator;
  set decimalSeparator(String? decimalSeparator) =>
      _$this._decimalSeparator = decimalSeparator;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  bool? _swapCurrencySymbol;
  bool? get swapCurrencySymbol => _$this._swapCurrencySymbol;
  set swapCurrencySymbol(bool? swapCurrencySymbol) =>
      _$this._swapCurrencySymbol = swapCurrencySymbol;

  double? _exchangeRate;
  double? get exchangeRate => _$this._exchangeRate;
  set exchangeRate(double? exchangeRate) => _$this._exchangeRate = exchangeRate;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  CurrencyEntityBuilder();

  CurrencyEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _symbol = $v.symbol;
      _precision = $v.precision;
      _thousandSeparator = $v.thousandSeparator;
      _decimalSeparator = $v.decimalSeparator;
      _code = $v.code;
      _swapCurrencySymbol = $v.swapCurrencySymbol;
      _exchangeRate = $v.exchangeRate;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrencyEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CurrencyEntity;
  }

  @override
  void update(void Function(CurrencyEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrencyEntity build() => _build();

  _$CurrencyEntity _build() {
    final _$result = _$v ??
        new _$CurrencyEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CurrencyEntity', 'name'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'CurrencyEntity', 'symbol'),
            precision: BuiltValueNullFieldError.checkNotNull(
                precision, r'CurrencyEntity', 'precision'),
            thousandSeparator: BuiltValueNullFieldError.checkNotNull(
                thousandSeparator, r'CurrencyEntity', 'thousandSeparator'),
            decimalSeparator: BuiltValueNullFieldError.checkNotNull(
                decimalSeparator, r'CurrencyEntity', 'decimalSeparator'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'CurrencyEntity', 'code'),
            swapCurrencySymbol: BuiltValueNullFieldError.checkNotNull(
                swapCurrencySymbol, r'CurrencyEntity', 'swapCurrencySymbol'),
            exchangeRate: BuiltValueNullFieldError.checkNotNull(
                exchangeRate, r'CurrencyEntity', 'exchangeRate'),
            id: BuiltValueNullFieldError.checkNotNull(id, r'CurrencyEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
