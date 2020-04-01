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
      gatewayMap: BuiltMap<String, GatewayEntity>(),
      industryMap: BuiltMap<String, IndustryEntity>(),
      timezoneMap: BuiltMap<String, TimezoneEntity>(),
      dateFormatMap: BuiltMap<String, DateFormatEntity>(),
      languageMap: BuiltMap<String, LanguageEntity>(),
      paymentTypeMap: BuiltMap<String, PaymentTypeEntity>(),
      countryMap: BuiltMap<String, CountryEntity>(),
      invoiceStatusMap: BuiltMap<String, InvoiceStatusEntity>(),
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

  BuiltMap<String, GatewayEntity> get gatewayMap;

  BuiltMap<String, IndustryEntity> get industryMap;

  BuiltMap<String, TimezoneEntity> get timezoneMap;

  BuiltMap<String, DateFormatEntity> get dateFormatMap;

  BuiltMap<String, LanguageEntity> get languageMap;

  BuiltMap<String, PaymentTypeEntity> get paymentTypeMap;

  BuiltMap<String, CountryEntity> get countryMap;

  BuiltMap<String, InvoiceStatusEntity> get invoiceStatusMap;

  static Serializer<StaticState> get serializer => _$staticStateSerializer;
}
