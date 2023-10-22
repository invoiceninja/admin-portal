// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

ClientContactEntity? creditContactSelector(
    InvoiceEntity credit, ClientEntity client) {
  var contactIds = credit.invitations
      .map((invitation) => invitation.clientContactId)
      .toList();
  if (contactIds.contains(client.primaryContact.id)) {
    contactIds = [client.primaryContact.id];
  }
  return client.contacts
      .firstWhere((contact) => contactIds.contains(contact.id), orElse: null);
}

var memoizedDropdownCreditList = memo7(
    (BuiltMap<String, InvoiceEntity> creditMap,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltMap<String, VendorEntity> vendorMap,
            BuiltList<String> creditList,
            String clientId,
            BuiltMap<String, UserEntity> userMap,
            List<String?> excludedIds) =>
        dropdownCreditSelector(
          creditMap,
          clientMap,
          vendorMap,
          creditList,
          clientId,
          userMap,
          excludedIds,
        ));

List<String> dropdownCreditSelector(
    BuiltMap<String, InvoiceEntity> creditMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltList<String> creditList,
    String clientId,
    BuiltMap<String, UserEntity> userMap,
    List<String?> excludedIds) {
  final list = creditList.where((creditId) {
    final credit = creditMap[creditId];
    if (excludedIds.contains(creditId)) {
      return false;
    }
    if (clientId.isNotEmpty && credit!.clientId != clientId) {
      return false;
    }
    if (!clientMap.containsKey(credit!.clientId) ||
        !clientMap[credit.clientId]!.isActive) {
      return false;
    }
    if (credit.balanceOrAmount == 0) {
      return false;
    }
    return credit.isActive && credit.isUnpaid;
  }).toList();

  list.sort((creditAId, creditBId) {
    final creditA = creditMap[creditAId]!;
    final creditB = creditMap[creditBId];
    return creditA.compareTo(
        invoice: creditB,
        clientMap: clientMap,
        vendorMap: vendorMap,
        sortAscending: true,
        sortField: CreditFields.number,
        userMap: userMap);
  });

  return list;
}

ClientEntity? creditClientSelector(
    InvoiceEntity credit, BuiltMap<String, ClientEntity> clientMap) {
  return clientMap[credit.clientId];
}

var memoizedFilteredCreditList = memo8((SelectionState selectionState,
        BuiltMap<String, InvoiceEntity> creditMap,
        BuiltList<String> creditList,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, VendorEntity> vendorMap,
        BuiltMap<String, PaymentEntity> paymentMap,
        ListUIState creditListState,
        BuiltMap<String, UserEntity> userMap) =>
    filteredCreditsSelector(selectionState, creditMap, creditList, clientMap,
        vendorMap, paymentMap, creditListState, userMap));

List<String> filteredCreditsSelector(
    SelectionState selectionState,
    BuiltMap<String, InvoiceEntity> creditMap,
    BuiltList<String> creditList,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltMap<String, PaymentEntity> paymentMap,
    ListUIState creditListState,
    BuiltMap<String, UserEntity> userMap) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final Map<String?, List<String>> creditPaymentMap = {};
  if (filterEntityType == EntityType.payment) {
    paymentMap.forEach((paymentId, payment) {
      payment.creditPaymentables.forEach((creditPaymentable) {
        final List<String> paymentIds =
            creditPaymentMap[creditPaymentable.creditId] ?? [];
        paymentIds.add(payment.id);
        creditPaymentMap[creditPaymentable.creditId] = paymentIds;
      });
    });
  }

  final list = creditList.where((creditId) {
    final credit = creditMap[creditId]!;
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
    } else if (filterEntityType == EntityType.group &&
        client.groupId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.project &&
        credit.projectId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.payment) {
      bool isMatch = false;
      (creditPaymentMap[creditId] ?? []).forEach((paymentId) {
        if (filterEntityId == paymentId) {
          isMatch = true;
        }
      });

      if (!isMatch) {
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
        !client.matchesNameOrEmail(creditListState.filter)) {
      return false;
    }

    if (creditListState.custom1Filters.isNotEmpty &&
        !creditListState.custom1Filters.contains(credit.customValue1)) {
      return false;
    } else if (creditListState.custom2Filters.isNotEmpty &&
        !creditListState.custom2Filters.contains(credit.customValue2)) {
      return false;
    } else if (creditListState.custom3Filters.isNotEmpty &&
        !creditListState.custom3Filters.contains(credit.customValue3)) {
      return false;
    } else if (creditListState.custom4Filters.isNotEmpty &&
        !creditListState.custom4Filters.contains(credit.customValue4)) {
      return false;
    }

    return true;
  }).toList();

  list.sort((creditAId, creditBId) {
    return creditMap[creditAId]!.compareTo(
        invoice: creditMap[creditBId],
        sortField: creditListState.sortField,
        sortAscending: creditListState.sortAscending,
        clientMap: clientMap,
        vendorMap: vendorMap,
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
