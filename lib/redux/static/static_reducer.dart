import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:redux/redux.dart';

Reducer<StaticState> staticReducer = combineReducers([
  TypedReducer<StaticState, LoadStaticSuccess>(staticLoadedReducer),
]);

StaticState staticLoadedReducer(
    StaticState staticState, LoadStaticSuccess action) {
  return StaticState().rebuild((b) => b
    ..updatedAt = DateTime.now().millisecondsSinceEpoch
    ..currencyMap.addAll(Map.fromIterable(
      action.data.currencies,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..sizeMap.addAll(Map.fromIterable(
      action.data.sizes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..industryMap.addAll(Map.fromIterable(
      action.data.industries,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..timezoneMap.addAll(Map.fromIterable(
      action.data.timezones,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..dateFormatMap.addAll(Map.fromIterable(
      action.data.dateFormats,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..languageMap.addAll(Map.fromIterable(
      action.data.languages,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..paymentTypeMap.addAll(Map.fromIterable(
      action.data.paymentTypes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..countryMap.addAll(Map.fromIterable(
      action.data.countries,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..gatewayMap.addAll(Map.fromIterable(
      action.data.gateways,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));
}
