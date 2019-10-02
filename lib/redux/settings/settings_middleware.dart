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
  final saveSettings = _saveSettings();

  return [
    TypedMiddleware<AppState, ViewSettings>(viewSettings),
    TypedMiddleware<AppState, SaveSettingsRequest>(saveSettings),
  ];
}

Middleware<AppState> _viewSettings() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewSettings;

    if (hasChanges(
        store: store, context: action.context, force: action.force)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(SettingsScreen.route +
        (action.section != null ? '/${action.section}' : '/company_details')));

    if (isMobile(action.context)) {
      Navigator.of(action.context).pushNamedAndRemoveUntil(
          SettingsScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _saveSettings() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveSettingsRequest;

    next(action);
  };
}
