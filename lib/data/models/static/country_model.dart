// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'country_model.g.dart';

abstract class CountryListResponse
    implements Built<CountryListResponse, CountryListResponseBuilder> {
  factory CountryListResponse([void updates(CountryListResponseBuilder b)]) =
      _$CountryListResponse;
  CountryListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<CountryEntity> get data;

  static Serializer<CountryListResponse> get serializer =>
      _$countryListResponseSerializer;
}

abstract class CountryItemResponse
    implements Built<CountryItemResponse, CountryItemResponseBuilder> {
  factory CountryItemResponse([void updates(CountryItemResponseBuilder b)]) =
      _$CountryItemResponse;
  CountryItemResponse._();

  @override
  @memoized
  int get hashCode;

  CountryEntity get data;

  static Serializer<CountryItemResponse> get serializer =>
      _$countryItemResponseSerializer;
}

class CountryFields {
  static const String name = 'name';
  static const String swapPostalCode = 'swap_postal_code';
  static const String swapCurrencySymbol = 'swap_currency_symbol';
  static const String thousandSeparator = 'thousand_separator';
  static const String decimalSeparator = 'decimal_separator';
}

abstract class CountryEntity extends Object
    with SelectableEntity
    implements Built<CountryEntity, CountryEntityBuilder> {
  factory CountryEntity() {
    return _$CountryEntity._(
      id: '',
      name: '',
      iso2: '',
      iso3: '',
      swapPostalCode: false,
      swapCurrencySymbol: false,
      thousandSeparator: '',
      decimalSeparator: '',
    );
  }
  CountryEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  @BuiltValueField(wireName: 'swap_postal_code')
  bool get swapPostalCode;

  @BuiltValueField(wireName: 'swap_currency_symbol')
  bool get swapCurrencySymbol;

  @BuiltValueField(wireName: 'thousand_separator')
  String get thousandSeparator;

  @BuiltValueField(wireName: 'decimal_separator')
  String get decimalSeparator;

  @BuiltValueField(wireName: 'iso_3166_2')
  String get iso2;

  @BuiltValueField(wireName: 'iso_3166_3')
  String get iso3;

  /*
  factory CountryEntity() {
    return _$CountryEntity._(
      capital: '',
      citizenship: '',
      countryCode: '',
      currency: '',
      currencyCode: '',
      currencySubUnit: '',
      fullName: '',
      name: '',
      regionCode: '',
      subRegionCode: '',
      eea: false,
      swapPostalCode: false,
      swapCurrencySymbol: false,
      thousandSeparator: '',
      decimalSeparator: '',
    );
  }

  @BuiltValueField(wireName: 'capital')
  String get capital;

  @BuiltValueField(wireName: 'citizenship')
  String get citizenship;

  @BuiltValueField(wireName: 'country_code')
  String get countryCode;

  @BuiltValueField(wireName: 'currency')
  String get currency;

  @BuiltValueField(wireName: 'currency_code')
  String get currencyCode;

  @BuiltValueField(wireName: 'currency_sub_unit')
  String get currencySubUnit;

  @BuiltValueField(wireName: 'full_name')
  String get fullName;

  @BuiltValueField(wireName: 'region_code')
  String get regionCode;

  @BuiltValueField(wireName: 'sub_region_code')
  String get subRegionCode;

  @BuiltValueField(wireName: 'eea')
  bool get eea;
  */

  @override
  bool matchesFilter(String? filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    } else if (iso2.toLowerCase().contains(filter)) {
      return true;
    } else if (iso3.toLowerCase().contains(filter)) {
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

    if (iso2.toLowerCase().contains(filter)) {
      return iso2;
    } else if (iso3.toLowerCase().contains(filter)) {
      return iso3;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double? get listDisplayAmount => null;

  static Serializer<CountryEntity> get serializer => _$countryEntitySerializer;
}
