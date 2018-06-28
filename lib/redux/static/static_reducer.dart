import 'package:invoiceninja/redux/app/app_actions.dart';
import 'package:invoiceninja/redux/static/static_state.dart';
import 'package:redux/redux.dart';

Reducer<StaticState> staticReducer = combineReducers([
  TypedReducer<StaticState, LoadStaticSuccess>(staticLoadedReducer),
]);

StaticState staticLoadedReducer(StaticState staticState, LoadStaticSuccess action) {
  return StaticState().rebuild((b) => b
    ..currencyMap.addAll(Map.fromIterable(
      action.data.currencies,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..sizeMap.addAll(Map.fromIterable(
      action.data.sizes,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..industryMap.addAll(Map.fromIterable(
      action.data.industries,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..timezoneMap.addAll(Map.fromIterable(
      action.data.timezones,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..dateFormatMap.addAll(Map.fromIterable(
      action.data.dateFormats,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..datetimeFormatMap.addAll(Map.fromIterable(
      action.data.datetimeFormats,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..languageMap.addAll(Map.fromIterable(
      action.data.languages,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..paymentTypeMap.addAll(Map.fromIterable(
      action.data.paymentTypes,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..countryMap.addAll(Map.fromIterable(
      action.data.countries,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..invoiceStatusMap.addAll(Map.fromIterable(
      action.data.invoiceStatus,
      key: (item) => item.id,
      value: (item) => item,
    ))
    ..frequencyMap.addAll(Map.fromIterable(
      action.data.frequencies,
      key: (item) => item.id,
      value: (item) => item,
    ))
  );
}

