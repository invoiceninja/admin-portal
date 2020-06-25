import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownCreditList = memo4(
    (BuiltMap<String, InvoiceEntity> creditMap,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltList<String> creditList,
            String clientId) =>
        dropdownCreditSelector(creditMap, clientMap, creditList, clientId));

List<String> dropdownCreditSelector(
    BuiltMap<String, InvoiceEntity> creditMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> creditList,
    String clientId) {
  final list = creditList.where((creditId) {
    final credit = creditMap[creditId];
    if (clientId != null &&
        clientId.isNotEmpty &&
        credit.clientId != clientId) {
      return false;
    }
    if (!clientMap.containsKey(credit.clientId) ||
        !clientMap[credit.clientId].isActive) {
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
    );
  });

  return list;
}

ClientEntity creditClientSelector(
    InvoiceEntity credit, BuiltMap<String, ClientEntity> clientMap) {
  return clientMap[credit.clientId];
}

var memoizedFilteredCreditList = memo4((BuiltMap<String, InvoiceEntity>
            creditMap,
        BuiltList<String> creditList,
        BuiltMap<String, ClientEntity> clientMap,
        ListUIState creditListState) =>
    filteredCreditsSelector(creditMap, creditList, clientMap, creditListState));

List<String> filteredCreditsSelector(
    BuiltMap<String, InvoiceEntity> creditMap,
    BuiltList<String> creditList,
    BuiltMap<String, ClientEntity> clientMap,
    ListUIState creditListState) {
  final list = creditList.where((creditId) {
    final credit = creditMap[creditId];
    final client =
        clientMap[credit.clientId] ?? ClientEntity(id: credit.clientId);

    if (!client.isActive && !creditListState.entityMatchesFilter(client)) {
      return false;
    }

    if (creditListState.filterEntityType == EntityType.client) {
      if (!creditListState.entityMatchesFilter(client)) {
        return false;
      }
    } else if (creditListState.filterEntityType == EntityType.user) {
      if (credit.assignedUserId != creditListState.filterEntityId) {
        return false;
      }
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
    );
  });

  return list;
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
