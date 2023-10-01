// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
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
      clientList.where((clientId) => clientMap[clientId]!.isActive).toList();

  list.sort((clientAId, clientBId) {
    final clientA = clientMap[clientAId]!;
    final clientB = clientMap[clientBId];
    return clientA.compareTo(
        clientB, ClientFields.name, true, userMap, staticState);
  });

  return list;
}

var memoizedClientStatsForUser = memo2(
    (String userId, BuiltMap<String, ClientEntity> clientMap) =>
        clientStatsForUser(userId, clientMap));

EntityStats clientStatsForUser(
    String userId, BuiltMap<String, ClientEntity> clientMap) {
  int countActive = 0;
  int countArchived = 0;
  clientMap.forEach((clientId, client) {
    if (client.assignedUserId == userId) {
      if (client.isActive) {
        countActive++;
      } else if (client.isDeleted!) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
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
    final client = clientMap[clientId]!;
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
    final clientA = clientMap[clientAId]!;
    final clientB = clientMap[clientBId];
    return clientA.compareTo(clientB, clientListState.sortField,
        clientListState.sortAscending, userMap, staticState);
  });

  return list;
}

SettingsEntity getClientSettings(AppState? state, ClientEntity? client) {
  if (state == null) {
    return SettingsEntity();
  }

  client ??= ClientEntity();
  final company = state.company;
  final group = state.groupState.get(client.groupId);

  return SettingsEntity(
    clientSettings: client.settings,
    groupSettings: group.settings,
    companySettings: company.settings,
  );
}

SettingsEntity getVendorSettings(AppState state, VendorEntity? vendor) {
  vendor ??= VendorEntity();
  final company = state.company;
  //final group = state.groupState.get(vendor.groupId);

  return SettingsEntity(
    clientSettings: SettingsEntity(), // client.settings,
    groupSettings: SettingsEntity(), // group.settings,
    companySettings: company.settings,
  );
}

bool? hasClientChanges(
        ClientEntity client, BuiltMap<String, ClientEntity> clientMap) =>
    client.isNew ? client.isChanged : client != clientMap[client.id];
