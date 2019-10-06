import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/repositories/settings_repository.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

List<Middleware<AppState>> createStoreSettingsMiddleware([
  SettingsRepository repository = const SettingsRepository(),
]) {
  final viewSettings = _viewSettings();
  final saveCompany = _saveCompany(repository);
  final saveUser = _saveUser(repository);
  final uploadLogo = _uploadLogo(repository);

  return [
    TypedMiddleware<AppState, ViewSettings>(viewSettings),
    TypedMiddleware<AppState, SaveCompanyRequest>(saveCompany),
    TypedMiddleware<AppState, SaveUserRequest>(saveUser),
    TypedMiddleware<AppState, UploadLogoRequest>(uploadLogo),
  ];
}

Middleware<AppState> _viewSettings() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewSettings;
    final uiState = store.state.uiState;

    if (hasChanges(
        store: store, context: action.context, force: action.force)) {
      return;
    }

    final route = SettingsScreen.route +
        (action.section != null
            ? '/${action.section}'
            : uiState.mainRoute == kSettings
                ? '/$kSettingsCompanyDetails'
                : '/${uiState.settingsUIState.section}');

    next(action);

    store.dispatch(UpdateCurrentRoute(route));

    if (isMobile(action.context)) {
      if (action.section == null) {
        Navigator.of(action.context).pushNamedAndRemoveUntil(
            SettingsScreen.route, (Route<dynamic> route) => false);
      } else {
        Navigator.of(action.context).pushNamed(route);
      }
    }
  };
}

Middleware<AppState> _saveCompany(SettingsRepository settingsRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveCompanyRequest;

    settingsRepository
        .saveCompany(store.state.credentials, action.company)
        .then((company) {
      store.dispatch(SaveCompanySuccess(company));
      action.completer.complete();
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveCompanyFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveUser(SettingsRepository settingsRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveUserRequest;

    settingsRepository
        .saveUser(store.state.credentials, action.user)
        .then((user) {
      store.dispatch(SaveUserSuccess(user));
      action.completer.complete();
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveUserFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _uploadLogo(SettingsRepository settingsRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UploadLogoRequest;

    settingsRepository
        .uploadLogo(store.state.credentials, store.state.selectedCompany.id,
            action.path)
        .then((company) {
      store.dispatch(SaveCompanySuccess(company));
      action.completer.complete();
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveCompanyFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}
