import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedFilteredRecurringInvoiceList = memo8((
  String filterEntityId,
  EntityType filterEntityType,
  BuiltMap<String, InvoiceEntity> recurringInvoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltList<String> recurringInvoiceList,
  ListUIState recurringInvoiceListState,
  StaticState staticState,
  BuiltMap<String, UserEntity> userMap,
) =>
    filteredRecurringInvoicesSelector(
      filterEntityId,
      filterEntityType,
      recurringInvoiceMap,
      clientMap,
      recurringInvoiceList,
      recurringInvoiceListState,
      staticState,
      userMap,
    ));

List<String> filteredRecurringInvoicesSelector(
  String filterEntityId,
  EntityType filterEntityType,
  BuiltMap<String, InvoiceEntity> recurringInvoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltList<String> recurringInvoiceList,
  ListUIState recurringInvoiceListState,
  StaticState staticState,
  BuiltMap<String, UserEntity> userMap,
) {
  final list = recurringInvoiceList.where((recurringInvoiceId) {
    final recurringInvoice = recurringInvoiceMap[recurringInvoiceId];
    if (filterEntityId != null && recurringInvoice.id != filterEntityId) {
      return false;
    } else {}

    if (!recurringInvoice
        .matchesStates(recurringInvoiceListState.stateFilters)) {
      return false;
    }
    if (recurringInvoiceListState.custom1Filters.isNotEmpty &&
        !recurringInvoiceListState.custom1Filters
            .contains(recurringInvoice.customValue1)) {
      return false;
    }
    if (recurringInvoiceListState.custom2Filters.isNotEmpty &&
        !recurringInvoiceListState.custom2Filters
            .contains(recurringInvoice.customValue2)) {
      return false;
    }
    return recurringInvoice.matchesFilter(recurringInvoiceListState.filter);
  }).toList();

  list.sort((recurringInvoiceAId, recurringInvoiceBId) {
    final recurringInvoiceA = recurringInvoiceMap[recurringInvoiceAId];
    final recurringInvoiceB = recurringInvoiceMap[recurringInvoiceBId];

    return recurringInvoiceA.compareTo(
      invoice: recurringInvoiceB,
      sortField: recurringInvoiceListState.sortField,
      sortAscending: recurringInvoiceListState.sortAscending,
      clientMap: clientMap,
      staticState: staticState,
      userMap: userMap,
    );
  });

  return list;
}

bool hasRecurringInvoiceChanges(InvoiceEntity recurringInvoice,
        BuiltMap<String, InvoiceEntity> recurringInvoiceMap) =>
    recurringInvoice.isNew
        ? recurringInvoice.isChanged
        : recurringInvoice != recurringInvoiceMap[recurringInvoice.id];
