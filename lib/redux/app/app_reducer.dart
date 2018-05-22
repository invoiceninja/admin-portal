import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/app/loading_reducer.dart';
import 'package:invoiceninja/redux/auth/auth_reducer.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_reducer.dart';
import 'package:invoiceninja/redux/product/product_reducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {

  /*
  if (action is PersistLoadedAction<AppState>) {
    return action.state ?? state;
  } else {
    return new AppState(
      auth: authReducer(state.auth, action),
    );
  }
  */

  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    auth: authReducer(state.auth, action),
    dashboard: dashboardReducer(state.dashboard, action),
    products: productsReducer(state.products, action),
  );
}
