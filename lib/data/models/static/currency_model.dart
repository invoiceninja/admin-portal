import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'currency_model.g.dart';

abstract class CurrencyListResponse implements Built<CurrencyListResponse, CurrencyListResponseBuilder> {

  BuiltList<CurrencyEntity> get data;

  CurrencyListResponse._();
  factory CurrencyListResponse([updates(CurrencyListResponseBuilder b)]) = _$CurrencyListResponse;
  static Serializer<CurrencyListResponse> get serializer => _$currencyListResponseSerializer;
}

abstract class CurrencyItemResponse implements Built<CurrencyItemResponse, CurrencyItemResponseBuilder> {

  CurrencyEntity get data;

  CurrencyItemResponse._();
  factory CurrencyItemResponse([updates(CurrencyItemResponseBuilder b)]) = _$CurrencyItemResponse;
  static Serializer<CurrencyItemResponse> get serializer => _$currencyItemResponseSerializer;
}

class CurrencyFields {
  static const String name = 'name';
  static const String symbol = 'symbol';
  static const String precision = 'precision';
  static const String thousandSeparator = 'thousandSeparator';
  static const String decimalSeparator = 'decimalSeparator';
  static const String code = 'code';
  static const String swapCurrencySymbol = 'swapCurrencySymbol';
  static const String exchangeRate = 'exchangeRate';
}

abstract class CurrencyEntity implements Built<CurrencyEntity, CurrencyEntityBuilder> {
  
  @nullable
  String get name;

  @nullable
  String get symbol;

  @nullable
  String get precision;

  @nullable
  @BuiltValueField(wireName: 'thousand_separator')
  String get thousandSeparator;

  @nullable
  @BuiltValueField(wireName: 'decimal_separator')
  String get decimalSeparator;

  @nullable
  String get code;

  @nullable
  @BuiltValueField(wireName: 'swap_currency_symbol')
  bool get swapCurrencySymbol;

  @nullable
  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  CurrencyEntity._();
  factory CurrencyEntity([updates(CurrencyEntityBuilder b)]) = _$CurrencyEntity;
  static Serializer<CurrencyEntity> get serializer => _$currencyEntitySerializer;
}