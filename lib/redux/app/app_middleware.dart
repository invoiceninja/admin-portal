import 'dart:async';

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
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
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

  final dataLoaded = _createDataLoaded();

  final persistData = _createPersistData(company1Repository, company2Repository,
      company3Repository, company4Repository, company5Repository);

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

  return [
    TypedMiddleware<AppState, UserLogout>(deleteState),
    TypedMiddleware<AppState, LoadStateRequest>(loadState),
    TypedMiddleware<AppState, UserLoginSuccess>(userLoggedIn),
    TypedMiddleware<AppState, LoadDataSuccess>(dataLoaded),
    TypedMiddleware<AppState, PersistData>(persistData),
    TypedMiddleware<AppState, PersistUI>(persistUI),
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
  CompanyState company1State;
  CompanyState company2State;
  CompanyState company3State;
  CompanyState company4State;
  CompanyState company5State;

  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
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

      if (uiState.currentRoute != LoginScreen.route &&
          authState.url.isNotEmpty) {
        final NavigatorState navigator = Navigator.of(action.context);
        bool isFirst = true;
        _getRoutes(appState).forEach((route) {
          if (isFirst) {
            navigator.pushReplacementNamed(route);
          } else {
            navigator.pushNamed(route);
          }
          isFirst = false;
        });
      }
    } catch (error) {
      print(error);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(getKeychainTokenKey()) ?? '';

      if (token.isNotEmpty) {
        final Completer<Null> completer = Completer<Null>();
        completer.future.then((_) {
          store.dispatch(ViewDashboard(action.context));
        }).catchError((Object error) {
          store.dispatch(UserLogout());
          store.dispatch(LoadUserLogin(action.context));
        });
        store.dispatch(RefreshData(
          platform: getPlatform(action.context),
          completer: completer,
        ));
      } else {
        store.dispatch(UserLogout());
        store.dispatch(LoadUserLogin(action.context));
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
      if (!['dashboard', 'settings'].contains(part) && entityType == null) {
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    uiRepository.saveUIState(store.state.uiState);
  };
}

Middleware<AppState> _createDataLoaded() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final dynamic data = action.loginResponse;
    store.dispatch(LoadStaticSuccess(data.static));

    for (int i = 0; i < data.accounts.length; i++) {
      final CompanyEntity company = data.accounts[i];

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(getKeychainTokenKey(i), company.token);

      store.dispatch(SelectCompany(i + 1, company));
      store.dispatch(LoadCompanySuccess(company));
    }

    store.dispatch(SelectCompany(1, data.accounts[0]));
    store.dispatch(UserLoginSuccess());

    action.completer.complete(null);
  };
}

Middleware<AppState> _createPersistData(
  PersistenceRepository company1Repository,
  PersistenceRepository company2Repository,
  PersistenceRepository company3Repository,
  PersistenceRepository company4Repository,
  PersistenceRepository company5Repository,
) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    // first process the action so the data is in the state
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    authRepository.delete();
    uiRepository.delete();
    staticRepository.delete();
    company1Repository.delete();
    company2Repository.delete();
    company3Repository.delete();
    company4Repository.delete();
    company5Repository.delete();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i=0; i<5; i++) {
      prefs.setString(getKeychainTokenKey(i), '');
    }

    next(action);
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
