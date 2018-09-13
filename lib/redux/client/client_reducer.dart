import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';

EntityUIState clientUIReducer(ClientUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(clientListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..editingContact
        .replace(editingContactReducer(state.editingContact, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

final editingContactReducer = combineReducers<ContactEntity>([
  TypedReducer<ContactEntity, EditClient>(editContact),
  TypedReducer<ContactEntity, EditContact>(editContact),
]);

ContactEntity editContact(ContactEntity contact, dynamic action) {
  return action.contact ?? ContactEntity();
}

Reducer<int> selectedIdReducer = combineReducers([
  TypedReducer<int, ViewClient>(
      (int selectedId, dynamic action) => action.clientId),
  TypedReducer<int, AddClientSuccess>(
      (int selectedId, dynamic action) => action.client.id),
]);

final editingReducer = combineReducers<ClientEntity>([
  TypedReducer<ClientEntity, SaveClientSuccess>(_updateEditing),
  TypedReducer<ClientEntity, AddClientSuccess>(_updateEditing),
  TypedReducer<ClientEntity, RestoreClientSuccess>(_updateEditing),
  TypedReducer<ClientEntity, ArchiveClientSuccess>(_updateEditing),
  TypedReducer<ClientEntity, DeleteClientSuccess>(_updateEditing),
  TypedReducer<ClientEntity, EditClient>(_updateEditing),
  TypedReducer<ClientEntity, UpdateClient>(_updateEditing),
  TypedReducer<ClientEntity, AddContact>(_addContact),
  TypedReducer<ClientEntity, DeleteContact>(_removeContact),
  TypedReducer<ClientEntity, UpdateContact>(_updateContact),
  TypedReducer<ClientEntity, SelectCompany>(_clearEditing),
]);

ClientEntity _clearEditing(ClientEntity client, dynamic action) {
  return ClientEntity();
}

ClientEntity _updateEditing(ClientEntity client, dynamic action) {
  return action.client;
}

ClientEntity _addContact(ClientEntity client, AddContact action) {
  return client
      .rebuild((b) => b..contacts.add(action.contact ?? ContactEntity()));
}

ClientEntity _removeContact(ClientEntity client, DeleteContact action) {
  return client.rebuild((b) => b..contacts.removeAt(action.index));
}

ClientEntity _updateContact(ClientEntity client, UpdateContact action) {
  return client.rebuild((b) => b..contacts[action.index] = action.contact);
}

final clientListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortClients>(_sortClients),
  TypedReducer<ListUIState, FilterClientsByState>(_filterClientsByState),
  TypedReducer<ListUIState, FilterClients>(_filterClients),
  TypedReducer<ListUIState, FilterClientsByCustom1>(_filterClientsByCustom1),
  TypedReducer<ListUIState, FilterClientsByCustom2>(_filterClientsByCustom2),
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

ListUIState _filterClients(ListUIState clientListState, FilterClients action) {
  return clientListState.rebuild((b) => b..filter = action.filter);
}

ListUIState _sortClients(ListUIState clientListState, SortClients action) {
  return clientListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
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
  final client = clientState.map[action.clientId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return clientState.rebuild((b) => b..map[action.clientId] = client);
}

ClientState _archiveClientSuccess(
    ClientState clientState, ArchiveClientSuccess action) {
  return clientState.rebuild((b) => b..map[action.client.id] = action.client);
}

ClientState _archiveClientFailure(
    ClientState clientState, ArchiveClientFailure action) {
  return clientState.rebuild((b) => b..map[action.client.id] = action.client);
}

ClientState _deleteClientRequest(
    ClientState clientState, DeleteClientRequest action) {
  final client = clientState.map[action.clientId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return clientState.rebuild((b) => b..map[action.clientId] = client);
}

ClientState _deleteClientSuccess(
    ClientState clientState, DeleteClientSuccess action) {
  return clientState.rebuild((b) => b..map[action.client.id] = action.client);
}

ClientState _deleteClientFailure(
    ClientState clientState, DeleteClientFailure action) {
  return clientState.rebuild((b) => b..map[action.client.id] = action.client);
}

ClientState _restoreClientRequest(
    ClientState clientState, RestoreClientRequest action) {
  final client = clientState.map[action.clientId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return clientState.rebuild((b) => b..map[action.clientId] = client);
}

ClientState _restoreClientSuccess(
    ClientState clientState, RestoreClientSuccess action) {
  return clientState.rebuild((b) => b..map[action.client.id] = action.client);
}

ClientState _restoreClientFailure(
    ClientState clientState, RestoreClientFailure action) {
  return clientState.rebuild((b) => b..map[action.client.id] = action.client);
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
