import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/models.dart';

part 'static_state.g.dart';

abstract class StaticState implements Built<StaticState, StaticStateBuilder> {

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

  factory StaticState() {
    return _$StaticState._(
      //currencyList: BuiltList<int>(),
      //currencyMap: BuiltMap<int, CurrencyEntity>(),
      /*
      currencies: BuiltList<CurrencyEntity>(),
        sizes: BuiltList<SizeEntity>(),
        industries: BuiltList<IndustryEntity>(),
        timezones: BuiltList<TimezoneEntity>(),
        dateFormats: BuiltList<DateFormatEntity>(),
        datetimeFormats: BuiltList<DatetimeFormatEntity>(),
        languages: BuiltList<LanguageEntity>(),
        paymentTypes: BuiltList<PaymentTypeEntity>(),
        countries: BuiltList<CountryEntity>(),
        invoiceStatus: BuiltList<InvoiceStatusEntity>(),
        frequencies: BuiltList<FrequencyEntity>(),
        */
    );
  }

  StaticState._();
  static Serializer<StaticState> get serializer => _$staticStateSerializer;
}
