import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/client/client_state.dart';

EntityUIState clientUIReducer(EntityUIState state, action) {
  return state.rebuild((b) => b
    ..listUIState.replace(clientListReducer(state.listUIState, action))
  );
}

final clientListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortClients>(_sortClients),
  TypedReducer<ListUIState, FilterClientsByState>(_filterClientsByState),
  TypedReducer<ListUIState, SearchClients>(_searchClients),
]);

ListUIState _filterClientsByState(ListUIState clientListState, FilterClientsByState action) {
  if (clientListState.stateFilters.contains(action.state)) {
    return clientListState.rebuild((b) => b
        ..stateFilters.remove(action.state)
    );
  } else {
    return clientListState.rebuild((b) => b
        ..stateFilters.add(action.state)
    );
  }
}

ListUIState _searchClients(ListUIState clientListState, SearchClients action) {
  return clientListState.rebuild((b) => b
    ..search = action.search
  );
}

ListUIState _sortClients(ListUIState clientListState, SortClients action) {
  return clientListState.rebuild((b) => b
      ..sortAscending = b.sortField != action.field || ! b.sortAscending
      ..sortField = action.field
  );
}


final clientsReducer = combineReducers<ClientState>([
  TypedReducer<ClientState, SaveClientSuccess>(_updateClient),
  TypedReducer<ClientState, AddClientSuccess>(_addClient),
  TypedReducer<ClientState, LoadClientsSuccess>(_setLoadedClients),
  TypedReducer<ClientState, LoadClientsFailure>(_setNoClients),
  TypedReducer<ClientState, SelectClientAction>(_selectClient),

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

ClientState _archiveClientRequest(ClientState clientState, ArchiveClientRequest action) {
  var client = clientState.map[action.clientId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
  );

  return clientState.rebuild((b) => b
    ..map[action.clientId] = client
    ..editing.replace(client)
  );
}

ClientState _archiveClientSuccess(ClientState clientState, ArchiveClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
    ..editing.replace(action.client)
  );
}

ClientState _archiveClientFailure(ClientState clientState, ArchiveClientFailure action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
    ..editing.replace(action.client)
  );
}

ClientState _deleteClientRequest(ClientState clientState, DeleteClientRequest action) {
  var client = clientState.map[action.clientId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true
  );

  return clientState.rebuild((b) => b
    ..map[action.clientId] = client
    ..editing.replace(client)
  );
}

ClientState _deleteClientSuccess(ClientState clientState, DeleteClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
    ..editing.replace(action.client)
  );
}

ClientState _deleteClientFailure(ClientState clientState, DeleteClientFailure action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
    ..editing.replace(action.client)
  );
}


ClientState _restoreClientRequest(ClientState clientState, RestoreClientRequest action) {
  var client = clientState.map[action.clientId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false
  );
  return clientState.rebuild((b) => b
    ..map[action.clientId] = client
    ..editing.replace(client)
  );
}

ClientState _restoreClientSuccess(ClientState clientState, RestoreClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
    ..editing.replace(action.client)
  );
}

ClientState _restoreClientFailure(ClientState clientState, RestoreClientFailure action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
    ..editing.replace(action.client)
  );
}


ClientState _addClient(
    ClientState clientState, AddClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
    ..list.add(action.client.id)
    ..editing.replace(action.client)
  );
}

ClientState _updateClient(
    ClientState clientState, SaveClientSuccess action) {
  return clientState.rebuild((b) => b
      ..map[action.client.id] = action.client
      ..editing.replace(action.client)
  );
}

ClientState _setNoClients(
    ClientState clientState, LoadClientsFailure action) {
  return clientState;
}

ClientState _selectClient(
    ClientState clientState, SelectClientAction action) {
  return clientState.rebuild((b) => b
    ..editing.replace(action.client));
}

ClientState _setLoadedClients(
    ClientState clientState, LoadClientsSuccess action) {
  return clientState.rebuild(
    (b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(Map.fromIterable(
        action.clients,
        key: (item) => item.id,
        value: (item) => item,
      ))
      ..list.replace(action.clients.map(
              (client) => client.id).toList())
  );
}
