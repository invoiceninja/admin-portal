import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownInvoiceList = memo4(
    (BuiltMap<String, InvoiceEntity> invoiceMap,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltList<String> invoiceList,
            String clientId) =>
        dropdownInvoiceSelector(invoiceMap, clientMap, invoiceList, clientId));

List<String> dropdownInvoiceSelector(
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> invoiceList,
    String clientId) {
  final list = invoiceList.where((invoiceId) {
    final invoice = invoiceMap[invoiceId];
    if (clientId != null &&
        clientId.isNotEmpty &&
        invoice.clientId != clientId) {
      return false;
    }
    if (!clientMap.containsKey(invoice.clientId) ||
        !clientMap[invoice.clientId].isActive) {
      return false;
    }
    return invoice.isActive && invoice.isUnpaid;
  }).toList();

  list.sort((invoiceAId, invoiceBId) {
    final invoiceA = invoiceMap[invoiceAId];
    final invoiceB = invoiceMap[invoiceBId];
    return invoiceA.compareTo(invoiceB, ClientFields.name, true);
  });

  return list;
}

var memoizedFilteredInvoiceList = memo4(
    (BuiltMap<String, InvoiceEntity> invoiceMap,
            BuiltList<String> invoiceList,
            BuiltMap<String, ClientEntity> clientMap,
            ListUIState invoiceListState) =>
        filteredInvoicesSelector(
            invoiceMap, invoiceList, clientMap, invoiceListState));

List<String> filteredInvoicesSelector(
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltList<String> invoiceList,
    BuiltMap<String, ClientEntity> clientMap,
    ListUIState invoiceListState) {
  final list = invoiceList.where((invoiceId) {
    final invoice = invoiceMap[invoiceId];
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);

    if (invoiceListState.filterEntityType == EntityType.client) {
      if (!invoiceListState.entityMatchesFilter(client)) {
        return false;
      }
    } else {
      if (!client.isActive) {
        return false;
      }

      if (invoiceListState.filterEntityType == EntityType.user) {
        if (!invoice.userCanAccess(invoiceListState.filterEntityId)) {
          return false;
        }
      }
    }


    if (!invoice.matchesStates(invoiceListState.stateFilters)) {
      return false;
    }
    if (!invoice.matchesStatuses(invoiceListState.statusFilters)) {
      return false;
    }
    if (!invoice.matchesFilter(invoiceListState.filter) &&
        !client.matchesFilter(invoiceListState.filter)) {
      return false;
    }
    if (invoiceListState.custom1Filters.isNotEmpty &&
        !invoiceListState.custom1Filters.contains(invoice.customValue1)) {
      return false;
    }
    if (invoiceListState.custom2Filters.isNotEmpty &&
        !invoiceListState.custom2Filters.contains(invoice.customValue2)) {
      return false;
    }
    return true;
  }).toList();

  list.sort((invoiceAId, invoiceBId) {
    return invoiceMap[invoiceAId].compareTo(invoiceMap[invoiceBId],
        invoiceListState.sortField, invoiceListState.sortAscending);
  });

  return list;
}

var memoizedInvoiceStatsForClient = memo2((String clientId,
        BuiltMap<String, InvoiceEntity> invoiceMap) =>
    invoiceStatsForClient(clientId, invoiceMap));

EntityStats invoiceStatsForClient(
    String clientId,
    BuiltMap<String, InvoiceEntity> invoiceMap) {
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

var memoizedInvoiceStatsForUser = memo2((String userId,
        BuiltMap<String, InvoiceEntity> invoiceMap) =>
    invoiceStatsForUser(userId, invoiceMap));

EntityStats invoiceStatsForUser(
    String userId,
    BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.userCanAccess(userId)) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isDeleted) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

bool hasInvoiceChanges(
        InvoiceEntity invoice, BuiltMap<String, InvoiceEntity> invoiceMap) =>
    invoice.isNew ? invoice.isChanged : invoice != invoiceMap[invoice.id];
