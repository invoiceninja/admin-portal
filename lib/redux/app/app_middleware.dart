import 'dart:async';
import 'dart:convert';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/file_storage.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/repositories/persistence_repository.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/main_screen.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
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
    TypedMiddleware<AppState, PersistData>(persistData),
    TypedMiddleware<AppState, PersistStatic>(persistStatic),
    TypedMiddleware<AppState, PersistUI>(persistUI),
    TypedMiddleware<AppState, PersistPrefs>(persistPrefs),
    TypedMiddleware<AppState, ViewMainScreen>(viewMainScreen),
  ];
}

Middleware<AppState> _createLoadState(
  PersistenceRepository authRepository,
  PersistenceRepository uiRepository,
  PersistenceRepository staticRepository,
  List<PersistenceRepository> companyRepositories,
) {
  AuthState authState;
  UIState uiState;
  StaticState staticState;
  final List<UserCompanyState> companyStates = [];

  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as LoadStateRequest;
    try {
      if (kIsWeb) {
        throw 'Local storage not yet supported on web';
      }

      final prefs = await SharedPreferences.getInstance();
      final appVersion = prefs.getString(kSharedPrefAppVersion);
      prefs.setString(kSharedPrefAppVersion, kAppVersion);

      if (appVersion != kAppVersion) {
        throw 'New app version - clearing state';
      }

      authState = await authRepository.loadAuthState();
      uiState = await uiRepository.loadUIState();
      staticState = await staticRepository.loadStaticState();
      for (var i = 0; i < companyRepositories.length; i++) {
        companyStates.add(await companyRepositories[i].loadCompanyState(i));
      }

      final AppState appState = AppState(prefState: store.state.prefState)
          .rebuild((b) => b
            ..authState.replace(authState)
            ..uiState.replace(uiState)
            ..staticState.replace(staticState)
            ..userCompanyStates.replace(companyStates));

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
        if (appState.prefState.appLayout == AppLayout.mobile) {
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
          store.dispatch(
              ViewMainScreen(navigator: Navigator.of(action.context)));
        }
      } else {
        throw 'Unknown page';
      }
    } catch (error) {
      print('Load state error: $error');

      String token;
      if (kIsWeb) {
        token = Config.DEMO_MODE ? 'DEMO' : '';
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        token = prefs.getString(kSharedPrefToken) ?? '';
      }

      if (token.isNotEmpty) {
        final Completer<Null> completer = Completer<Null>();
        completer.future.then((_) {
          final layout = calculateLayout(action.context);
          if (store.state.prefState.isNotMobile && layout == AppLayout.mobile) {
            store.dispatch(UserSettingsChanged(layout: layout));
            store.dispatch(
                ViewDashboard(navigator: Navigator.of(action.context)));
          } else {
            store.dispatch(
                ViewMainScreen(navigator: Navigator.of(action.context)));
          }
        }).catchError((Object error) {
          print('Error (app_middleware): $error');
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
      if (![kMain, kDashboard, kSettings].contains(part) &&
          entityType == null) {
        try {
          entityType = EntityType.valueOf(part);
        } catch (e) {
          // do nothing
        }
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
  List<PersistenceRepository> companyRepositories,
) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserLoginSuccess;

    next(action);

    if (!kIsWeb) {
      final state = store.state;
      authRepository.saveAuthState(state.authState);
      uiRepository.saveUIState(state.uiState);
      staticRepository.saveStaticState(state.staticState);
      for (var i = 0; i < state.userCompanyStates.length; i++) {
        companyRepositories[i].saveCompanyState(state.userCompanyStates[i]);
      }
    }
  };
}

Middleware<AppState> _createPersistUI(PersistenceRepository uiRepository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistUI;

    next(action);

    if (kIsWeb) {
      return;
    }

    uiRepository.saveUIState(store.state.uiState);
  };
}

Middleware<AppState> _createPersistPrefs() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistPrefs;

    next(action);

    if (kIsWeb) {
      return;
    }

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

    store.dispatch(LoadStaticSuccess(data: response.static));

    if (action.loadCompanies) {
      for (int i = 0; i < response.userCompanies.length; i++) {
        final UserCompanyEntity userCompany = response.userCompanies[i];

        if (i == 0 && !kIsWeb) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(kSharedPrefToken, userCompany.token.token);
        }

        store.dispatch(SelectCompany(i, userCompany));
        store.dispatch(LoadCompanySuccess(userCompany));

        final company = userCompany.company;
        if (company.clients.isNotEmpty) {
          store.dispatch(LoadClientsSuccess(company.clients));
          store.dispatch(LoadProductsSuccess(company.products));
          store.dispatch(LoadInvoicesSuccess(company.invoices));
          store.dispatch(LoadPaymentsSuccess(company.payments));
          //store.dispatch(LoadQuotesSuccess(company.quotes));
        }
      }

      store.dispatch(SelectCompany(0, response.userCompanies[0]));
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

    if (kIsWeb) {
      return;
    }

    staticRepository.saveStaticState(store.state.staticState);
  };
}

Middleware<AppState> _createPersistData(
  List<PersistenceRepository> companyRepositories,
) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as PersistData;

    next(action);

    if (kIsWeb) {
      return;
    }

    final AppState state = store.state;
    final index = state.uiState.selectedCompanyIndex;

    companyRepositories[index].saveCompanyState(state.userCompanyStates[index]);
  };
}

Middleware<AppState> _createDeleteState(
  PersistenceRepository authRepository,
  PersistenceRepository uiRepository,
  PersistenceRepository staticRepository,
  List<PersistenceRepository> companyRepositories,
) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (kIsWeb) {
      next(action);
      return;
    }
    authRepository.delete();
    uiRepository.delete();
    staticRepository.delete();
    companyRepositories.forEach((repo) => repo.delete());

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(kSharedPrefToken, '');

    next(action);
  };
}

Middleware<AppState> _createViewMainScreen() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewMainScreen;

    next(action);

    if (store.state.uiState.currentRoute == LoginScreen.route) {
      store.dispatch(UpdateCurrentRoute(DashboardScreenBuilder.route));
    }

    if (action.addDelay) {
      while (action.navigator.canPop()) {
        action.navigator.pop();
      }
      Timer(Duration(seconds: 1), () {
        action.navigator.pushNamed(MainScreen.route);
      });
    } else {
      action.navigator.pushNamedAndRemoveUntil(
          MainScreen.route, (Route<dynamic> route) => false);
    }
  };
}

bool hasChanges({
  @required Store<AppState> store,
  @required BuildContext context,
  @required dynamic action,
}) {
  if (context == null) {
    print('WARNING: context is null in hasChanges');
    return false;
  }

  if (store.state.hasChanges() && !isMobile(context)) {
    showDialog<MessageDialog>(
        context: context,
        builder: (BuildContext dialogContext) {
          final localization = AppLocalization.of(context);

          return MessageDialog(localization.errorUnsavedChanges,
              dismissLabel: localization.continueEditing, onDiscard: () {
            store.dispatch(DiscardChanges());
            store.dispatch(ResetSettings());
            store.dispatch(action);
          });
        });
    return true;
  } else {
    return false;
  }
}
