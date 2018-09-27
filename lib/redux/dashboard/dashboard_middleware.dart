import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/dashboard_repository.dart';

List<Middleware<AppState>> createStoreDashboardMiddleware([
  DashboardRepository repository = const DashboardRepository(),
]) {
  final viewDashboard = _createViewDashboard();
  final loadDashboard = _createLoadDashboard(repository);

  return [
    TypedMiddleware<AppState, ViewDashboard>(viewDashboard),
    TypedMiddleware<AppState, LoadDashboard>(loadDashboard),
  ];
}


Middleware<AppState> _createViewDashboard() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    store.dispatch(LoadDashboard());
    store.dispatch(UpdateCurrentRoute(DashboardScreen.route));

    if (action.context != null) {
      Navigator.of(action.context).pushNamedAndRemoveUntil(
          DashboardScreen.route, (Route<dynamic> route) => false);
    }

    next(action);
  };
}

Middleware<AppState> _createLoadDashboard(DashboardRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final state = store.state;

    if (!state.dashboardState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadDashboardRequest());
    repository.loadItem(state.selectedCompany, state.authState).then((data) {
      store.dispatch(LoadDashboardSuccess(data));
      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.clientState.isStale) {
        store.dispatch(LoadClients());
      }
    }).catchError((Object error) {
      print(error);
      if (action.completer != null) {
        action.completer.completeError(error);
      }
      store.dispatch(LoadDashboardFailure(error));
    });

    next(action);
  };
}
