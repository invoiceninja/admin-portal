// Flutter imports:
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';

List<Middleware<AppState>> createStoreDashboardMiddleware() {
  final viewDashboard = _createViewDashboard();

  return [
    TypedMiddleware<AppState, ViewDashboard>(viewDashboard),
  ];
}

Middleware<AppState> _createViewDashboard() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewDashboard;

    checkForChanges(
        store: store,
        force: action.force,
        callback: () {
          final state = store.state;
          if (state.isLoaded && !state.userCompany.canViewDashboard) {
            store.dispatch(ViewClientList());
          } else {
            if (state.isStale) {
              store.dispatch(RefreshData());
            }

            store.dispatch(UpdateCurrentRoute(DashboardScreenBuilder.route));
          }

          next(action);

          if (store.state.prefState.isMobile &&
              store.state.userCompany.canViewDashboard) {
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                DashboardScreenBuilder.route, (Route<dynamic> route) => false);
          }
        });
  };
}
