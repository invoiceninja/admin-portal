import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/file_storage.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/persistence_repository.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/main_screen.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> createStorePersistenceMiddleware([
  PersistenceRepository authRepository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'auth_state',
      getApplicationDocumentsDirectory,
    ),
  ),
  PersistenceRepository uiRepository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'ui_state',
      getApplicationDocumentsDirectory,
    ),
  ),
  PersistenceRepository staticRepository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'static_state',
      getApplicationDocumentsDirectory,
    ),
  ),
  PersistenceRepository company1Repository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'company1_state',
      getApplicationDocumentsDirectory,
    ),
  ),
  PersistenceRepository company2Repository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'company2_state',
      getApplicationDocumentsDirectory,
    ),
  ),
  PersistenceRepository company3Repository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'company3_state',
      getApplicationDocumentsDirectory,
    ),
  ),
  PersistenceRepository company4Repository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'company4_state',
      getApplicationDocumentsDirectory,
    ),
  ),
  PersistenceRepository company5Repository = const PersistenceRepository(
    fileStorage: const FileStorage(
      'company5_state',
      getApplicationDocumentsDirectory,
    ),
  ),
]) {
  final loadState = _createLoadState(
      authRepository,
      uiRepository,
      staticRepository,
      company1Repository,
      company2Repository,
      company3Repository,
      company4Repository,
      company5Repository);

  final accountLoaded = _createAccountLoaded();

  final persistData = _createPersistData(company1Repository, company2Repository,
      company3Repository, company4Repository, company5Repository);

  final persistStatic = _createPersistStatic(staticRepository);

  final userLoggedIn = _createUserLoggedIn(
      authRepository,
      uiRepository,
      staticRepository,
      company1Repository,
      company2Repository,
      company3Repository,
      company4Repository,
      company5Repository);

  final persistUI = _createPersistUI(uiRepository);

  final deleteState = _createDeleteState(
      authRepository,
      uiRepository,
      staticRepository,
      company1Repository,
      company2Repository,
      company3Repository,
      company4Repository,
      company5Repository);

  final viewMainScreen = _createViewMainScreen();

  return [
    TypedMiddleware<AppState, UserLogout>(deleteState),
    TypedMiddleware<AppState, LoadStateRequest>(loadState),
    TypedMiddleware<AppState, UserLoginSuccess>(userLoggedIn),
    TypedMiddleware<AppState, LoadAccountSuccess>(accountLoaded),
    TypedMiddleware<AppState, PersistData>(persistData),
    TypedMiddleware<AppState, PersistStatic>(persistStatic),
    TypedMiddleware<AppState, PersistUI>(persistUI),
    TypedMiddleware<AppState, ViewMainScreen>(viewMainScreen),
  ];
}

Middleware<AppState> _createLoadState(
  PersistenceRepository authRepository,
  PersistenceRepository uiRepository,
  PersistenceRepository staticRepository,
  PersistenceRepository company1Repository,
  PersistenceRepository company2Repository,
  PersistenceRepository company3Repository,
  PersistenceRepository company4Repository,
  PersistenceRepository company5Repository,
) {
  AuthState authState;
  UIState uiState;
  StaticState staticState;
  UserCompanyState company1State;
  UserCompanyState company2State;
  UserCompanyState company3State;
  UserCompanyState company4State;
  UserCompanyState company5State;

  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as LoadStateRequest;
    try {
      final prefs = await SharedPreferences.getInstance();
      final appVersion = prefs.getString(kSharedPrefAppVersion);
      prefs.setString(kSharedPrefAppVersion, kAppVersion);

      if (appVersion != kAppVersion) {
        throw 'New app version - clearing state';
      }

      authState = await authRepository.loadAuthState();
      uiState = await uiRepository.loadUIState();
      staticState = await staticRepository.loadStaticState();
      company1State = await company1Repository.loadCompanyState(1);
      company2State = await company2Repository.loadCompanyState(2);
      company3State = await company3Repository.loadCompanyState(3);
      company4State = await company4Repository.loadCompanyState(4);
      company5State = await company5Repository.loadCompanyState(5);

      final AppState appState = AppState().rebuild((b) => b
        ..authState.replace(authState)
        ..uiState.replace(uiState)
        ..staticState.replace(staticState)
        ..companyState1.replace(company1State)
        ..companyState2.replace(company2State)
        ..companyState3.replace(company3State)
        ..companyState4.replace(company4State)
        ..companyState5.replace(company5State));

      AppBuilder.of(action.context).rebuild();
      store.dispatch(LoadStateSuccess(appState));

      if (appState.staticState.isStale) {
        store.dispatch(RefreshData(
          loadCompanies: false,
          platform: getPlatform(action.context),
        ));
      }

      if (uiState.currentRoute != LoginScreen.route &&
          uiState.currentRoute.isNotEmpty) {
        final NavigatorState navigator = Navigator.of(action.context);
        final routes = _getRoutes(appState);
        if (uiState.layout == AppLayout.mobile) {
          bool isFirst = true;
          routes.forEach((route) {
            if (isFirst) {
              navigator.pushReplacementNamed(route);
            } else {
              navigator.pushNamed(route);
            }
            isFirst = false;
          });
        } else {
          store.dispatch(
              UpdateCurrentRoute(routes.isEmpty ? '/dashboard' : routes.last));
          store.dispatch(ViewMainScreen(action.context));
        }
      } else {
        throw 'Unknown page';
      }
    } catch (error) {
      print(error);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(kSharedPrefToken) ?? '';

      if (token.isNotEmpty) {
        final Completer<Null> completer = Completer<Null>();
        completer.future.then((_) {
          if (uiState.layout == AppLayout.mobile) {
            store.dispatch(ViewDashboard(context: action.context));
          } else {
            store.dispatch(ViewMainScreen(action.context));
          }
        }).catchError((Object error) {
          store.dispatch(UserLogout(action.context));
        });
        store.dispatch(RefreshData(
          platform: getPlatform(action.context),
          completer: completer,
        ));
      } else {
        store.dispatch(UserLogout(action.context));
      }
    }

    next(action);
  };
}

List<String> _getRoutes(AppState state) {
  final List<String> routes = [];
  var route = '';
  EntityType entityType;

  state.uiState.currentRoute
      .split('/')
      .where((part) => part.isNotEmpty)
      .forEach((part) {
    if (part == 'edit') {
      // Only restore new unsaved entities to prevent conflicts
      final bool isNew = state.getUIState(entityType).isCreatingNew;
      if (isNew) {
        route += '/edit';
      } else if (entityType != EntityType.product) {
        route += '/view';
      }
    } else {
      if (!['main', 'dashboard', 'settings'].contains(part) &&
          entityType == null) {
        entityType = EntityType.valueOf(part);
      }

      route += '/' + part;
    }

    routes.add(route);
  });

  return routes;
}

Middleware<AppState> _createUserLoggedIn(
  PersistenceRepository authRepository,
  PersistenceRepository uiRepository,
  PersistenceRepository staticRepository,
  PersistenceRepository company1Repository,
  PersistenceRepository company2Repository,
  PersistenceRepository company3Repository,
  PersistenceRepository company4Repository,
  PersistenceRepository company5Repository,
) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserLoginSuccess;

    next(action);

    final state = store.state;
    authRepository.saveAuthState(state.authState);
    uiRepository.saveUIState(state.uiState);
    staticRepository.saveStaticState(state.staticState);
    company1Repository.saveCompanyState(state.companyState1);
    company2Repository.saveCompanyState(state.companyState2);
    company3Repository.saveCompanyState(state.companyState3);
    company4Repository.saveCompanyState(state.companyState4);
    company5Repository.saveCompanyState(state.companyState5);
  };
}

Middleware<AppState> _createPersistUI(PersistenceRepository uiRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistUI;

    next(action);

    uiRepository.saveUIState(store.state.uiState);
  };
}

Middleware<AppState> _createAccountLoaded() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as LoadAccountSuccess;
    final response = action.loginResponse;
    store.dispatch(LoadStaticSuccess(data: response.static));

    if (action.loadCompanies) {
      for (int i = 0; i < response.userCompanies.length; i++) {
        final UserCompanyEntity userCompany = response.userCompanies[i];

        if (i == 0) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(kSharedPrefToken, userCompany.token.token);
        }

        store.dispatch(SelectCompany(i + 1, userCompany));
        store.dispatch(LoadCompanySuccess(userCompany));
      }

      store.dispatch(SelectCompany(1, response.userCompanies[0]));
      store.dispatch(UserLoginSuccess());
    }

    if (action.completer != null) {
      action.completer.complete(null);
    }
  };
}

Middleware<AppState> _createPersistStatic(
    PersistenceRepository staticRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistStatic;

    // first process the action so the data is in the state
    next(action);

    staticRepository.saveStaticState(store.state.staticState);
  };
}

Middleware<AppState> _createPersistData(
  PersistenceRepository company1Repository,
  PersistenceRepository company2Repository,
  PersistenceRepository company3Repository,
  PersistenceRepository company4Repository,
  PersistenceRepository company5Repository,
) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistData;

    next(action);

    final AppState state = store.state;

    switch (state.uiState.selectedCompanyIndex) {
      case 1:
        company1Repository.saveCompanyState(state.companyState1);
        break;
      case 2:
        company2Repository.saveCompanyState(state.companyState2);
        break;
      case 3:
        company3Repository.saveCompanyState(state.companyState3);
        break;
      case 4:
        company4Repository.saveCompanyState(state.companyState4);
        break;
      case 5:
        company5Repository.saveCompanyState(state.companyState5);
        break;
    }
  };
}

Middleware<AppState> _createDeleteState(
  PersistenceRepository authRepository,
  PersistenceRepository uiRepository,
  PersistenceRepository staticRepository,
  PersistenceRepository company1Repository,
  PersistenceRepository company2Repository,
  PersistenceRepository company3Repository,
  PersistenceRepository company4Repository,
  PersistenceRepository company5Repository,
) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    authRepository.delete();
    uiRepository.delete();
    staticRepository.delete();
    company1Repository.delete();
    company2Repository.delete();
    company3Repository.delete();
    company4Repository.delete();
    company5Repository.delete();

    final action = dynamicAction as UserLogout;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < 5; i++) {
      prefs.setString(kSharedPrefToken, '');
    }

    next(action);
  };
}

Middleware<AppState> _createViewMainScreen() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewMainScreen;

    next(action);

    if (store.state.uiState.currentRoute == LoginScreen.route) {
      store.dispatch(UpdateCurrentRoute(DashboardScreen.route));
    }

    Navigator.of(action.context).pushNamedAndRemoveUntil(
        MainScreen.route, (Route<dynamic> route) => false);
  };
}

/*
Future<bool> _checkLastLoadWasSuccesfull() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final initialized = prefs.getBool('initialized');
  prefs.setBool('initialized', false);
  return initialized;
}

void _setLastLoadWasSuccesfull() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('initialized', true);
}
*/

bool hasChanges({Store<AppState> store, BuildContext context, bool force}) {
  if (context == null) {
    print('WARNING: context is null in hasChanges');
    return false;
  } else if (force == null) {
    print('WARNING: force is null in hasChanges');
    return false;
  }

  if (store.state.hasChanges() && !isMobile(context) && !force) {
    showDialog<MessageDialog>(
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(AppLocalization.of(context).errorUnsavedChanges);
        });
    return true;
  } else {
    return false;
  }
}
