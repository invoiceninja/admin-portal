import 'package:invoiceninja/data/models/invoice_model.dart';
import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/redux/invoice/invoice_state.dart';

EntityUIState invoiceUIReducer(InvoiceUIState state, action) {
  return state.rebuild((b) => b
    ..listUIState.replace(invoiceListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
  );
}

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, SelectInvoice>(_updateEditing),
]);

InvoiceEntity _updateEditing(InvoiceEntity client, action) {
  return action.client;
}

final invoiceListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortInvoices>(_sortInvoices),
  TypedReducer<ListUIState, FilterInvoicesByState>(_filterInvoicesByState),
  TypedReducer<ListUIState, SearchInvoices>(_searchInvoices),
]);

ListUIState _filterInvoicesByState(ListUIState invoiceListState, FilterInvoicesByState action) {
  if (invoiceListState.stateFilters.contains(action.state)) {
    return invoiceListState.rebuild((b) => b
        ..stateFilters.remove(action.state)
    );
  } else {
    return invoiceListState.rebuild((b) => b
        ..stateFilters.add(action.state)
    );
  }
}

ListUIState _searchInvoices(ListUIState invoiceListState, SearchInvoices action) {
  return invoiceListState.rebuild((b) => b
    ..search = action.search
  );
}

ListUIState _sortInvoices(ListUIState invoiceListState, SortInvoices action) {
  return invoiceListState.rebuild((b) => b
      ..sortAscending = b.sortField != action.field || ! b.sortAscending
      ..sortField = action.field
  );
}


final invoicesReducer = combineReducers<InvoiceState>([
  TypedReducer<InvoiceState, SaveInvoiceSuccess>(_updateInvoice),
  TypedReducer<InvoiceState, AddInvoiceSuccess>(_addInvoice),
  TypedReducer<InvoiceState, LoadInvoicesSuccess>(_setLoadedInvoices),
  TypedReducer<InvoiceState, LoadInvoicesFailure>(_setNoInvoices),

  TypedReducer<InvoiceState, ArchiveInvoiceRequest>(_archiveInvoiceRequest),
  TypedReducer<InvoiceState, ArchiveInvoiceSuccess>(_archiveInvoiceSuccess),
  TypedReducer<InvoiceState, ArchiveInvoiceFailure>(_archiveInvoiceFailure),

  TypedReducer<InvoiceState, DeleteInvoiceRequest>(_deleteInvoiceRequest),
  TypedReducer<InvoiceState, DeleteInvoiceSuccess>(_deleteInvoiceSuccess),
  TypedReducer<InvoiceState, DeleteInvoiceFailure>(_deleteInvoiceFailure),

  TypedReducer<InvoiceState, RestoreInvoiceRequest>(_restoreInvoiceRequest),
  TypedReducer<InvoiceState, RestoreInvoiceSuccess>(_restoreInvoiceSuccess),
  TypedReducer<InvoiceState, RestoreInvoiceFailure>(_restoreInvoiceFailure),
]);

InvoiceState _archiveInvoiceRequest(InvoiceState invoiceState, ArchiveInvoiceRequest action) {
  var invoice = invoiceState.map[action.invoiceId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
  );

  return invoiceState.rebuild((b) => b
    ..map[action.invoiceId] = invoice
  );
}

InvoiceState _archiveInvoiceSuccess(InvoiceState invoiceState, ArchiveInvoiceSuccess action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
  );
}

InvoiceState _archiveInvoiceFailure(InvoiceState invoiceState, ArchiveInvoiceFailure action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
  );
}

InvoiceState _deleteInvoiceRequest(InvoiceState invoiceState, DeleteInvoiceRequest action) {
  var invoice = invoiceState.map[action.invoiceId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true
  );

  return invoiceState.rebuild((b) => b
    ..map[action.invoiceId] = invoice
  );
}

InvoiceState _deleteInvoiceSuccess(InvoiceState invoiceState, DeleteInvoiceSuccess action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
  );
}

InvoiceState _deleteInvoiceFailure(InvoiceState invoiceState, DeleteInvoiceFailure action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
  );
}


InvoiceState _restoreInvoiceRequest(InvoiceState invoiceState, RestoreInvoiceRequest action) {
  var invoice = invoiceState.map[action.invoiceId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false
  );
  return invoiceState.rebuild((b) => b
    ..map[action.invoiceId] = invoice
  );
}

InvoiceState _restoreInvoiceSuccess(InvoiceState invoiceState, RestoreInvoiceSuccess action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
  );
}

InvoiceState _restoreInvoiceFailure(InvoiceState invoiceState, RestoreInvoiceFailure action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
  );
}


InvoiceState _addInvoice(
    InvoiceState invoiceState, AddInvoiceSuccess action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
    ..list.add(action.invoice.id)
  );
}

InvoiceState _updateInvoice(
    InvoiceState invoiceState, SaveInvoiceSuccess action) {
  return invoiceState.rebuild((b) => b
      ..map[action.invoice.id] = action.invoice
  );
}

InvoiceState _setNoInvoices(
    InvoiceState invoiceState, LoadInvoicesFailure action) {
  return invoiceState;
}

InvoiceState _setLoadedInvoices(
    InvoiceState invoiceState, LoadInvoicesSuccess action) {
  return invoiceState.rebuild(
    (b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(Map.fromIterable(
        action.invoices,
        key: (item) => item.id,
        value: (item) => item,
      ))
      ..list.replace(action.invoices.map(
              (invoice) => invoice.id).toList())
  );
}
