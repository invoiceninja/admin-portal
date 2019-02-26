import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';

EntityUIState invoiceUIReducer(InvoiceUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(invoiceListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..editingItem.replace(editingItemReducer(state.editingItem, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

final editingItemReducer = combineReducers<InvoiceItemEntity>([
  TypedReducer<InvoiceItemEntity, EditInvoice>(editInvoiceItem),
  TypedReducer<InvoiceItemEntity, EditInvoiceItem>(editInvoiceItem),
]);

InvoiceItemEntity editInvoiceItem(
    InvoiceItemEntity invoiceItem, dynamic action) {
  return action.invoiceItem ?? InvoiceItemEntity();
}

Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterInvoiceDropdown>(filterClientDropdownReducer),
]);

String filterClientDropdownReducer(
    String dropdownFilter, FilterInvoiceDropdown action) {
  return action.filter;
}

Reducer<int> selectedIdReducer = combineReducers([
  TypedReducer<int, ViewInvoice>(
      (int selectedId, dynamic action) => action.invoiceId),
  TypedReducer<int, AddInvoiceSuccess>(
      (int selectedId, dynamic action) => action.invoice.id),
  TypedReducer<int, ShowEmailInvoice>(
      (int selectedId, dynamic action) => action.invoice.id),
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, EditInvoice>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdateInvoice>(_updateEditing),
  TypedReducer<InvoiceEntity, RestoreInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, ArchiveInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, DeleteInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddInvoiceItem>(_addInvoiceItem),
  TypedReducer<InvoiceEntity, AddInvoiceItems>(_addInvoiceItems),
  TypedReducer<InvoiceEntity, DeleteInvoiceItem>(_removeInvoiceItem),
  TypedReducer<InvoiceEntity, UpdateInvoiceItem>(_updateInvoiceItem),
  TypedReducer<InvoiceEntity, SelectCompany>(_clearEditing),
]);

InvoiceEntity _clearEditing(InvoiceEntity client, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity invoice, dynamic action) {
  return action.invoice;
}

InvoiceEntity _addInvoiceItem(InvoiceEntity invoice, AddInvoiceItem action) {
  final item = action.invoiceItem ?? InvoiceItemEntity();
  return invoice.rebuild((b) => b
    ..hasTasks = b.hasTasks || item.isTask
    ..invoiceItems.add(item));
}

InvoiceEntity _addInvoiceItems(InvoiceEntity invoice, AddInvoiceItems action) {
  return invoice.rebuild((b) => b
    ..hasTasks = action.invoiceItems.where((item) => item.isTask).isNotEmpty
    ..invoiceItems.addAll(action.invoiceItems));
}

InvoiceEntity _removeInvoiceItem(
    InvoiceEntity invoice, DeleteInvoiceItem action) {
  if (invoice.invoiceItems.length <= action.index) {
    return invoice;
  }
  return invoice.rebuild((b) => b..invoiceItems.removeAt(action.index));
}

InvoiceEntity _updateInvoiceItem(
    InvoiceEntity invoice, UpdateInvoiceItem action) {
  if (invoice.invoiceItems.length <= action.index) {
    return invoice;
  }
  return invoice
      .rebuild((b) => b..invoiceItems[action.index] = action.invoiceItem);
}

final invoiceListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortInvoices>(_sortInvoices),
  TypedReducer<ListUIState, FilterInvoicesByState>(_filterInvoicesByState),
  TypedReducer<ListUIState, FilterInvoicesByStatus>(_filterInvoicesByStatus),
  TypedReducer<ListUIState, FilterInvoicesByEntity>(_filterInvoicesByEntity),
  TypedReducer<ListUIState, FilterInvoices>(_filterInvoices),
  TypedReducer<ListUIState, FilterInvoicesByCustom1>(_filterInvoicesByCustom1),
  TypedReducer<ListUIState, FilterInvoicesByCustom2>(_filterInvoicesByCustom2),
]);

ListUIState _filterInvoicesByCustom1(
    ListUIState invoiceListState, FilterInvoicesByCustom1 action) {
  if (invoiceListState.custom1Filters.contains(action.value)) {
    return invoiceListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return invoiceListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterInvoicesByCustom2(
    ListUIState invoiceListState, FilterInvoicesByCustom2 action) {
  if (invoiceListState.custom2Filters.contains(action.value)) {
    return invoiceListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return invoiceListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterInvoicesByState(
    ListUIState invoiceListState, FilterInvoicesByState action) {
  if (invoiceListState.stateFilters.contains(action.state)) {
    return invoiceListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return invoiceListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterInvoicesByStatus(
    ListUIState invoiceListState, FilterInvoicesByStatus action) {
  if (invoiceListState.statusFilters.contains(action.status)) {
    return invoiceListState
        .rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return invoiceListState.rebuild((b) => b..statusFilters.add(action.status));
  }
}

ListUIState _filterInvoicesByEntity(
    ListUIState invoiceListState, FilterInvoicesByEntity action) {
  return invoiceListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterInvoices(
    ListUIState invoiceListState, FilterInvoices action) {
  return invoiceListState.rebuild((b) => b..filter = action.filter);
}

ListUIState _sortInvoices(ListUIState invoiceListState, SortInvoices action) {
  return invoiceListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

final invoicesReducer = combineReducers<InvoiceState>([
  TypedReducer<InvoiceState, SaveInvoiceSuccess>(_updateInvoice),
  TypedReducer<InvoiceState, AddInvoiceSuccess>(_addInvoice),
  TypedReducer<InvoiceState, LoadInvoicesSuccess>(_setLoadedInvoices),
  TypedReducer<InvoiceState, LoadInvoiceSuccess>(_updateInvoice),
  TypedReducer<InvoiceState, MarkSentInvoiceSuccess>(_markSentInvoiceSuccess),
  TypedReducer<InvoiceState, ArchiveInvoiceRequest>(_archiveInvoiceRequest),
  TypedReducer<InvoiceState, ArchiveInvoiceSuccess>(_archiveInvoiceSuccess),
  TypedReducer<InvoiceState, ArchiveInvoiceFailure>(_archiveInvoiceFailure),
  TypedReducer<InvoiceState, DeleteInvoiceRequest>(_deleteInvoiceRequest),
  TypedReducer<InvoiceState, DeleteInvoiceSuccess>(_deleteInvoiceSuccess),
  TypedReducer<InvoiceState, DeleteInvoiceFailure>(_deleteInvoiceFailure),
  TypedReducer<InvoiceState, RestoreInvoiceRequest>(_restoreInvoiceRequest),
  TypedReducer<InvoiceState, RestoreInvoiceSuccess>(_restoreInvoiceSuccess),
  TypedReducer<InvoiceState, RestoreInvoiceFailure>(_restoreInvoiceFailure),
  TypedReducer<InvoiceState, ConvertQuoteSuccess>(_convertQuoteSuccess),
]);

InvoiceState _markSentInvoiceSuccess(
    InvoiceState invoiceState, MarkSentInvoiceSuccess action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _archiveInvoiceRequest(
    InvoiceState invoiceState, ArchiveInvoiceRequest action) {
  final invoice = invoiceState.map[action.invoiceId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return invoiceState.rebuild((b) => b..map[action.invoiceId] = invoice);
}

InvoiceState _archiveInvoiceSuccess(
    InvoiceState invoiceState, ArchiveInvoiceSuccess action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _archiveInvoiceFailure(
    InvoiceState invoiceState, ArchiveInvoiceFailure action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _deleteInvoiceRequest(
    InvoiceState invoiceState, DeleteInvoiceRequest action) {
  if (!invoiceState.map.containsKey(action.invoiceId)) {
    return invoiceState;
  }

  final invoice = invoiceState.map[action.invoiceId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return invoiceState.rebuild((b) => b..map[action.invoiceId] = invoice);
}

InvoiceState _deleteInvoiceSuccess(
    InvoiceState invoiceState, DeleteInvoiceSuccess action) {
  if (!invoiceState.map.containsKey(action.invoice.id)) {
    return invoiceState;
  }

  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _deleteInvoiceFailure(
    InvoiceState invoiceState, DeleteInvoiceFailure action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _restoreInvoiceRequest(
    InvoiceState invoiceState, RestoreInvoiceRequest action) {
  final invoice = invoiceState.map[action.invoiceId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return invoiceState.rebuild((b) => b..map[action.invoiceId] = invoice);
}

InvoiceState _restoreInvoiceSuccess(
    InvoiceState invoiceState, RestoreInvoiceSuccess action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _restoreInvoiceFailure(
    InvoiceState invoiceState, RestoreInvoiceFailure action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _addInvoice(InvoiceState invoiceState, AddInvoiceSuccess action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
    ..list.add(action.invoice.id));
}

InvoiceState _convertQuoteSuccess(
    InvoiceState invoiceState, ConvertQuoteSuccess action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
    ..list.add(action.invoice.id));
}

InvoiceState _updateInvoice(InvoiceState invoiceState, dynamic action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _setLoadedInvoices(
    InvoiceState invoiceState, LoadInvoicesSuccess action) {
  final state = invoiceState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.invoices,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
