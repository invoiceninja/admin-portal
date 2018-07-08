import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'static_state.g.dart';

abstract class StaticState implements Built<StaticState, StaticStateBuilder> {

  factory StaticState() {
    return _$StaticState._(
      currencyMap: BuiltMap<int, CurrencyEntity>(),
      sizeMap: BuiltMap<int, SizeEntity>(),
      industryMap: BuiltMap<int, IndustryEntity>(),
      timezoneMap: BuiltMap<int, TimezoneEntity>(),
      dateFormatMap: BuiltMap<int, DateFormatEntity>(),
      datetimeFormatMap: BuiltMap<int, DatetimeFormatEntity>(),
      languageMap: BuiltMap<int, LanguageEntity>(),
      paymentTypeMap: BuiltMap<int, PaymentTypeEntity>(),
      countryMap: BuiltMap<int, CountryEntity>(),
      invoiceStatusMap: BuiltMap<int, InvoiceStatusEntity>(),
      frequencyMap: BuiltMap<int, FrequencyEntity>(),
    );
  }
  StaticState._();

  BuiltMap<int, CurrencyEntity> get currencyMap;
  BuiltMap<int, SizeEntity> get sizeMap;
  BuiltMap<int, IndustryEntity> get industryMap;
  BuiltMap<int, TimezoneEntity> get timezoneMap;
  BuiltMap<int, DateFormatEntity> get dateFormatMap;
  BuiltMap<int, DatetimeFormatEntity> get datetimeFormatMap;
  BuiltMap<int, LanguageEntity> get languageMap;
  BuiltMap<int, PaymentTypeEntity> get paymentTypeMap;
  BuiltMap<int, CountryEntity> get countryMap;
  BuiltMap<int, InvoiceStatusEntity> get invoiceStatusMap;
  BuiltMap<int, FrequencyEntity> get frequencyMap;

  static Serializer<StaticState> get serializer => _$staticStateSerializer;
}
