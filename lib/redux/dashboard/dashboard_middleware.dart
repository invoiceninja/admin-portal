import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/data/repositories/dashboard_repository.dart';

List<Middleware<AppState>> createStoreDashboardMiddleware([
  DashboardRepository repository = const DashboardRepository(),
]) {
  final loadDashboard = _createLoadDashboard(repository);

  return [
    TypedMiddleware<AppState, LoadDashboardAction>(loadDashboard),
  ];
}

Middleware<AppState> _createLoadDashboard(DashboardRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    if (! store.state.dashboardState.isStale && ! action.force) {
      next(action);
      return;
    }

    if (store.state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadDashboardRequest());
    repository.loadItem(store.state.selectedCompany, store.state.authState).then(
            (data) {
              store.dispatch(LoadDashboardSuccess(data));
              if (action.completer != null) {
                action.completer.complete(null);
              }
              if (store.state.productState.isStale) {
                store.dispatch(LoadProductsAction());
              }
            }
    ).catchError((error) => store.dispatch(LoadDashboardFailure(error)));

    next(action);
  };
}
