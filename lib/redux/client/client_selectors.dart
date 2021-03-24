import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownClientList = memo4(
    (BuiltMap<String, ClientEntity> clientMap, BuiltList<String> clientList,
            BuiltMap<String, UserEntity> userMap, StaticState staticState) =>
        dropdownClientsSelector(clientMap, clientList, userMap, staticState));

List<String> dropdownClientsSelector(
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> clientList,
    BuiltMap<String, UserEntity> userMap,
    StaticState staticState) {
  final list =
      clientList.where((clientId) => clientMap[clientId].isActive).toList();

  list.sort((clientAId, clientBId) {
    final clientA = clientMap[clientAId];
    final clientB = clientMap[clientBId];
    return clientA.compareTo(
        clientB, ClientFields.name, true, userMap, staticState);
  });

  return list;
}

var memoizedFilteredClientList = memo7((SelectionState selectionState,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltList<String> clientList,
        BuiltMap<String, GroupEntity> groupMap,
        ListUIState clientListState,
        BuiltMap<String, UserEntity> userMap,
        StaticState staticState) =>
    filteredClientsSelector(selectionState, clientMap, clientList, groupMap,
        clientListState, userMap, staticState));

List<String> filteredClientsSelector(
    SelectionState selectionState,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> clientList,
    BuiltMap<String, GroupEntity> groupMap,
    ListUIState clientListState,
    BuiltMap<String, UserEntity> userMap,
    StaticState staticState) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = clientList.where((clientId) {
    final client = clientMap[clientId];
    final group = groupMap[client.groupId] ?? GroupEntity(id: client.groupId);

    if (client.id == selectionState.selectedId) {
      return true;
    }

    if (filterEntityType == EntityType.group && group.id != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.user &&
        client.assignedUserId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.companyGateway &&
        !client.gatewayTokens
            .any((token) => token.companyGatewayId == filterEntityId)) {
      return false;
    }

    if (!client.matchesStates(clientListState.stateFilters)) {
      return false;
    }
    if (clientListState.custom1Filters.isNotEmpty &&
        !clientListState.custom1Filters.contains(client.customValue1)) {
      return false;
    }
    if (clientListState.custom2Filters.isNotEmpty &&
        !clientListState.custom2Filters.contains(client.customValue2)) {
      return false;
    }
    if (clientListState.custom3Filters.isNotEmpty &&
        !clientListState.custom3Filters.contains(client.customValue3)) {
      return false;
    }
    if (clientListState.custom4Filters.isNotEmpty &&
        !clientListState.custom4Filters.contains(client.customValue4)) {
      return false;
    }
    if (!client.matchesFilter(clientListState.filter) &&
        !group.matchesFilter(clientListState.filter)) {
      return false;
    }

    return true;
  }).toList();

  list.sort((clientAId, clientBId) {
    final clientA = clientMap[clientAId];
    final clientB = clientMap[clientBId];
    return clientA.compareTo(clientB, clientListState.sortField,
        clientListState.sortAscending, userMap, staticState);
  });

  return list;
}

bool hasClientChanges(
        ClientEntity client, BuiltMap<String, ClientEntity> clientMap) =>
    client.isNew ? client.isChanged : client != clientMap[client.id];
