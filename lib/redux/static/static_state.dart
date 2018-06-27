import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/models.dart';

part 'static_state.g.dart';

abstract class StaticState implements Built<StaticState, StaticStateBuilder> {

  BuiltList<CurrencyEntity> get currencies;
  BuiltList<SizeEntity> get sizes;
  BuiltList<IndustryEntity> get industries;
  BuiltList<TimezoneEntity> get timezones;
  BuiltList<DateFormatEntity> get dateFormats;
  BuiltList<DatetimeFormatEntity> get datetimeFormats;
  BuiltList<LanguageEntity> get languages;
  BuiltList<PaymentTypeEntity> get paymentTypes;
  BuiltList<CountryEntity> get countries;
  BuiltList<InvoiceStatusEntity> get invoiceStatus;
  BuiltList<FrequencyEntity> get frequencies;

  factory StaticState() {
    return _$StaticState._(
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
    );
  }

  StaticState._();
  static Serializer<StaticState> get serializer => _$staticStateSerializer;
}
