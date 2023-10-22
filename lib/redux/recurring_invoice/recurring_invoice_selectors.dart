// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedFilteredRecurringInvoiceList = memo7((
  SelectionState selectionState,
  BuiltMap<String, InvoiceEntity> recurringInvoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltList<String> recurringInvoiceList,
  ListUIState recurringInvoiceListState,
  BuiltMap<String, UserEntity> userMap,
) =>
    filteredRecurringInvoicesSelector(
      selectionState,
      recurringInvoiceMap,
      clientMap,
      vendorMap,
      recurringInvoiceList,
      recurringInvoiceListState,
      userMap,
    ));

List<String> filteredRecurringInvoicesSelector(
  SelectionState selectionState,
  BuiltMap<String, InvoiceEntity> recurringInvoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltList<String> recurringInvoiceList,
  ListUIState invoiceListState,
  BuiltMap<String, UserEntity> userMap,
) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = recurringInvoiceList.where((recurringInvoiceId) {
    final invoice = recurringInvoiceMap[recurringInvoiceId]!;
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);

    if (invoice.id == selectionState.selectedId) {
      return true;
    }

    if (!client.isActive &&
        !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (filterEntityType == EntityType.client && client.id != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.user &&
        invoice.assignedUserId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.paymentLink &&
        invoice.subscriptionId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.design &&
        invoice.designId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.group &&
        client.groupId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.project &&
        invoice.projectId != filterEntityId) {
      return false;
    }

    if (!invoice.matchesStates(invoiceListState.stateFilters)) {
      return false;
    }
    if (!invoice.matchesStatuses(invoiceListState.statusFilters)) {
      return false;
    }
    if (!invoice.matchesFilter(invoiceListState.filter) &&
        !client.matchesNameOrEmail(invoiceListState.filter)) {
      return false;
    }
    if (invoiceListState.custom1Filters.isNotEmpty &&
        !invoiceListState.custom1Filters.contains(invoice.customValue1)) {
      return false;
    } else if (invoiceListState.custom2Filters.isNotEmpty &&
        !invoiceListState.custom2Filters.contains(invoice.customValue2)) {
      return false;
    } else if (invoiceListState.custom3Filters.isNotEmpty &&
        !invoiceListState.custom3Filters.contains(invoice.customValue3)) {
      return false;
    } else if (invoiceListState.custom4Filters.isNotEmpty &&
        !invoiceListState.custom4Filters.contains(invoice.customValue4)) {
      return false;
    }
    return true;
  }).toList();

  list.sort((recurringInvoiceAId, recurringInvoiceBId) {
    final recurringInvoiceA = recurringInvoiceMap[recurringInvoiceAId]!;
    final recurringInvoiceB = recurringInvoiceMap[recurringInvoiceBId];

    return recurringInvoiceA.compareTo(
      invoice: recurringInvoiceB,
      sortField: invoiceListState.sortField,
      sortAscending: invoiceListState.sortAscending,
      clientMap: clientMap,
      vendorMap: vendorMap,
      userMap: userMap,
    );
  });

  return list;
}

var memoizedRecurringInvoiceStatsForClient = memo2(
    (String clientId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        recurringInvoiceStatsForClient(clientId, invoiceMap));

EntityStats recurringInvoiceStatsForClient(
    String clientId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.clientId == clientId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedRecurringInvoiceStatsForUser = memo2(
    (String userId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        recurringInvoiceStatsForUser(userId, invoiceMap));

EntityStats recurringInvoiceStatsForUser(
    String userId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.assignedUserId == userId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isDeleted!) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedRecurringInvoiceStatsForInvoice = memo2(
    (String invoiceId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        recurringInvoiceStatsForInvoice(invoiceId, invoiceMap));

EntityStats recurringInvoiceStatsForInvoice(
    String recurrinInvoiceId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.recurringId == recurrinInvoiceId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isDeleted!) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedRecurringInvoiceStatsForDesign = memo2(
    (String designId, BuiltMap<String, InvoiceEntity> recurringInvoiceMap) =>
        recurringInvoiceStatsForDesign(designId, recurringInvoiceMap));

EntityStats recurringInvoiceStatsForDesign(
    String designId, BuiltMap<String, InvoiceEntity> recurringInvoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  recurringInvoiceMap.forEach((invoiceId, invoice) {
    if (invoice.designId == designId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedRecurringInvoiceStatsForSubscription = memo2(
    (String subscriptionId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        recurringInvoiceStatsForSubscription(subscriptionId, invoiceMap));

EntityStats recurringInvoiceStatsForSubscription(
    String subscriptionId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.subscriptionId == subscriptionId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}
