import 'package:invoiceninja/data/models/models.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/data/repositories/client_repository.dart';

List<Middleware<AppState>> createStoreClientsMiddleware([
  ClientsRepository repository = const ClientsRepository(),
]) {
  final loadClients = _loadClients(repository);
  final saveClient = _saveClient(repository);
  final archiveClient = _archiveClient(repository);
  final deleteClient = _deleteClient(repository);
  final restoreClient = _restoreClient(repository);

  return [
    TypedMiddleware<AppState, LoadClientsAction>(loadClients),
    TypedMiddleware<AppState, SaveClientRequest>(saveClient),
    TypedMiddleware<AppState, ArchiveClientRequest>(archiveClient),
    TypedMiddleware<AppState, DeleteClientRequest>(deleteClient),
    TypedMiddleware<AppState, RestoreClientRequest>(restoreClient),
  ];
}

Middleware<AppState> _archiveClient(ClientsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    var origClient = store.state.clientState().map[action.clientId];
    repository
        .saveData(store.state.selectedCompany(), store.state.authState,
        origClient, EntityAction.archive)
        .then((client) {
      store.dispatch(ArchiveClientSuccess(client));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((error) {
      print(error);
      store.dispatch(ArchiveClientFailure(origClient));
    });

    next(action);
  };
}

Middleware<AppState> _deleteClient(ClientsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    var origClient = store.state.clientState().map[action.clientId];
    repository
        .saveData(store.state.selectedCompany(), store.state.authState,
        origClient, EntityAction.delete)
        .then((client) {
      store.dispatch(DeleteClientSuccess(client));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((error) {
      print(error);
      store.dispatch(DeleteClientFailure(origClient));
    });

    next(action);
  };
}

Middleware<AppState> _restoreClient(ClientsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    var origClient = store.state.clientState().map[action.clientId];
    repository
        .saveData(store.state.selectedCompany(), store.state.authState,
        origClient, EntityAction.restore)
        .then((client) {
      store.dispatch(RestoreClientSuccess(client));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((error) {
      print(error);
      store.dispatch(RestoreClientFailure(origClient));
    });

    next(action);
  };
}

Middleware<AppState> _saveClient(ClientsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository
        .saveData(store.state.selectedCompany(), store.state.authState,
            action.client)
        .then((client) {
      if (action.client.isNew()) {
        store.dispatch(AddClientSuccess(client));
      } else {
        store.dispatch(SaveClientSuccess(client));
      }
      action.completer.complete(null);
    }).catchError((error) {
      print(error);
      store.dispatch(SaveClientFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _loadClients(ClientsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    
    if (! store.state.clientState().isStale() && ! action.force) {
      next(action);
      return;
    }

    if (store.state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadClientsRequest());
    repository
        .loadList(store.state.selectedCompany(), store.state.authState)
        .then((data) {
      store.dispatch(LoadClientsSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((error) => store.dispatch(LoadClientsFailure(error)));

    next(action);
  };
}

