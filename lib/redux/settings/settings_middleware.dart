import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

List<Middleware<AppState>> createStoreSettingsMiddleware() {
  final viewSettings = _viewSettings();

  return [
    TypedMiddleware<AppState, ViewSettings>(viewSettings),
  ];
}

Middleware<AppState> _viewSettings() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    if (hasChanges(store, action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(SettingsScreen.route));

    if (isMobile(action.context)) {
      Navigator.of(action.context).pushNamedAndRemoveUntil(
          SettingsScreen.route, (Route<dynamic> route) => false);
    }
  };
}
