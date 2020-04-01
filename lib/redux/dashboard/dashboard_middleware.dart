import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

List<Middleware<AppState>> createStoreDashboardMiddleware() {
  final viewDashboard = _createViewDashboard();

  return [
    TypedMiddleware<AppState, ViewDashboard>(viewDashboard),
  ];
}

Middleware<AppState> _createViewDashboard() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewDashboard;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    /*
    if (store.state.dashboardState.isStale) {
      store.dispatch(LoadActivities());
    }
     */

    store.dispatch(UpdateCurrentRoute(DashboardScreenBuilder.route));

    if (isMobile(action.context)) {
      Navigator.of(action.context).pushNamedAndRemoveUntil(
          DashboardScreenBuilder.route, (Route<dynamic> route) => false);
    }

    next(action);
  };
}
