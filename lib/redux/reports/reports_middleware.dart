import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

import 'package:invoiceninja_flutter/main_app.dart';

List<Middleware<AppState>> createStoreReportsMiddleware() {
  final viewReports = _viewReports();

  return [
    TypedMiddleware<AppState, ViewReports>(viewReports),
  ];
}

Middleware<AppState> _viewReports() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewReports;

    checkForChanges(
        store: store,
        context: navigatorKey.currentContext,
        force: action.force,
        callback: () {
          const route = ReportsScreen.route;

          next(action);

          store.dispatch(UpdateCurrentRoute(route));

          if (store.state.prefState.isMobile) {
            if (action.report == null) {
              navigatorKey.currentState.pushNamedAndRemoveUntil(
                  ReportsScreen.route, (Route<dynamic> route) => false);
            } else {
              navigatorKey.currentState.pushNamed(route);
            }
          }
        });
  };
}
