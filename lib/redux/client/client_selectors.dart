import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownClientList = memo2(
    (BuiltMap<int, ClientEntity> clientMap, BuiltList<int> clientList) =>
        dropdownClientsSelector(clientMap, clientList));

List<int> dropdownClientsSelector(
    BuiltMap<int, ClientEntity> clientMap, BuiltList<int> clientList) {
  final list =
      clientList.where((clientId) => clientMap[clientId].isActive).toList();

  list.sort((clientAId, clientBId) {
    final clientA = clientMap[clientAId];
    final clientB = clientMap[clientBId];
    return clientA.compareTo(clientB, ClientFields.name, true);
  });

  return list;
}

var memoizedClientList = memo3((BuiltMap<int, ClientEntity> clientMap,
        BuiltList<int> clientList, ListUIState clientListState) =>
    visibleClientsSelector(clientMap, clientList, clientListState));

List<int> visibleClientsSelector(BuiltMap<int, ClientEntity> clientMap,
    BuiltList<int> clientList, ListUIState clientListState) {
  final list = clientList.where((clientId) {
    final client = clientMap[clientId];
    if (!client.matchesStates(clientListState.stateFilters)) {
      return false;
    }
    return client.matchesSearch(clientListState.search);
  }).toList();

  list.sort((clientAId, clientBId) {
    final clientA = clientMap[clientAId];
    final clientB = clientMap[clientBId];
    return clientA.compareTo(
        clientB, clientListState.sortField, clientListState.sortAscending);
  });

  return list;
}
