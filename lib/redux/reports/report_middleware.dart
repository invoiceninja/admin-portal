import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/reports/report_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

List<Middleware<AppState>> createStoreReportsMiddleware() {

  final viewReports = _viewReports();

  return [
    TypedMiddleware<AppState, ViewReports>(viewReports),
  ];
}

Middleware<AppState> _viewReports() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewReports;
    final uiState = store.state.uiState;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    final route = ReportsScreen.route;

    next(action);

    store.dispatch(UpdateCurrentRoute(route));

    if (isMobile(action.context)) {
      if (action.report == null) {
        Navigator.of(action.context).pushNamedAndRemoveUntil(
            ReportsScreen.route, (Route<dynamic> route) => false);
      } else {
        Navigator.of(action.context).pushNamed(route);
      }
    }
  };
}

