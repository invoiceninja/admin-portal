import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, UserLoginRequest>(_setLoading),
  TypedReducer<bool, UserLoginSuccess>(_setLoaded),
  TypedReducer<bool, UserLoginFailure>(_setLoaded),

  TypedReducer<bool, LoadDashboardAction>(_setLoading),
  TypedReducer<bool, DashboardLoadedAction>(_setLoaded),
  TypedReducer<bool, DashboardNotLoadedAction>(_setLoaded),

  TypedReducer<bool, LoadProductsAction>(_setLoading),
  TypedReducer<bool, ProductsLoadedAction>(_setLoaded),
  TypedReducer<bool, ProductsNotLoadedAction>(_setLoaded),
]);

bool _setLoading(bool state, action) {
  return true;
}

bool _setLoaded(bool state, action) {
  return false;
}

