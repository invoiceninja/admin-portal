import 'package:invoiceninja/redux/app/app_actions.dart';
import 'package:invoiceninja/redux/static/static_state.dart';
import 'package:redux/redux.dart';

Reducer<StaticState> staticReducer = combineReducers([
  TypedReducer<StaticState, LoadStaticSuccess>(staticLoadedReducer),
]);

StaticState staticLoadedReducer(StaticState staticState, LoadStaticSuccess action) {
  return StaticState().rebuild((b) => b
      ..currencies.replace(action.data.currencies)
      ..sizes.replace(action.data.sizes)
      ..industries.replace(action.data.industries)
      ..timezones.replace(action.data.timezones)
      ..dateFormats.replace(action.data.dateFormats)
      ..datetimeFormats.replace(action.data.datetimeFormats)
      ..languages.replace(action.data.languages)
      ..paymentTypes.replace(action.data.paymentTypes)
      ..countries.replace(action.data.countries)
      ..invoiceStatus.replace(action.data.invoiceStatus)
      ..frequencies.replace(action.data.frequencies)
  );
}

