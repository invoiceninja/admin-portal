import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, DashboardLoadedAction>(_setLoaded),
  TypedReducer<bool, DashboardNotLoadedAction>(_setLoaded),
  TypedReducer<bool, ProductsLoadedAction>(_setLoaded),
  TypedReducer<bool, ProductsNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
