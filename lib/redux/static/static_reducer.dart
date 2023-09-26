// Package imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';

Reducer<StaticState> staticReducer = combineReducers([
  TypedReducer<StaticState, LoadStaticSuccess>(staticLoadedReducer),
]);

StaticState staticLoadedReducer(
    StaticState staticState, LoadStaticSuccess action) {
  final data = action.data;
  return StaticState().rebuild((b) => b
    ..updatedAt = DateTime.now().millisecondsSinceEpoch
    ..templateMap.replace(data!.templates)
    ..currencyMap.addAll(Map<String, CurrencyEntity>.fromIterable(
      data.currencies,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..sizeMap.addAll(Map<String, SizeEntity>.fromIterable(
      data.sizes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..industryMap.addAll(Map<String, IndustryEntity>.fromIterable(
      data.industries,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..timezoneMap.addAll(Map<String, TimezoneEntity>.fromIterable(
      data.timezones,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..dateFormatMap.addAll(Map<String, DateFormatEntity>.fromIterable(
      data.dateFormats,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..languageMap.addAll(Map<String, LanguageEntity>.fromIterable(
      data.languages,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..paymentTypeMap.addAll(Map<String, PaymentTypeEntity>.fromIterable(
      data.paymentTypes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..countryMap.addAll(Map<String, CountryEntity>.fromIterable(
      data.countries,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..gatewayMap.addAll(Map<String, GatewayEntity>.fromIterable(
      data.gateways,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));
}
