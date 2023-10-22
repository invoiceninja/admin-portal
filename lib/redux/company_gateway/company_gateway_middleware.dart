// Dart imports:
import 'dart:developer' as dev;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/company_gateway_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_screen.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view_vm.dart';

List<Middleware<AppState>> createStoreCompanyGatewaysMiddleware([
  CompanyGatewayRepository repository = const CompanyGatewayRepository(),
]) {
  final viewCompanyGatewayList = _viewCompanyGatewayList();
  final viewCompanyGateway = _viewCompanyGateway();
  final editCompanyGateway = _editCompanyGateway();
  final loadCompanyGateways = _loadCompanyGateways(repository);
  final loadCompanyGateway = _loadCompanyGateway(repository);
  final saveCompanyGateway = _saveCompanyGateway(repository);
  final archiveCompanyGateway = _archiveCompanyGateway(repository);
  final deleteCompanyGateway = _deleteCompanyGateway(repository);
  final restoreCompanyGateway = _restoreCompanyGateway(repository);
  final disconnectCompanyGateway = _disconnectCompanyGateway(repository);

  return [
    TypedMiddleware<AppState, ViewCompanyGatewayList>(viewCompanyGatewayList),
    TypedMiddleware<AppState, ViewCompanyGateway>(viewCompanyGateway),
    TypedMiddleware<AppState, EditCompanyGateway>(editCompanyGateway),
    TypedMiddleware<AppState, LoadCompanyGateways>(loadCompanyGateways),
    TypedMiddleware<AppState, LoadCompanyGateway>(loadCompanyGateway),
    TypedMiddleware<AppState, SaveCompanyGatewayRequest>(saveCompanyGateway),
    TypedMiddleware<AppState, ArchiveCompanyGatewayRequest>(
        archiveCompanyGateway),
    TypedMiddleware<AppState, DeleteCompanyGatewayRequest>(
        deleteCompanyGateway),
    TypedMiddleware<AppState, RestoreCompanyGatewayRequest>(
        restoreCompanyGateway),
    TypedMiddleware<AppState, DisconnectCompanyGatewayRequest>(
        disconnectCompanyGateway),
  ];
}

Middleware<AppState> _editCompanyGateway() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditCompanyGateway?;

    next(action);

    store.dispatch(UpdateCurrentRoute(CompanyGatewayEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(CompanyGatewayEditScreen.route);
    }
  };
}

Middleware<AppState> _viewCompanyGateway() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewCompanyGateway?;

    next(action);

    store.dispatch(UpdateCurrentRoute(CompanyGatewayViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(CompanyGatewayViewScreen.route);
    }
  };
}

Middleware<AppState> _viewCompanyGatewayList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewCompanyGatewayList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(CompanyGatewayScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          CompanyGatewayScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveCompanyGateway(
    CompanyGatewayRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveCompanyGatewayRequest;
    final prevCompanyGateways = action.companyGatewayIds
        .map((id) => store.state.companyGatewayState.map[id])
        .toList();

    repository
        .bulkAction(store.state.credentials, action.companyGatewayIds,
            EntityAction.archive)
        .then((List<CompanyGatewayEntity> companyGateways) {
      store.dispatch(ArchiveCompanyGatewaySuccess(companyGateways));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveCompanyGatewayFailure(prevCompanyGateways));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteCompanyGateway(
    CompanyGatewayRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteCompanyGatewayRequest;
    final prevCompanyGateways = action.companyGatewayIds
        .map((id) => store.state.companyGatewayState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.companyGatewayIds,
            EntityAction.delete)
        .then((List<CompanyGatewayEntity> companyGateways) {
      store.dispatch(DeleteCompanyGatewaySuccess(companyGateways));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteCompanyGatewayFailure(prevCompanyGateways));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreCompanyGateway(
    CompanyGatewayRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreCompanyGatewayRequest;
    final prevCompanyGateways = action.companyGatewayIds
        .map((id) => store.state.companyGatewayState.map[id])
        .toList();

    repository
        .bulkAction(store.state.credentials, action.companyGatewayIds,
            EntityAction.restore)
        .then((List<CompanyGatewayEntity> companyGateways) {
      store.dispatch(RestoreCompanyGatewaySuccess(companyGateways));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreCompanyGatewayFailure(prevCompanyGateways));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _disconnectCompanyGateway(
    CompanyGatewayRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DisconnectCompanyGatewayRequest;
    repository
        .disconnect(store.state.credentials, action.companyGatewayId,
            action.password, action.idToken)
        .then((_) {
      store.dispatch(DisconnectCompanyGatewaySuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DisconnectCompanyGatewayFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveCompanyGateway(CompanyGatewayRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveCompanyGatewayRequest;
    repository
        .saveData(store.state.credentials, action.companyGateway!)
        .then((CompanyGatewayEntity companyGateway) {
      if (action.companyGateway!.isNew) {
        store.dispatch(AddCompanyGatewaySuccess(companyGateway));
      } else {
        store.dispatch(SaveCompanyGatewaySuccess(companyGateway));
      }
      action.completer!.complete(companyGateway);
    }).catchError((Object error) {
      print(error);
      dev.log(
        'Failed to save company gateway',
        name: 'company_gateway_middleware',
        stackTrace: StackTrace.current,
        error: error,
      );
      store.dispatch(SaveCompanyGatewayFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadCompanyGateway(CompanyGatewayRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadCompanyGateway;
    final AppState state = store.state;

    store.dispatch(LoadCompanyGatewayRequest());
    repository
        .loadItem(state.credentials, action.companyGatewayId)
        .then((companyGateway) {
      store.dispatch(LoadCompanyGatewaySuccess(companyGateway));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadCompanyGatewayFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadCompanyGateways(CompanyGatewayRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadCompanyGateways?;
    final AppState state = store.state;

    store.dispatch(LoadCompanyGatewaysRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadCompanyGatewaysSuccess(data));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
      /*
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadCompanyGatewaysFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
