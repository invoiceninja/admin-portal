import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';

EntityUIState clientUIReducer(ClientUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(clientListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..editingContact
        .replace(editingContactReducer(state.editingContact, action))
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..saveCompleter = saveCompleterReducer(state.saveCompleter, action)
    ..cancelCompleter = cancelCompleterReducer(state.cancelCompleter, action));
}

final saveCompleterReducer = combineReducers<Completer<SelectableEntity>>([
  TypedReducer<Completer<SelectableEntity>, EditClient>((completer, action) {
    return action.completer;
  }),
]);

final cancelCompleterReducer = combineReducers<Completer<SelectableEntity>>([
  TypedReducer<Completer<SelectableEntity>, EditClient>((completer, action) {
    return action.cancelCompleter;
  }),
]);

final editingContactReducer = combineReducers<ContactEntity>([
  TypedReducer<ContactEntity, EditClient>((contact, action) {
    return action.contact ?? ContactEntity();
  }),
  TypedReducer<ContactEntity, EditContact>((contact, action) {
    return action.contact ?? ContactEntity();
  }),
]);

final selectedIdReducer = combineReducers<String>([
  TypedReducer<String, ViewClient>((selectedId, action) {
    return action.clientId;
  }),
  TypedReducer<String, AddClientSuccess>((selectedId, action) {
    return action.client.id;
  }),
  TypedReducer<String, FilterClientsByEntity>(
      (selectedId, action) => action.entityId == null ? selectedId : '')
]);

final editingReducer = combineReducers<ClientEntity>([
  TypedReducer<ClientEntity, SaveClientSuccess>((client, action) {
    return action.client;
  }),
  TypedReducer<ClientEntity, AddClientSuccess>((client, action) {
    return action.client;
  }),
  TypedReducer<ClientEntity, RestoreClientSuccess>((clients, action) {
    return action.clients[0];
  }),
  TypedReducer<ClientEntity, ArchiveClientSuccess>((clients, action) {
    return action.clients[0];
  }),
  TypedReducer<ClientEntity, DeleteClientSuccess>((clients, action) {
    return action.clients[0];
  }),
  TypedReducer<ClientEntity, EditClient>((client, action) {
    return action.client;
  }),
  TypedReducer<ClientEntity, UpdateClient>((client, action) {
    return action.client.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ClientEntity, AddContact>((client, action) {
    return client
        .rebuild((b) => b..contacts.add(action.contact ?? ContactEntity()));
  }),
  TypedReducer<ClientEntity, DeleteContact>((client, action) {
    return client.rebuild((b) => b..contacts.removeAt(action.index));
  }),
  TypedReducer<ClientEntity, UpdateContact>((client, action) {
    return client.rebuild((b) => b..contacts[action.index] = action.contact);
  }),
  TypedReducer<ClientEntity, ViewClient>((client, action) {
    return ClientEntity();
  }),
  TypedReducer<ClientEntity, ViewClientList>((client, action) {
    return ClientEntity();
  }),
  TypedReducer<ClientEntity, SelectCompany>((client, action) {
    return ClientEntity();
  }),
  TypedReducer<ClientEntity, DiscardChanges>((client, action) {
    return ClientEntity();
  }),
]);

final clientListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortClients>(_sortClients),
  TypedReducer<ListUIState, FilterClientsByState>(_filterClientsByState),
  TypedReducer<ListUIState, FilterClients>(_filterClients),
  TypedReducer<ListUIState, FilterClientsByEntity>(_filterClientsByEntity),
  TypedReducer<ListUIState, FilterClientsByCustom1>(_filterClientsByCustom1),
  TypedReducer<ListUIState, FilterClientsByCustom2>(_filterClientsByCustom2),
  TypedReducer<ListUIState, StartClientMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToClientMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromClientMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearClientMultiselect>(_clearListMultiselect),
]);

ListUIState _filterClientsByCustom1(
    ListUIState clientListState, FilterClientsByCustom1 action) {
  if (clientListState.custom1Filters.contains(action.value)) {
    return clientListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return clientListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterClientsByCustom2(
    ListUIState clientListState, FilterClientsByCustom2 action) {
  if (clientListState.custom2Filters.contains(action.value)) {
    return clientListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return clientListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterClientsByState(
    ListUIState clientListState, FilterClientsByState action) {
  if (clientListState.stateFilters.contains(action.state)) {
    return clientListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return clientListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterClientsByEntity(
    ListUIState invoiceListState, FilterClientsByEntity action) {
  return invoiceListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterClients(ListUIState clientListState, FilterClients action) {
  return clientListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : clientListState.filterClearedAt);
}

ListUIState _sortClients(ListUIState clientListState, SortClients action) {
  return clientListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState clientListState, StartClientMultiselect action) {
  return clientListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState clientListState, AddToClientMultiselect action) {
  return clientListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState clientListState, RemoveFromClientMultiselect action) {
  return clientListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState clientListState, ClearClientMultiselect action) {
  return clientListState.rebuild((b) => b..selectedIds = null);
}

final clientsReducer = combineReducers<ClientState>([
  TypedReducer<ClientState, SaveClientSuccess>(_updateClient),
  TypedReducer<ClientState, AddClientSuccess>(_addClient),
  TypedReducer<ClientState, LoadClientsSuccess>(_setLoadedClients),
  TypedReducer<ClientState, LoadClientSuccess>(_setLoadedClient),
  TypedReducer<ClientState, ArchiveClientRequest>(_archiveClientRequest),
  TypedReducer<ClientState, ArchiveClientSuccess>(_archiveClientSuccess),
  TypedReducer<ClientState, ArchiveClientFailure>(_archiveClientFailure),
  TypedReducer<ClientState, DeleteClientRequest>(_deleteClientRequest),
  TypedReducer<ClientState, DeleteClientSuccess>(_deleteClientSuccess),
  TypedReducer<ClientState, DeleteClientFailure>(_deleteClientFailure),
  TypedReducer<ClientState, RestoreClientRequest>(_restoreClientRequest),
  TypedReducer<ClientState, RestoreClientSuccess>(_restoreClientSuccess),
  TypedReducer<ClientState, RestoreClientFailure>(_restoreClientFailure),
]);

ClientState _archiveClientRequest(
    ClientState clientState, ArchiveClientRequest action) {
  final clients = action.clientIds.map((id) => clientState.map[id]).toList();

  for (int i = 0; i < clients.length; i++) {
    clients[i] = clients[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return clientState.rebuild((b) {
    for (final client in clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _archiveClientSuccess(
    ClientState clientState, ArchiveClientSuccess action) {
  return clientState.rebuild((b) {
    for (final client in action.clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _archiveClientFailure(
    ClientState clientState, ArchiveClientFailure action) {
  return clientState.rebuild((b) {
    for (final client in action.clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _deleteClientRequest(
    ClientState clientState, DeleteClientRequest action) {
  final clients = action.clientIds.map((id) => clientState.map[id]).toList();

  for (int i = 0; i < clients.length; i++) {
    clients[i] = clients[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return clientState.rebuild((b) {
    for (final client in clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _deleteClientSuccess(
    ClientState clientState, DeleteClientSuccess action) {
  return clientState.rebuild((b) {
    for (final client in action.clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _deleteClientFailure(
    ClientState clientState, DeleteClientFailure action) {
  return clientState.rebuild((b) {
    for (final client in action.clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _restoreClientRequest(
    ClientState clientState, RestoreClientRequest action) {
  final clients = action.clientIds.map((id) => clientState.map[id]).toList();

  for (int i = 0; i < clients.length; i++) {
    clients[i] = clients[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return clientState.rebuild((b) {
    for (final client in clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _restoreClientSuccess(
    ClientState clientState, RestoreClientSuccess action) {
  return clientState.rebuild((b) {
    for (final client in action.clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _restoreClientFailure(
    ClientState clientState, RestoreClientFailure action) {
  return clientState.rebuild((b) {
    for (final client in action.clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _addClient(ClientState clientState, AddClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
    ..list.add(action.client.id));
}

ClientState _updateClient(ClientState clientState, SaveClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client.rebuild((b) =>
        b..lastUpdatedActivities = DateTime.now().millisecondsSinceEpoch));
}

ClientState _setLoadedClient(
    ClientState clientState, LoadClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client.rebuild((b) =>
        b..lastUpdatedActivities = DateTime.now().millisecondsSinceEpoch));
}

ClientState _setLoadedClients(
    ClientState clientState, LoadClientsSuccess action) {
  final state = clientState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
