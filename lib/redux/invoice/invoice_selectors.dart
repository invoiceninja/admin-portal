import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';

ClientEntity invoiceClientSelector(
    InvoiceEntity invoice, BuiltMap<int, ClientEntity> clientMap) {
  return clientMap[invoice.clientId];
}

var memoizedInvoiceList = memo3((BuiltMap<int, InvoiceEntity> invoiceMap,
        BuiltList<int> invoiceList, ListUIState invoiceListState) =>
    visibleInvoicesSelector(invoiceMap, invoiceList, invoiceListState));

List<int> visibleInvoicesSelector(BuiltMap<int, InvoiceEntity> invoiceMap,
    BuiltList<int> invoiceList, ListUIState invoiceListState) {
  var list = invoiceList.where((invoiceId) {
    var invoice = invoiceMap[invoiceId];
    if (!invoice.matchesStates(invoiceListState.stateFilters)) {
      return false;
    }
    if (!invoice.matchesSearch(invoiceListState.search)) {
      return false;
    }
    return true;
  }).toList();

  list.sort((invoiceAId, invoiceBId) {
    var invoiceA = invoiceMap[invoiceAId];
    var invoiceB = invoiceMap[invoiceBId];
    return invoiceA.compareTo(
        invoiceB, invoiceListState.sortField, invoiceListState.sortAscending);
  });

  return list;
}
