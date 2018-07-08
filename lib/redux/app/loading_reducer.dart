import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, StartLoading>(_setLoading),
  TypedReducer<bool, StopLoading>(_setLoaded),
]);

bool _setLoading(bool state, StartLoading action) {
  return true;
}

bool _setLoaded(bool state, StopLoading action) {
  return false;
}


final savingReducer = combineReducers<bool>([
  TypedReducer<bool, StartSaving>(_setSaving),
  TypedReducer<bool, StopSaving>(_setSaved),
]);

bool _setSaving(bool state, StartSaving action) {
  return true;
}

bool _setSaved(bool state, StopSaving action) {
  return false;
}
