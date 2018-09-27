// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

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
  Iterable serialize(Serializers serializers, CurrencyListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(CurrencyEntity)])),
    ];

    return result;
  }

  @override
  CurrencyListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CurrencyEntity)]))
              as BuiltList);
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
  Iterable serialize(Serializers serializers, CurrencyItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(CurrencyEntity)),
    ];

    return result;
  }

  @override
  CurrencyItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(CurrencyEntity)) as CurrencyEntity);
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
  Iterable serialize(Serializers serializers, CurrencyEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'symbol',
      serializers.serialize(object.symbol,
          specifiedType: const FullType(String)),
      'precision',
      serializers.serialize(object.precision,
          specifiedType: const FullType(String)),
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
    ];
    if (object.exchangeRate != null) {
      result
        ..add('exchange_rate')
        ..add(serializers.serialize(object.exchangeRate,
            specifiedType: const FullType(double)));
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
  CurrencyEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyEntityBuilder();

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
        case 'symbol':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'precision':
          result.precision = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thousand_separator':
          result.thousandSeparator = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'decimal_separator':
          result.decimalSeparator = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'swap_currency_symbol':
          result.swapCurrencySymbol = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'exchange_rate':
          result.exchangeRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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

class _$CurrencyListResponse extends CurrencyListResponse {
  @override
  final BuiltList<CurrencyEntity> data;

  factory _$CurrencyListResponse(
          [void updates(CurrencyListResponseBuilder b)]) =>
      (new CurrencyListResponseBuilder()..update(updates)).build();

  _$CurrencyListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('CurrencyListResponse', 'data');
    }
  }

  @override
  CurrencyListResponse rebuild(void updates(CurrencyListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyListResponseBuilder toBuilder() =>
      new CurrencyListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrencyListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CurrencyListResponse')
          ..add('data', data))
        .toString();
  }
}

class CurrencyListResponseBuilder
    implements Builder<CurrencyListResponse, CurrencyListResponseBuilder> {
  _$CurrencyListResponse _$v;

  ListBuilder<CurrencyEntity> _data;
  ListBuilder<CurrencyEntity> get data =>
      _$this._data ??= new ListBuilder<CurrencyEntity>();
  set data(ListBuilder<CurrencyEntity> data) => _$this._data = data;

  CurrencyListResponseBuilder();

  CurrencyListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrencyListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CurrencyListResponse;
  }

  @override
  void update(void updates(CurrencyListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CurrencyListResponse build() {
    _$CurrencyListResponse _$result;
    try {
      _$result = _$v ?? new _$CurrencyListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CurrencyListResponse', _$failedField, e.toString());
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
          [void updates(CurrencyItemResponseBuilder b)]) =>
      (new CurrencyItemResponseBuilder()..update(updates)).build();

  _$CurrencyItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('CurrencyItemResponse', 'data');
    }
  }

  @override
  CurrencyItemResponse rebuild(void updates(CurrencyItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyItemResponseBuilder toBuilder() =>
      new CurrencyItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrencyItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CurrencyItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CurrencyItemResponseBuilder
    implements Builder<CurrencyItemResponse, CurrencyItemResponseBuilder> {
  _$CurrencyItemResponse _$v;

  CurrencyEntityBuilder _data;
  CurrencyEntityBuilder get data =>
      _$this._data ??= new CurrencyEntityBuilder();
  set data(CurrencyEntityBuilder data) => _$this._data = data;

  CurrencyItemResponseBuilder();

  CurrencyItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrencyItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CurrencyItemResponse;
  }

  @override
  void update(void updates(CurrencyItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CurrencyItemResponse build() {
    _$CurrencyItemResponse _$result;
    try {
      _$result = _$v ?? new _$CurrencyItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CurrencyItemResponse', _$failedField, e.toString());
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
  final String precision;
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
  final int id;

  factory _$CurrencyEntity([void updates(CurrencyEntityBuilder b)]) =>
      (new CurrencyEntityBuilder()..update(updates)).build();

  _$CurrencyEntity._(
      {this.name,
      this.symbol,
      this.precision,
      this.thousandSeparator,
      this.decimalSeparator,
      this.code,
      this.swapCurrencySymbol,
      this.exchangeRate,
      this.id})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('CurrencyEntity', 'name');
    }
    if (symbol == null) {
      throw new BuiltValueNullFieldError('CurrencyEntity', 'symbol');
    }
    if (precision == null) {
      throw new BuiltValueNullFieldError('CurrencyEntity', 'precision');
    }
    if (thousandSeparator == null) {
      throw new BuiltValueNullFieldError('CurrencyEntity', 'thousandSeparator');
    }
    if (decimalSeparator == null) {
      throw new BuiltValueNullFieldError('CurrencyEntity', 'decimalSeparator');
    }
    if (code == null) {
      throw new BuiltValueNullFieldError('CurrencyEntity', 'code');
    }
    if (swapCurrencySymbol == null) {
      throw new BuiltValueNullFieldError(
          'CurrencyEntity', 'swapCurrencySymbol');
    }
  }

  @override
  CurrencyEntity rebuild(void updates(CurrencyEntityBuilder b)) =>
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

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, name.hashCode), symbol.hashCode),
                                precision.hashCode),
                            thousandSeparator.hashCode),
                        decimalSeparator.hashCode),
                    code.hashCode),
                swapCurrencySymbol.hashCode),
            exchangeRate.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CurrencyEntity')
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
  _$CurrencyEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _symbol;
  String get symbol => _$this._symbol;
  set symbol(String symbol) => _$this._symbol = symbol;

  String _precision;
  String get precision => _$this._precision;
  set precision(String precision) => _$this._precision = precision;

  String _thousandSeparator;
  String get thousandSeparator => _$this._thousandSeparator;
  set thousandSeparator(String thousandSeparator) =>
      _$this._thousandSeparator = thousandSeparator;

  String _decimalSeparator;
  String get decimalSeparator => _$this._decimalSeparator;
  set decimalSeparator(String decimalSeparator) =>
      _$this._decimalSeparator = decimalSeparator;

  String _code;
  String get code => _$this._code;
  set code(String code) => _$this._code = code;

  bool _swapCurrencySymbol;
  bool get swapCurrencySymbol => _$this._swapCurrencySymbol;
  set swapCurrencySymbol(bool swapCurrencySymbol) =>
      _$this._swapCurrencySymbol = swapCurrencySymbol;

  double _exchangeRate;
  double get exchangeRate => _$this._exchangeRate;
  set exchangeRate(double exchangeRate) => _$this._exchangeRate = exchangeRate;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  CurrencyEntityBuilder();

  CurrencyEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _symbol = _$v.symbol;
      _precision = _$v.precision;
      _thousandSeparator = _$v.thousandSeparator;
      _decimalSeparator = _$v.decimalSeparator;
      _code = _$v.code;
      _swapCurrencySymbol = _$v.swapCurrencySymbol;
      _exchangeRate = _$v.exchangeRate;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrencyEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CurrencyEntity;
  }

  @override
  void update(void updates(CurrencyEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CurrencyEntity build() {
    final _$result = _$v ??
        new _$CurrencyEntity._(
            name: name,
            symbol: symbol,
            precision: precision,
            thousandSeparator: thousandSeparator,
            decimalSeparator: decimalSeparator,
            code: code,
            swapCurrencySymbol: swapCurrencySymbol,
            exchangeRate: exchangeRate,
            id: id);
    replace(_$result);
    return _$result;
  }
}
