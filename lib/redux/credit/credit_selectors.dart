import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownCreditList = memo6(
    (BuiltMap<String, InvoiceEntity> creditMap,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltList<String> creditList,
            String clientId,
            BuiltMap<String, UserEntity> userMap,
            List<String> excludedIds) =>
        dropdownCreditSelector(
            creditMap, clientMap, creditList, clientId, userMap, excludedIds));

List<String> dropdownCreditSelector(
    BuiltMap<String, InvoiceEntity> creditMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> creditList,
    String clientId,
    BuiltMap<String, UserEntity> userMap,
    List<String> excludedIds) {
  final list = creditList.where((creditId) {
    final credit = creditMap[creditId];
    if (excludedIds.contains(creditId)) {
      return false;
    }
    if (clientId != null &&
        clientId.isNotEmpty &&
        credit.clientId != clientId) {
      return false;
    }
    if (!clientMap.containsKey(credit.clientId) ||
        !clientMap[credit.clientId].isActive) {
      return false;
    }
    if (credit.balance == 0) {
      return false;
    }
    return credit.isActive && credit.isUnpaid;
  }).toList();

  list.sort((creditAId, creditBId) {
    final creditA = creditMap[creditAId];
    final creditB = creditMap[creditBId];
    return creditA.compareTo(
        invoice: creditB,
        clientMap: clientMap,
        sortAscending: true,
        sortField: ClientFields.name,
        userMap: userMap);
  });

  return list;
}

ClientEntity creditClientSelector(
    InvoiceEntity credit, BuiltMap<String, ClientEntity> clientMap) {
  return clientMap[credit.clientId];
}

var memoizedFilteredCreditList = memo6((SelectionState selectionState,
        BuiltMap<String, InvoiceEntity> creditMap,
        BuiltList<String> creditList,
        BuiltMap<String, ClientEntity> clientMap,
        ListUIState creditListState,
        BuiltMap<String, UserEntity> userMap) =>
    filteredCreditsSelector(selectionState, creditMap, creditList, clientMap,
        creditListState, userMap));

List<String> filteredCreditsSelector(
    SelectionState selectionState,
    BuiltMap<String, InvoiceEntity> creditMap,
    BuiltList<String> creditList,
    BuiltMap<String, ClientEntity> clientMap,
    ListUIState creditListState,
    BuiltMap<String, UserEntity> userMap) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = creditList.where((creditId) {
    final credit = creditMap[creditId];
    final client =
        clientMap[credit.clientId] ?? ClientEntity(id: credit.clientId);

    if (credit.id == selectionState.selectedId) {
      return true;
    }

    if (!client.isActive &&
        !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (filterEntityType == EntityType.client && client.id != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.user &&
        credit.assignedUserId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.design &&
        credit.designId != filterEntityId) {
      return false;
    }

    if (!credit.matchesStates(creditListState.stateFilters)) {
      return false;
    }
    if (!credit.matchesStatuses(creditListState.statusFilters)) {
      return false;
    }
    if (!credit.matchesFilter(creditListState.filter) &&
        !client.matchesFilter(creditListState.filter)) {
      return false;
    }
    if (creditListState.custom1Filters.isNotEmpty &&
        !creditListState.custom1Filters.contains(credit.customValue1)) {
      return false;
    }
    if (creditListState.custom2Filters.isNotEmpty &&
        !creditListState.custom2Filters.contains(credit.customValue2)) {
      return false;
    }
    return true;
  }).toList();

  list.sort((creditAId, creditBId) {
    return creditMap[creditAId].compareTo(
        invoice: creditMap[creditBId],
        sortField: creditListState.sortField,
        sortAscending: creditListState.sortAscending,
        clientMap: clientMap,
        userMap: userMap);
  });

  return list;
}

var memoizedCreditStatsForDesign = memo2(
    (String designId, BuiltMap<String, InvoiceEntity> creditMap) =>
        creditStatsForDesign(designId, creditMap));

EntityStats creditStatsForDesign(
    String designId, BuiltMap<String, InvoiceEntity> creditMap) {
  int countActive = 0;
  int countArchived = 0;
  creditMap.forEach((creditId, credit) {
    if (credit.designId == designId) {
      if (credit.isActive) {
        countActive++;
      } else if (credit.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedCreditStatsForClient = memo2(
    (String clientId, BuiltMap<String, InvoiceEntity> creditMap) =>
        creditStatsForClient(clientId, creditMap));

EntityStats creditStatsForClient(
    String clientId, BuiltMap<String, InvoiceEntity> creditMap) {
  int countActive = 0;
  int countArchived = 0;
  creditMap.forEach((creditId, credit) {
    if (credit.clientId == clientId) {
      if (credit.isActive) {
        countActive++;
      } else if (credit.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedCreditStatsForUser = memo2(
    (String userId, BuiltMap<String, InvoiceEntity> creditMap) =>
        creditStatsForUser(userId, creditMap));

EntityStats creditStatsForUser(
  String userId,
  BuiltMap<String, InvoiceEntity> creditMap,
) {
  int countActive = 0;
  int countArchived = 0;
  creditMap.forEach((creditId, credit) {
    if (credit.assignedUserId == userId) {
      if (credit.isActive) {
        countActive++;
      } else if (credit.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

bool hasCreditChanges(
        InvoiceEntity credit, BuiltMap<String, InvoiceEntity> creditMap) =>
    credit.isNew ? credit.isChanged : credit != creditMap[credit.id];
