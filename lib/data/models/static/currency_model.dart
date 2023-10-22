// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'currency_model.g.dart';

abstract class CurrencyListResponse
    implements Built<CurrencyListResponse, CurrencyListResponseBuilder> {
  factory CurrencyListResponse([void updates(CurrencyListResponseBuilder b)]) =
      _$CurrencyListResponse;
  CurrencyListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<CurrencyEntity> get data;

  static Serializer<CurrencyListResponse> get serializer =>
      _$currencyListResponseSerializer;
}

abstract class CurrencyItemResponse
    implements Built<CurrencyItemResponse, CurrencyItemResponseBuilder> {
  factory CurrencyItemResponse([void updates(CurrencyItemResponseBuilder b)]) =
      _$CurrencyItemResponse;
  CurrencyItemResponse._();

  @override
  @memoized
  int get hashCode;

  CurrencyEntity get data;

  static Serializer<CurrencyItemResponse> get serializer =>
      _$currencyItemResponseSerializer;
}

class CurrencyFields {
  static const String name = 'name';
  static const String symbol = 'symbol';
  static const String precision = 'precision';
  static const String thousandSeparator = 'thousand_separator';
  static const String decimalSeparator = 'decimal_separator';
  static const String code = 'code';
  static const String swapCurrencySymbol = 'swap_currency_symbol';
  static const String exchangeRate = 'exchange_rate';
}

abstract class CurrencyEntity extends Object
    with SelectableEntity
    implements Built<CurrencyEntity, CurrencyEntityBuilder> {
  factory CurrencyEntity() {
    return _$CurrencyEntity._(
      id: '',
      name: '',
      symbol: '',
      precision: 2,
      thousandSeparator: '',
      decimalSeparator: '',
      code: '',
      exchangeRate: 0.0,
      swapCurrencySymbol: false,
    );
  }
  CurrencyEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  String get symbol;

  int get precision;

  @BuiltValueField(wireName: 'thousand_separator')
  String get thousandSeparator;

  @BuiltValueField(wireName: 'decimal_separator')
  String get decimalSeparator;

  String get code;

  @BuiltValueField(wireName: 'swap_currency_symbol')
  bool get swapCurrencySymbol;

  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @override
  bool matchesFilter(String? filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    } else if (code.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String? matchesFilterValue(String? filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    if (code.toLowerCase().contains(filter)) {
      return code;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double? get listDisplayAmount => null;

  static Serializer<CurrencyEntity> get serializer =>
      _$currencyEntitySerializer;
}
