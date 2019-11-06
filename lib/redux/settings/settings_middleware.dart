import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/repositories/settings_repository.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
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

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
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
    final state = store.state;
    final settingsState = state.uiState.settingsUIState;
    final entityId = action.type == EntityType.company
        ? state.selectedCompany.id
        : action.type == EntityType.group
            ? settingsState.group.id
            : settingsState.client.id;
    settingsRepository
        .uploadLogo(store.state.credentials, entityId, action.path, action.type)
        .then((entity) {
      if (action.type == EntityType.client) {
        store.dispatch(SaveClientSuccess(entity as ClientEntity));
      } else if (action.type == EntityType.group) {
        store.dispatch(SaveGroupSuccess(entity as GroupEntity));
      } else {
        store.dispatch(SaveCompanySuccess(entity as CompanyEntity));
      }

      action.completer.complete();
    }).catchError((Object error) {
      print(error);
      store.dispatch(UploadLogoFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}
