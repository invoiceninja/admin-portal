// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/utils/widgets.dart';

// Package imports:
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/file_storage.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/repositories/persistence_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/main_screen.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

// ignore: unused_import
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

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
  List<PersistenceRepository> companyRepositories = const [
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_0',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_1',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_2',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_3',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_4',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_5',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_6',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_7',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_8',
        getApplicationDocumentsDirectory,
      ),
    ),
    const PersistenceRepository(
      fileStorage: const FileStorage(
        'company_state_9',
        getApplicationDocumentsDirectory,
      ),
    ),
  ],
]) {
  final loadState = _createLoadState(
    authRepository,
    uiRepository,
    staticRepository,
    companyRepositories,
  );

  final accountLoaded = _createAccountLoaded();
  final dataRefreshed = _createDataRefreshed();

  final persistData = _createPersistData(
    companyRepositories,
  );

  final persistStatic = _createPersistStatic(staticRepository);

  final userLoggedIn = _createUserLoggedIn(
    authRepository,
    uiRepository,
    staticRepository,
    companyRepositories,
  );

  final persistUI = _createPersistUI(uiRepository);

  final persistPrefs = _createPersistPrefs();

  final clearDataState = _createClearData(companyRepositories);

  final deleteState = _createDeleteState(
    authRepository,
    uiRepository,
    staticRepository,
    companyRepositories,
  );

  final viewMainScreen = _createViewMainScreen();

  return [
    TypedMiddleware<AppState, UserLogout>(deleteState),
    TypedMiddleware<AppState, LoadStateRequest>(loadState),
    TypedMiddleware<AppState, UserLoginSuccess>(userLoggedIn),
    TypedMiddleware<AppState, LoadAccountSuccess>(accountLoaded),
    TypedMiddleware<AppState, RefreshDataSuccess>(dataRefreshed),
    TypedMiddleware<AppState, PersistData>(persistData),
    TypedMiddleware<AppState, PersistStatic>(persistStatic),
    TypedMiddleware<AppState, PersistUI>(persistUI),
    TypedMiddleware<AppState, PersistPrefs>(persistPrefs),
    TypedMiddleware<AppState, ViewMainScreen>(viewMainScreen),
    TypedMiddleware<AppState, ClearPersistedData>(clearDataState),
  ];
}

Middleware<AppState> _createLoadState(
  PersistenceRepository authRepository,
  PersistenceRepository uiRepository,
  PersistenceRepository staticRepository,
  List<PersistenceRepository> companyRepositories,
) {
  AuthState? authState;
  UIState? uiState;
  StaticState? staticState;
  final List<UserCompanyState?> companyStates = [];

  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as LoadStateRequest?;

    try {
      final state = store.state;
      final prefState = state.prefState;

      authState = await authRepository.loadAuthState();
      uiState = await uiRepository.loadUIState();
      staticState = await staticRepository.loadStaticState();

      for (var i = 0; i < companyRepositories.length; i++) {
        UserCompanyState? companyState = UserCompanyState(state.reportErrors);
        try {
          companyState = await companyRepositories[i].loadCompanyState(i);
        } catch (e) {
          // do nothing
        }
        companyStates.add(companyState);
      }

      // Carry over a deeplink URL on the web
      if (state.uiState.currentRoute != LoginScreen.route) {
        uiState = uiState!
            .rebuild((b) => b..currentRoute = state.uiState.currentRoute);
      }

      final AppState appState = AppState(
              prefState: prefState,
              isWhiteLabeled: store.state.isWhiteLabeled,
              reportErrors: store.state.account.reportErrors)
          .rebuild((b) => b
            ..authState.replace(authState!)
            ..uiState.replace(uiState!)
            ..staticState.replace(staticState!)
            ..userCompanyStates.replace(companyStates));

      AppBuilder.of(navigatorKey.currentContext!)!.rebuild();
      store.dispatch(LoadStateSuccess(appState));
      store.dispatch(RefreshData(
          completer: Completer<Null>()
            ..future.then<Null>((_) {
              AppBuilder.of(navigatorKey.currentContext!)!.rebuild();
              store.dispatch(UpdatedSetting());
            })));

      if (uiState!.currentRoute != LoginScreen.route &&
          uiState!.currentRoute.isNotEmpty) {
        final NavigatorState? navigator = navigatorKey.currentState;
        final routes = _getRoutes(appState);
        if (appState.prefState.appLayout == AppLayout.mobile) {
          bool isFirst = true;
          routes.forEach((route) {
            if (isFirst) {
              navigator!.pushReplacementNamed(route);
            } else {
              navigator!.pushNamed(route);
            }
            isFirst = false;
          });
        } else {
          if (routes.isEmpty || routes.last == DashboardScreenBuilder.route) {
            store.dispatch(ViewDashboard());
          } else {
            store.dispatch(UpdateCurrentRoute(routes.last));
          }

          store.dispatch(ViewMainScreen());
        }
      } else {
        throw 'Unknown page: ${uiState!.currentRoute}';
      }
    } catch (error) {
      print('## ERROR (app_middleware - load state): $error');

      String? token;

      if (Config.DEMO_MODE ||
          cleanApiUrl(store.state.authState.url) == kFlutterDemoUrl) {
        token = 'TOKEN';
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        token = prefs.getString(kSharedPrefToken) ?? '';

        if (token.isNotEmpty) {
          token = TokenEntity.unobscureToken(token);
        }
      }

      if (token!.isNotEmpty) {
        if (calculateLayout(navigatorKey.currentContext!) == AppLayout.mobile) {
          store.dispatch(UpdateUserPreferences(appLayout: AppLayout.mobile));
        } else {
          store.dispatch(ViewMainScreen());
        }
        WidgetsBinding.instance.addPostFrameCallback((duration) {
          store.dispatch(ViewDashboard());
        });
        AppBuilder.of(navigatorKey.currentContext!)!.rebuild();
      } else {
        store.dispatch(UserLogout());
      }
    }

    next(action);
  };
}

List<String> _getRoutes(AppState state) {
  final List<String> routes = [];
  var route = '';
  EntityType? entityType;

  state.uiState.currentRoute
      .split('/')
      .where((part) => part.isNotEmpty)
      .forEach((part) {
    if (part == 'edit') {
      // Only restore new unsaved entities to prevent conflicts
      final bool isNew = state.getUIState(entityType)?.isCreatingNew ?? false;
      if (isNew) {
        route += '/edit';
      }
    } else if (part == 'view') {
      // do nothing
    } else {
      if (![kMain, kDashboard, kSettings].contains(part) &&
          entityType == null) {
        try {
          entityType = EntityType.valueOf(part);
        } catch (e) {
          // do nothing
        }
      }

      if (part != 'pdf' && part != 'email') {
        route += '/' + part;
      }
    }

    routes.add(route);
  });

  return routes;
}

Middleware<AppState> _createUserLoggedIn(
  PersistenceRepository authRepository,
  PersistenceRepository uiRepository,
  PersistenceRepository staticRepository,
  List<PersistenceRepository> companyRepositories,
) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserLoginSuccess?;

    next(action);

    final state = store.state;
    authRepository.saveAuthState(state.authState);
    uiRepository.saveUIState(state.uiState);
    staticRepository.saveStaticState(state.staticState);

    if (state.prefState.persistData) {
      for (var i = 0; i < state.userCompanyStates.length; i++) {
        companyRepositories[i].saveCompanyState(state.userCompanyStates[i]);
      }
    }
  };
}

Middleware<AppState> _createPersistData(
  List<PersistenceRepository> companyRepositories,
) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistData?;

    next(action);

    final state = store.state;
    final index = state.uiState.selectedCompanyIndex;
    final companyState = state.userCompanyStates[index];

    if (state.prefState.persistData) {
      companyRepositories[index].saveCompanyState(companyState);
    }
  };
}

final _persistUIDebouncer = PersistDebouncer();
Middleware<AppState> _createPersistUI(PersistenceRepository uiRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistUI?;

    next(action);

    _persistUIDebouncer.run(() {
      uiRepository.saveUIState(store.state.uiState);
    });
  };
}

Middleware<AppState> _createPersistPrefs() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistPrefs?;

    next(action);

    final string =
        serializers.serializeWith(PrefState.serializer, store.state.prefState);

    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(kSharedPrefs, json.encode(string)));
  };
}

Middleware<AppState> _createAccountLoaded() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as LoadAccountSuccess;
    final response = action.loginResponse;
    final loadedStaticData = response.static.currencies.isNotEmpty;

    if (loadedStaticData) {
      store.dispatch(LoadStaticSuccess(data: response.static));
    }

    int selectedCompanyIndex = 0;

    try {
      print('## Account Loaded: ${response.userCompanies.length}');
      for (int i = 0;
          i < min(response.userCompanies.length, kMaxNumberOfCompanies);
          i++) {
        final UserCompanyEntity userCompany = response.userCompanies[i];

        if (i == 0) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(kSharedPrefToken, userCompany.token.obscuredToken);
        }

        store.dispatch(
            SelectCompany(companyIndex: i, clearSelection: loadedStaticData));
        store.dispatch(LoadCompanySuccess(userCompany));

        if (store.state.account.defaultCompanyId == userCompany.company.id) {
          selectedCompanyIndex = i;
        }
      }
    } catch (error) {
      action.completer.completeError(error);
      rethrow;
    }

    store.dispatch(SelectCompany(
        companyIndex: selectedCompanyIndex, clearSelection: loadedStaticData));
    store.dispatch(UserLoginSuccess());

    if (!store.state.userCompanyState.isLoaded &&
        response.userCompanies.isNotEmpty && // TODO remove this check
        response.userCompanies.length > selectedCompanyIndex &&
        response.userCompanies[selectedCompanyIndex].company.isLarge) {
      store.dispatch(LoadClients());
    }

    action.completer.complete(null);

    next(action);

    WidgetUtils.updateData();
  };
}

Middleware<AppState> _createDataRefreshed() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as RefreshDataSuccess;
    final response = action.data!;
    final loadedStaticData = response.static.currencies.isNotEmpty;
    final state = store.state;
    final selectedCompanyIndex = state.uiState.selectedCompanyIndex;

    if (loadedStaticData) {
      store.dispatch(LoadStaticSuccess(data: response.static));
    }

    try {
      if (response.userCompanies.length == 1) {
        final userCompany = response.userCompanies.first;
        store.dispatch(LoadCompanySuccess(userCompany));
      } else {
        for (int i = 0;
            i < min(response.userCompanies.length, kMaxNumberOfCompanies);
            i++) {
          final UserCompanyEntity userCompany = response.userCompanies[i];

          if (i == 0) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setString(kSharedPrefToken, userCompany.token.obscuredToken);
          }

          store.dispatch(
              SelectCompany(companyIndex: i, clearSelection: loadedStaticData));
          store.dispatch(LoadCompanySuccess(userCompany));
        }

        if (store.state.uiState.selectedCompanyIndex != selectedCompanyIndex) {
          store.dispatch(SelectCompany(companyIndex: selectedCompanyIndex));
        }
      }
    } catch (error) {
      action.completer?.completeError(error);
      rethrow;
    }

    store.dispatch(PersistData());

    if (action.completer != null) {
      action.completer!.complete(null);
    }

    next(action);

    WidgetUtils.updateData();

    if (store.state.company.isLarge && !store.state.isLoaded) {
      store.dispatch(LoadClients());
    }
  };
}

Middleware<AppState> _createPersistStatic(
    PersistenceRepository staticRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistStatic?;

    // first process the action so the data is in the state
    next(action);

    staticRepository.saveStaticState(store.state.staticState);
  };
}

Middleware<AppState> _createDeleteState(
  PersistenceRepository authRepository,
  PersistenceRepository uiRepository,
  PersistenceRepository staticRepository,
  List<PersistenceRepository> companyRepositories,
) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    authRepository.delete();
    uiRepository.delete();
    staticRepository.delete();
    companyRepositories.forEach((repo) => repo.delete());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(kSharedPrefToken);
    prefs.remove(kSharedPrefUrl);

    next(action);
  };
}

Middleware<AppState> _createViewMainScreen() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewMainScreen?;

    if (store.state.uiState.currentRoute == LoginScreen.route) {
      store.dispatch(UpdateCurrentRoute(
          store.state.userCompany.canViewDashboard || store.state.isDemo
              ? DashboardScreenBuilder.route
              : ClientScreen.route));
    }

    while (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    }

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      navigatorKey.currentState!.pushNamed(MainScreen.route);
    });

    next(action);
  };
}

Middleware<AppState> _createClearData(
  List<PersistenceRepository> companyRepositories,
) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    companyRepositories.forEach((repo) => repo.delete());

    store.dispatch(PersistData());

    next(action);
  };
}
