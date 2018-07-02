import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

part 'country_model.g.dart';

abstract class CountryListResponse implements Built<CountryListResponse, CountryListResponseBuilder> {

  factory CountryListResponse([void updates(CountryListResponseBuilder b)]) = _$CountryListResponse;
  CountryListResponse._();

  BuiltList<CountryEntity> get data;

  static Serializer<CountryListResponse> get serializer => _$countryListResponseSerializer;
}

abstract class CountryItemResponse implements Built<CountryItemResponse, CountryItemResponseBuilder> {

  factory CountryItemResponse([void updates(CountryItemResponseBuilder b)]) = _$CountryItemResponse;
  CountryItemResponse._();

  CountryEntity get data;

  static Serializer<CountryItemResponse> get serializer => _$countryItemResponseSerializer;
}

class CountryFields {
  static const String name = 'name';
  static const String swapPostalCode = 'swapPostalCode';
  static const String swapCurrencySymbol = 'swapCurrencySymbol';
  static const String thousandSeparator = 'thousandSeparator';
  static const String decimalSeparator = 'decimalSeparator';

  /*
  static const String capital = 'capital';
  static const String citizenship = 'citizenship';
  static const String countryCode = 'countryCode';
  static const String currency = 'currency';
  static const String currencyCode = 'currencyCode';
  static const String currencySubUnit = 'currencySubUnit';
  static const String fullName = 'fullName';
  static const String regionCode = 'regionCode';
  static const String subRegionCode = 'subRegionCode';
  static const String eea = 'eea';
  */
}


abstract class CountryEntity extends Object with SelectableEntity implements Built<CountryEntity, CountryEntityBuilder> {

  factory CountryEntity() {
    return _$CountryEntity._(
      id: 0,
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

  String get name;

  @BuiltValueField(wireName: 'swap_postal_code')
  bool get swapPostalCode;

  @BuiltValueField(wireName: 'swap_currency_symbol')
  bool get swapCurrencySymbol;

  // TODO remove once fixed in the app
  @nullable
  @BuiltValueField(wireName: 'thousand_separator')
  String get thousandSeparator;

  // TODO remove once fixed in the app
  @nullable
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
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    search = search.toLowerCase();

    if (name.toLowerCase().contains(search)) {
      return true;
    } else if (iso2.toLowerCase().contains(search)) {
      return true;
    } else if (iso3.toLowerCase().contains(search)) {
      return true;
    }

    return false;
  }

  @override
  String matchesSearchValue(String search) {
    if (search == null || search.isEmpty) {
      return null;
    }

    search = search.toLowerCase();
    if (name.toLowerCase().contains(search)) {
      return name;
    } else if (iso2.toLowerCase().contains(search)) {
      return iso2;
    } else if (iso3.toLowerCase().contains(search)) {
      return iso3;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  String listDisplayCost(AppState state) {
    return '';
  }

  static Serializer<CountryEntity> get serializer => _$countryEntitySerializer;
}

