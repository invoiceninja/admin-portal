import 'package:flutter/widgets.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/ui/client/view/client_view_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/data/repositories/client_repository.dart';

List<Middleware<AppState>> createStoreClientsMiddleware([
  ClientRepository repository = const ClientRepository(),
]) {
  final viewClientList = _viewClientList();
  final viewClient = _viewClient();
  final editClient = _editClient();
  final loadClients = _loadClients(repository);
  final saveClient = _saveClient(repository);
  final archiveClient = _archiveClient(repository);
  final deleteClient = _deleteClient(repository);
  final restoreClient = _restoreClient(repository);

  return [
    TypedMiddleware<AppState, ViewClientList>(viewClientList),
    TypedMiddleware<AppState, ViewClient>(viewClient),
    TypedMiddleware<AppState, EditClient>(editClient),
    TypedMiddleware<AppState, LoadClients>(loadClients),
    TypedMiddleware<AppState, SaveClientRequest>(saveClient),
    TypedMiddleware<AppState, ArchiveClientRequest>(archiveClient),
    TypedMiddleware<AppState, DeleteClientRequest>(deleteClient),
    TypedMiddleware<AppState, RestoreClientRequest>(restoreClient),
  ];
}

Middleware<AppState> _editClient() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(ClientEditScreen.route));
    Navigator.of(action.context).pushNamed(ClientEditScreen.route);
  };
}

Middleware<AppState> _viewClient() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(ClientViewScreen.route));
    Navigator.of(action.context).pushNamed(ClientViewScreen.route);
  };
}

Middleware<AppState> _viewClientList() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(ClientScreen.route));
    Navigator.of(action.context).pushReplacementNamed(ClientScreen.route);
  };
}

Middleware<AppState> _archiveClient(ClientRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    var origClient = store.state.clientState.map[action.clientId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origClient, EntityAction.archive)
        .then((dynamic client) {
      store.dispatch(ArchiveClientSuccess(client));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveClientFailure(origClient));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteClient(ClientRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    var origClient = store.state.clientState.map[action.clientId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origClient, EntityAction.delete)
        .then((dynamic client) {
      store.dispatch(DeleteClientSuccess(client));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteClientFailure(origClient));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreClient(ClientRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origClient = store.state.clientState.map[action.clientId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origClient, EntityAction.restore)
        .then((dynamic client) {
      store.dispatch(RestoreClientSuccess(client));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreClientFailure(origClient));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveClient(ClientRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository
        .saveData(
            store.state.selectedCompany, store.state.authState, action.client)
        .then((dynamic client) {
      if (action.client.isNew()) {
        store.dispatch(AddClientSuccess(client));
      } else {
        store.dispatch(SaveClientSuccess(client));
      }
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveClientFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadClients(ClientRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {

    AppState state = store.state;

    if (!state.clientState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadClientsRequest());
    repository
        .loadList(state.selectedCompany, state.authState)
        .then((data) {
      store.dispatch(LoadClientsSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadClientsFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
