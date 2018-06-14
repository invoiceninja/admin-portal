// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

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

Serializer<CurrencyListResponse> _$currencyListResponseSerializer =
    new _$CurrencyListResponseSerializer();
Serializer<CurrencyItemResponse> _$currencyItemResponseSerializer =
    new _$CurrencyItemResponseSerializer();
Serializer<Currency> _$currencySerializer = new _$CurrencySerializer();

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
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Currency)])),
    ];

    return result;
  }

  @override
  CurrencyListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
                  BuiltList, const [const FullType(Currency)])) as BuiltList);
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
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(Currency)),
    ];

    return result;
  }

  @override
  CurrencyItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CurrencyItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(Currency)) as Currency);
          break;
      }
    }

    return result.build();
  }
}

class _$CurrencySerializer implements StructuredSerializer<Currency> {
  @override
  final Iterable<Type> types = const [Currency, _$Currency];
  @override
  final String wireName = 'Currency';

  @override
  Iterable serialize(Serializers serializers, Currency object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.symbol != null) {
      result
        ..add('symbol')
        ..add(serializers.serialize(object.symbol,
            specifiedType: const FullType(String)));
    }
    if (object.precision != null) {
      result
        ..add('precision')
        ..add(serializers.serialize(object.precision,
            specifiedType: const FullType(String)));
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
    if (object.code != null) {
      result
        ..add('code')
        ..add(serializers.serialize(object.code,
            specifiedType: const FullType(String)));
    }
    if (object.swapCurrencySymbol != null) {
      result
        ..add('swap_currency_symbol')
        ..add(serializers.serialize(object.swapCurrencySymbol,
            specifiedType: const FullType(bool)));
    }
    if (object.exchangeRate != null) {
      result
        ..add('exchange_rate')
        ..add(serializers.serialize(object.exchangeRate,
            specifiedType: const FullType(double)));
    }

    return result;
  }

  @override
  Currency deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CurrencyBuilder();

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
      }
    }

    return result.build();
  }
}

class _$CurrencyListResponse extends CurrencyListResponse {
  @override
  final BuiltList<Currency> data;

  factory _$CurrencyListResponse(
          [void updates(CurrencyListResponseBuilder b)]) =>
      (new CurrencyListResponseBuilder()..update(updates)).build();

  _$CurrencyListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('CurrencyListResponse', 'data');
  }

  @override
  CurrencyListResponse rebuild(void updates(CurrencyListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyListResponseBuilder toBuilder() =>
      new CurrencyListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! CurrencyListResponse) return false;
    return data == other.data;
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

  ListBuilder<Currency> _data;
  ListBuilder<Currency> get data =>
      _$this._data ??= new ListBuilder<Currency>();
  set data(ListBuilder<Currency> data) => _$this._data = data;

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
    if (other == null) throw new ArgumentError.notNull('other');
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
  final Currency data;

  factory _$CurrencyItemResponse(
          [void updates(CurrencyItemResponseBuilder b)]) =>
      (new CurrencyItemResponseBuilder()..update(updates)).build();

  _$CurrencyItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('CurrencyItemResponse', 'data');
  }

  @override
  CurrencyItemResponse rebuild(void updates(CurrencyItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyItemResponseBuilder toBuilder() =>
      new CurrencyItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! CurrencyItemResponse) return false;
    return data == other.data;
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

  CurrencyBuilder _data;
  CurrencyBuilder get data => _$this._data ??= new CurrencyBuilder();
  set data(CurrencyBuilder data) => _$this._data = data;

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
    if (other == null) throw new ArgumentError.notNull('other');
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

class _$Currency extends Currency {
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

  factory _$Currency([void updates(CurrencyBuilder b)]) =>
      (new CurrencyBuilder()..update(updates)).build();

  _$Currency._(
      {this.name,
      this.symbol,
      this.precision,
      this.thousandSeparator,
      this.decimalSeparator,
      this.code,
      this.swapCurrencySymbol,
      this.exchangeRate})
      : super._();

  @override
  Currency rebuild(void updates(CurrencyBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyBuilder toBuilder() => new CurrencyBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Currency) return false;
    return name == other.name &&
        symbol == other.symbol &&
        precision == other.precision &&
        thousandSeparator == other.thousandSeparator &&
        decimalSeparator == other.decimalSeparator &&
        code == other.code &&
        swapCurrencySymbol == other.swapCurrencySymbol &&
        exchangeRate == other.exchangeRate;
  }

  @override
  int get hashCode {
    return $jf($jc(
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
        exchangeRate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Currency')
          ..add('name', name)
          ..add('symbol', symbol)
          ..add('precision', precision)
          ..add('thousandSeparator', thousandSeparator)
          ..add('decimalSeparator', decimalSeparator)
          ..add('code', code)
          ..add('swapCurrencySymbol', swapCurrencySymbol)
          ..add('exchangeRate', exchangeRate))
        .toString();
  }
}

class CurrencyBuilder implements Builder<Currency, CurrencyBuilder> {
  _$Currency _$v;

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

  CurrencyBuilder();

  CurrencyBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _symbol = _$v.symbol;
      _precision = _$v.precision;
      _thousandSeparator = _$v.thousandSeparator;
      _decimalSeparator = _$v.decimalSeparator;
      _code = _$v.code;
      _swapCurrencySymbol = _$v.swapCurrencySymbol;
      _exchangeRate = _$v.exchangeRate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Currency other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Currency;
  }

  @override
  void update(void updates(CurrencyBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Currency build() {
    final _$result = _$v ??
        new _$Currency._(
            name: name,
            symbol: symbol,
            precision: precision,
            thousandSeparator: thousandSeparator,
            decimalSeparator: decimalSeparator,
            code: code,
            swapCurrencySymbol: swapCurrencySymbol,
            exchangeRate: exchangeRate);
    replace(_$result);
    return _$result;
  }
}
