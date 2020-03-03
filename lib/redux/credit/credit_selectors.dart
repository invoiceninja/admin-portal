import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

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

    if (creditListState.filterEntityType == EntityType.client) {
      if (!creditListState.entityMatchesFilter(client)) {
        return false;
      }
    } else if (creditListState.filterEntityType == EntityType.user) {
      if (!credit.userCanAccess(creditListState.filterEntityId)) {
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
    return creditMap[creditAId].compareTo(creditMap[creditBId],
        creditListState.sortField, creditListState.sortAscending);
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
    if (credit.userCanAccess(userId)) {
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
