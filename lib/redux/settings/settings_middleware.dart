import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/repositories/settings_repository.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
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
  final saveAuthUser = _saveAuthUser(repository);
  final saveSettings = _saveSettings(repository);
  final uploadLogo = _uploadLogo(repository);

  return [
    TypedMiddleware<AppState, ViewSettings>(viewSettings),
    TypedMiddleware<AppState, SaveCompanyRequest>(saveCompany),
    TypedMiddleware<AppState, SaveAuthUserRequest>(saveAuthUser),
    TypedMiddleware<AppState, SaveUserSettingsRequest>(saveSettings),
    TypedMiddleware<AppState, UploadLogoRequest>(uploadLogo),
  ];
}

Middleware<AppState> _viewSettings() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewSettings;
    final uiState = store.state.uiState;

    checkForChanges(
        store: store,
        context: action.context,
        force: action.force,
        callback: () {
          String route = SettingsScreen.route;

          if (action.section != null) {
            route += '/${action.section}';
          } else if (uiState.mainRoute == kSettings) {
            route += '/$kSettingsCompanyDetails';
          } else {
            route += '/${uiState.settingsUIState.section}';
          }

          next(action);

          if (store.state.isStale) {
            store.dispatch(RefreshData());
          }

          store.dispatch(UpdateCurrentRoute(route));

          if (isMobile(action.context)) {
            if (action.section == null) {
              Navigator.of(action.context).pushNamedAndRemoveUntil(
                  SettingsScreen.route, (Route<dynamic> route) => false);
            } else {
              Navigator.of(action.context).pushNamed(route);
            }
          }
        });
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

Middleware<AppState> _saveAuthUser(SettingsRepository settingsRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveAuthUserRequest;

    settingsRepository
        .saveAuthUser(store.state.credentials, action.user, action.password)
        .then((user) {
      store.dispatch(SaveAuthUserSuccess(user));
      store.dispatch(UserVerifiedPassword());
      action.completer.complete();
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveAuthUserFailure(error));
      if ('$error'.contains('412')) {
        store.dispatch(UserUnverifiedPassword());
      }
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveSettings(SettingsRepository settingsRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveUserSettingsRequest;

    settingsRepository
        .saveUserSettings(store.state.credentials, action.user)
        .then((userCompany) {
      store.dispatch(SaveUserSettingsSuccess(userCompany));
      action.completer.complete();
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveUserSettingsFailure(error));
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
        ? state.company.id
        : action.type == EntityType.group
            ? settingsState.group.id
            : settingsState.client.id;
    settingsRepository
        .uploadLogo(store.state.credentials, entityId, action.multipartFile,
            action.type)
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
