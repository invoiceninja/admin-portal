import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

ClientEntity invoiceClientSelector(
    InvoiceEntity invoice, BuiltMap<int, ClientEntity> clientMap) {
  return clientMap[invoice.clientId];
}

var memoizedFilteredInvoiceList = memo4(
    (BuiltMap<int, InvoiceEntity> invoiceMap,
            BuiltList<int> invoiceList,
            BuiltMap<int, ClientEntity> clientMap,
            ListUIState invoiceListState) =>
        filteredInvoicesSelector(
            invoiceMap, invoiceList, clientMap, invoiceListState));

List<int> filteredInvoicesSelector(
    BuiltMap<int, InvoiceEntity> invoiceMap,
    BuiltList<int> invoiceList,
    BuiltMap<int, ClientEntity> clientMap,
    ListUIState invoiceListState) {
  final list = invoiceList.where((invoiceId) {
    final invoice = invoiceMap[invoiceId];
    final client = clientMap[invoice.clientId];
    if (client.isDeleted) {
      return false;
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
    if (invoiceListState.filterClientId != null &&
        invoice.clientId != invoiceListState.filterClientId) {
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

var memoizedInvoiceStatsForClient = memo4((int clientId,
        BuiltMap<int, InvoiceEntity> invoiceMap,
        String activeLabel,
        String archivedLabel) =>
    invoiceStatsForClient(clientId, invoiceMap, activeLabel, archivedLabel));

String invoiceStatsForClient(
    int clientId,
    BuiltMap<int, InvoiceEntity> invoiceMap,
    String activeLabel,
    String archivedLabel) {
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

  String str = '';
  if (countActive > 0) {
    str = '$countActive $activeLabel';
    if (countArchived > 0) {
      str += ' • ';
    }
  }
  if (countArchived > 0) {
    str += '$countArchived $archivedLabel';
  }

  return str;
}
