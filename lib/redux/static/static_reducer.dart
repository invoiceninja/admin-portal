import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:redux/redux.dart';

Reducer<StaticState> staticReducer = combineReducers([
  TypedReducer<StaticState, LoadStaticSuccess>(staticLoadedReducer),
]);

StaticState staticLoadedReducer(
    StaticState staticState, LoadStaticSuccess action) {
  final data = action.data;
  return StaticState().rebuild((b) => b
    ..updatedAt = DateTime.now().millisecondsSinceEpoch
    ..templateMap.replace(data.templates)
    ..currencyMap.addAll(Map.fromIterable(
      data.currencies,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..sizeMap.addAll(Map.fromIterable(
      data.sizes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..industryMap.addAll(Map.fromIterable(
      data.industries,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..timezoneMap.addAll(Map.fromIterable(
      data.timezones,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..dateFormatMap.addAll(Map.fromIterable(
      data.dateFormats,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..languageMap.addAll(Map.fromIterable(
      data.languages,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..paymentTypeMap.addAll(Map.fromIterable(
      data.paymentTypes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..countryMap.addAll(Map.fromIterable(
      data.countries,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..gatewayMap.addAll(Map.fromIterable(
      data.gateways,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));
}
