// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState clientUIReducer(ClientUIState state, dynamic action) {
  return state.rebuild(
    (b) => b
      ..listUIState.replace(clientListReducer(state.listUIState, action))
      ..editing.replace(editingReducer(state.editing, action)!)
      ..editingContact
          .replace(editingContactReducer(state.editingContact, action)!)
      ..selectedId = selectedIdReducer(state.selectedId, action)
      ..forceSelected = forceSelectedReducer(state.forceSelected, action)
      ..tabIndex = tabIndexReducer(state.tabIndex, action)
      ..saveCompleter = saveCompleterReducer(state.saveCompleter, action)
      ..cancelCompleter = cancelCompleterReducer(state.cancelCompleter, action),
  );
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewClient>((completer, action) => true),
  TypedReducer<bool?, ViewClientList>((completer, action) => false),
  TypedReducer<bool?, FilterClientsByState>((completer, action) => false),
  TypedReducer<bool?, FilterClients>((completer, action) => false),
  TypedReducer<bool?, FilterClientsByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterClientsByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterClientsByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterClientsByCustom4>((completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateClientTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

final saveCompleterReducer = combineReducers<Completer<SelectableEntity>?>([
  TypedReducer<Completer<SelectableEntity>?, EditClient>((completer, action) {
    return action.completer as Completer<SelectableEntity>?;
  }),
]);

final cancelCompleterReducer = combineReducers<Completer<Null>?>([
  TypedReducer<Completer<Null>?, EditClient>((completer, action) {
    return action.cancelCompleter as Completer<Null>?;
  }),
]);

final editingContactReducer = combineReducers<ClientContactEntity?>([
  TypedReducer<ClientContactEntity?, EditClient>((contact, action) {
    return action.contact ?? ClientContactEntity();
  }),
  TypedReducer<ClientContactEntity?, EditContact>((contact, action) {
    return action.contact ?? ClientContactEntity();
  }),
]);

final selectedIdReducer = combineReducers<String?>([
  TypedReducer<String?, ArchiveClientsSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteClientsSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.client ? action.entityId : selectedId),
  TypedReducer<String?, ViewClient>((selectedId, action) {
    return action.clientId;
  }),
  TypedReducer<String?, AddClientSuccess>((selectedId, action) {
    return action.client.id;
  }),
  TypedReducer<String?, ShowPdfClient>(
      (selectedId, action) => action.client!.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortClients>((selectedId, action) => ''),
  TypedReducer<String?, FilterClients>((selectedId, action) => ''),
  TypedReducer<String?, FilterClientsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterClientsByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterClientsByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterClientsByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterClientsByCustom4>((selectedId, action) => ''),
  TypedReducer<String?, ClearEntitySelection>((selectedId, action) =>
      action.entityType == EntityType.client ? '' : selectedId),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.client
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<ClientEntity?>([
  TypedReducer<ClientEntity?, SaveClientSuccess>((client, action) {
    return action.client;
  }),
  TypedReducer<ClientEntity?, AddClientSuccess>((client, action) {
    return action.client;
  }),
  TypedReducer<ClientEntity?, RestoreClientSuccess>((clients, action) {
    return action.clients[0];
  }),
  TypedReducer<ClientEntity?, ArchiveClientsSuccess>((clients, action) {
    return action.clients[0];
  }),
  TypedReducer<ClientEntity?, DeleteClientsSuccess>((clients, action) {
    return action.clients[0];
  }),
  TypedReducer<ClientEntity?, EditClient>((client, action) {
    return action.client;
  }),
  TypedReducer<ClientEntity?, UpdateClient>((client, action) {
    return action.client.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ClientEntity?, AddContact>((client, action) {
    return client!.rebuild((b) => b
      ..contacts.add(action.contact ?? ClientContactEntity())
      ..isChanged = true);
  }),
  TypedReducer<ClientEntity?, DeleteContact>((client, action) {
    return client!.rebuild((b) => b
      ..contacts.removeAt(action.index)
      ..isChanged = true);
  }),
  TypedReducer<ClientEntity?, UpdateContact>((client, action) {
    return client!.rebuild((b) => b
      ..contacts[action.index] = action.contact
      ..isChanged = true);
  }),
  TypedReducer<ClientEntity?, ViewClient>((client, action) {
    return ClientEntity();
  }),
  TypedReducer<ClientEntity?, ViewClientList>((client, action) {
    return ClientEntity();
  }),
  TypedReducer<ClientEntity?, SelectCompany>((client, action) {
    return ClientEntity();
  }),
  TypedReducer<ClientEntity?, DiscardChanges>((client, action) {
    return ClientEntity();
  }),
]);

final clientListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortClients>(_sortClients),
  TypedReducer<ListUIState, FilterClientsByState>(_filterClientsByState),
  TypedReducer<ListUIState, FilterClients>(_filterClients),
  TypedReducer<ListUIState, FilterClientsByCustom1>(_filterClientsByCustom1),
  TypedReducer<ListUIState, FilterClientsByCustom2>(_filterClientsByCustom2),
  TypedReducer<ListUIState, FilterClientsByCustom3>(_filterClientsByCustom3),
  TypedReducer<ListUIState, FilterClientsByCustom4>(_filterClientsByCustom4),
  TypedReducer<ListUIState, StartClientMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToClientMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromClientMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearClientMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewClientList>(_viewClientList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewClientList(
    ListUIState clientListState, ViewClientList action) {
  return clientListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

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

ListUIState _filterClientsByCustom3(
    ListUIState clientListState, FilterClientsByCustom3 action) {
  if (clientListState.custom3Filters.contains(action.value)) {
    return clientListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return clientListState.rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterClientsByCustom4(
    ListUIState clientListState, FilterClientsByCustom4 action) {
  if (clientListState.custom4Filters.contains(action.value)) {
    return clientListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return clientListState.rebuild((b) => b..custom4Filters.add(action.value));
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
  return clientListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : clientListState.filterClearedAt);
}

ListUIState _sortClients(ListUIState clientListState, SortClients action) {
  return clientListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState clientListState, StartClientMultiselect action) {
  return clientListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState clientListState, AddToClientMultiselect action) {
  return clientListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState clientListState, RemoveFromClientMultiselect action) {
  return clientListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
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
  TypedReducer<ClientState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<ClientState, ArchiveClientsSuccess>(_archiveClientSuccess),
  TypedReducer<ClientState, DeleteClientsSuccess>(_deleteClientSuccess),
  TypedReducer<ClientState, RestoreClientSuccess>(_restoreClientSuccess),
  TypedReducer<ClientState, MergeClientsSuccess>(_mergeClientSuccess),
  TypedReducer<ClientState, PurgeClientSuccess>(_purgeClientSuccess),
]);

ClientState _archiveClientSuccess(
    ClientState clientState, ArchiveClientsSuccess action) {
  return clientState.rebuild((b) {
    for (final client in action.clients) {
      b.map[client.id] = client;
    }
  });
}

ClientState _deleteClientSuccess(
    ClientState clientState, DeleteClientsSuccess action) {
  return clientState.rebuild((b) {
    for (final client in action.clients) {
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

ClientState _addClient(ClientState clientState, AddClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch)
    ..list.add(action.client.id));
}

ClientState _updateClient(ClientState clientState, SaveClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

ClientState _setLoadedClient(
    ClientState clientState, LoadClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map[action.client.id] = action.client
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

ClientState _mergeClientSuccess(
    ClientState clientState, MergeClientsSuccess action) {
  return clientState.rebuild((b) => b
    ..map.remove(action.clientId)
    ..list.remove(action.clientId));
}

ClientState _purgeClientSuccess(
    ClientState clientState, PurgeClientSuccess action) {
  return clientState.rebuild((b) => b
    ..map.remove(action.clientId)
    ..list.remove(action.clientId));
}

ClientState _setLoadedClients(
        ClientState clientState, LoadClientsSuccess action) =>
    clientState.loadClients(action.clients);

ClientState _setLoadedCompany(
    ClientState clientState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return clientState.loadClients(company.clients);
}
