import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'static_state.g.dart';

abstract class StaticState implements Built<StaticState, StaticStateBuilder> {
  factory StaticState() {
    return _$StaticState._(
      currencyMap: BuiltMap<String, CurrencyEntity>(),
      sizeMap: BuiltMap<String, SizeEntity>(),
      industryMap: BuiltMap<String, IndustryEntity>(),
      timezoneMap: BuiltMap<String, TimezoneEntity>(),
      dateFormatMap: BuiltMap<String, DateFormatEntity>(),
      datetimeFormatMap: BuiltMap<String, DatetimeFormatEntity>(),
      languageMap: BuiltMap<String, LanguageEntity>(),
      paymentTypeMap: BuiltMap<String, PaymentTypeEntity>(),
      countryMap: BuiltMap<String, CountryEntity>(),
      invoiceStatusMap: BuiltMap<String, InvoiceStatusEntity>(),
      frequencyMap: BuiltMap<String, FrequencyEntity>(),
    );
  }

  StaticState._();

  @nullable
  int get updatedAt;

  bool get isLoaded => updatedAt != null && updatedAt > 0;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - updatedAt >
        kMillisecondsToRefreshStaticData;
  }

  BuiltMap<String, CurrencyEntity> get currencyMap;

  BuiltMap<String, SizeEntity> get sizeMap;

  BuiltMap<String, IndustryEntity> get industryMap;

  BuiltMap<String, TimezoneEntity> get timezoneMap;

  BuiltMap<String, DateFormatEntity> get dateFormatMap;

  BuiltMap<String, DatetimeFormatEntity> get datetimeFormatMap;

  BuiltMap<String, LanguageEntity> get languageMap;

  BuiltMap<String, PaymentTypeEntity> get paymentTypeMap;

  BuiltMap<String, CountryEntity> get countryMap;

  BuiltMap<String, InvoiceStatusEntity> get invoiceStatusMap;

  BuiltMap<String, FrequencyEntity> get frequencyMap;

  static Serializer<StaticState> get serializer => _$staticStateSerializer;
}
