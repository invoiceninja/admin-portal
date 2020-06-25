import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownClientList = memo6(
    (BuiltMap<String, ClientEntity> clientMap,
            BuiltList<String> clientList,
            BuiltMap<String, UserEntity> userMap,
            BuiltMap<String, CountryEntity> countryMap,
            BuiltMap<String, LanguageEntity> languageMap,
            BuiltMap<String, CurrencyEntity> currencyMap) =>
        dropdownClientsSelector(clientMap, clientList, userMap, countryMap,
            languageMap, currencyMap));

List<String> dropdownClientsSelector(
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> clientList,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, CountryEntity> countryMap,
    BuiltMap<String, LanguageEntity> languageMap,
    BuiltMap<String, CurrencyEntity> currencyMap) {
  final list =
      clientList.where((clientId) => clientMap[clientId].isActive).toList();

  list.sort((clientAId, clientBId) {
    final clientA = clientMap[clientAId];
    final clientB = clientMap[clientBId];
    return clientA.compareTo(clientB, ClientFields.name, true, userMap,
        countryMap, languageMap, currencyMap);
  });

  return list;
}

var memoizedFilteredClientList = memo8(
    (BuiltMap<String, ClientEntity> clientMap,
            BuiltList<String> clientList,
            BuiltMap<String, GroupEntity> groupMap,
            ListUIState clientListState,
            BuiltMap<String, UserEntity> userMap,
            BuiltMap<String, CountryEntity> countryMap,
            BuiltMap<String, LanguageEntity> languageMap,
            BuiltMap<String, CurrencyEntity> currencyMap) =>
        filteredClientsSelector(clientMap, clientList, groupMap,
            clientListState, userMap, countryMap, languageMap, currencyMap));

List<String> filteredClientsSelector(
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> clientList,
    BuiltMap<String, GroupEntity> groupMap,
    ListUIState clientListState,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, CountryEntity> countryMap,
    BuiltMap<String, LanguageEntity> languageMap,
    BuiltMap<String, CurrencyEntity> currencyMap) {
  final list = clientList.where((clientId) {
    final client = clientMap[clientId];
    final group = groupMap[client.groupId] ?? GroupEntity(id: client.groupId);

    if (clientListState.filterEntityType == EntityType.group) {
      if (!clientListState.entityMatchesFilter(group)) {
        return false;
      }
    } else if (clientListState.filterEntityType == EntityType.user) {
      if (client.assignedUserId != clientListState.filterEntityId) {
        return false;
      }
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
    return clientA.compareTo(
        clientB,
        clientListState.sortField,
        clientListState.sortAscending,
        userMap,
        countryMap,
        languageMap,
        currencyMap);
  });

  return list;
}

bool hasClientChanges(
        ClientEntity client, BuiltMap<String, ClientEntity> clientMap) =>
    client.isNew ? client.isChanged : client != clientMap[client.id];
