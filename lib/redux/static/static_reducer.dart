import 'package:invoiceninja/data/models/models.dart';
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
    ..datetimeFormatMap.addAll(Map.fromIterable(
      action.data.datetimeFormats,
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
    ..invoiceStatusMap.addAll(Map.fromIterable(
      action.data.invoiceStatus,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
    ..frequencyMap.addAll(Map.fromIterable(
      action.data.frequencies,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    ))
  );
}

