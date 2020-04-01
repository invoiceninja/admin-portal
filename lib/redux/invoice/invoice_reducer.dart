import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';

EntityUIState invoiceUIReducer(InvoiceUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(invoiceListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..editingItemIndex = editingItemIndexReducer(state.editingItemIndex, action)
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

final editingItemIndexReducer = combineReducers<int>([
  TypedReducer<int, EditInvoice>((index, action) => action.invoiceItemIndex),
  TypedReducer<int, EditInvoiceItem>(
      (index, action) => action.invoiceItemIndex),
]);

Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterInvoiceDropdown>(filterInvoiceDropdownReducer),
]);

String filterInvoiceDropdownReducer(
    String dropdownFilter, FilterInvoiceDropdown action) {
  return action.filter;
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewInvoice>((selectedId, action) => action.invoiceId),
  TypedReducer<String, AddInvoiceSuccess>(
      (selectedId, action) => action.invoice.id),
  TypedReducer<String, ShowEmailInvoice>(
      (selectedId, action) => action.invoice.id),
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, EditInvoice>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdateInvoice>((invoice, action) {
    return action.invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, AddInvoiceItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, DeleteInvoiceItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, UpdateInvoiceItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, UpdateInvoiceClient>((invoice, action) {
    final client = action.client;
    return invoice.rebuild((b) => b
      ..isChanged = true
      ..clientId = client?.id ?? ''
      ..invitations.addAll((client?.contacts ?? <ContactEntity>[])
          .where((contact) => contact.sendEmail)
          .map((contact) => InvitationEntity(contactId: contact.id))));
  }),
  TypedReducer<InvoiceEntity, RestoreInvoicesSuccess>((invoices, action) {
    return action.invoices[0];
  }),
  TypedReducer<InvoiceEntity, ArchiveInvoicesSuccess>((invoices, action) {
    return action.invoices[0];
  }),
  TypedReducer<InvoiceEntity, DeleteInvoicesSuccess>((invoices, action) {
    return action.invoices[0];
  }),
  TypedReducer<InvoiceEntity, AddInvoiceItem>(_addInvoiceItem),
  TypedReducer<InvoiceEntity, AddInvoiceItems>(_addInvoiceItems),
  TypedReducer<InvoiceEntity, DeleteInvoiceItem>(_removeInvoiceItem),
  TypedReducer<InvoiceEntity, UpdateInvoiceItem>(_updateInvoiceItem),
  TypedReducer<InvoiceEntity, SelectCompany>(_clearEditing),
  TypedReducer<InvoiceEntity, DiscardChanges>(_clearEditing),
  TypedReducer<InvoiceEntity, AddInvoiceContact>((invoice, action) {
    return invoice.rebuild((b) => b
      ..invitations.add(
          action.invitation ?? InvitationEntity(contactId: action.contact.id)));
  }),
  TypedReducer<InvoiceEntity, RemoveInvoiceContact>((invoice, action) {
    return invoice.rebuild((b) => b..invitations.remove(action.invitation));
  }),
]);

InvoiceEntity _clearEditing(InvoiceEntity invoice, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity invoice, dynamic action) {
  return action.invoice;
}

InvoiceEntity _addInvoiceItem(InvoiceEntity invoice, AddInvoiceItem action) {
  final item = action.invoiceItem ?? InvoiceItemEntity();
  return invoice.rebuild((b) => b
    ..hasTasks = b.hasTasks || item.isTask
    ..hasExpenses = b.hasExpenses || item.isExpense
    ..lineItems.add(item));
}

InvoiceEntity _addInvoiceItems(InvoiceEntity invoice, AddInvoiceItems action) {
  return invoice.rebuild((b) => b
    ..hasTasks = action.lineItems.where((item) => item.isTask).isNotEmpty
    ..hasExpenses = action.lineItems.where((item) => item.isExpense).isNotEmpty
    ..lineItems.addAll(action.lineItems));
}

InvoiceEntity _removeInvoiceItem(
    InvoiceEntity invoice, DeleteInvoiceItem action) {
  if (invoice.lineItems.length <= action.index) {
    return invoice;
  }
  return invoice.rebuild((b) => b..lineItems.removeAt(action.index));
}

InvoiceEntity _updateInvoiceItem(
    InvoiceEntity invoice, UpdateInvoiceItem action) {
  if (invoice.lineItems.length <= action.index) {
    return invoice;
  }
  return invoice
      .rebuild((b) => b..lineItems[action.index] = action.invoiceItem);
}

final invoiceListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortInvoices>(_sortInvoices),
  TypedReducer<ListUIState, FilterInvoicesByState>(_filterInvoicesByState),
  TypedReducer<ListUIState, FilterInvoicesByStatus>(_filterInvoicesByStatus),
  TypedReducer<ListUIState, FilterInvoicesByEntity>(_filterInvoicesByEntity),
  TypedReducer<ListUIState, FilterInvoices>(_filterInvoices),
  TypedReducer<ListUIState, FilterInvoicesByCustom1>(_filterInvoicesByCustom1),
  TypedReducer<ListUIState, FilterInvoicesByCustom2>(_filterInvoicesByCustom2),
  TypedReducer<ListUIState, FilterInvoicesByCustom3>(_filterInvoicesByCustom3),
  TypedReducer<ListUIState, FilterInvoicesByCustom4>(_filterInvoicesByCustom4),
  TypedReducer<ListUIState, StartInvoiceMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToInvoiceMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromInvoiceMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearInvoiceMultiselect>(_clearListMultiselect),
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

ListUIState _filterInvoicesByCustom3(
    ListUIState invoiceListState, FilterInvoicesByCustom3 action) {
  if (invoiceListState.custom3Filters.contains(action.value)) {
    return invoiceListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return invoiceListState.rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterInvoicesByCustom4(
    ListUIState invoiceListState, FilterInvoicesByCustom4 action) {
  if (invoiceListState.custom4Filters.contains(action.value)) {
    return invoiceListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return invoiceListState.rebuild((b) => b..custom4Filters.add(action.value));
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
  return invoiceListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : invoiceListState.filterClearedAt);
}

ListUIState _sortInvoices(ListUIState invoiceListState, SortInvoices action) {
  return invoiceListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState invoiceListState, StartInvoiceMultiselect action) {
  return invoiceListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState invoiceListState, AddToInvoiceMultiselect action) {
  return invoiceListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState invoiceListState, RemoveFromInvoiceMultiselect action) {
  return invoiceListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState invoiceListState, ClearInvoiceMultiselect action) {
  return invoiceListState.rebuild((b) => b..selectedIds = null);
}

final invoicesReducer = combineReducers<InvoiceState>([
  TypedReducer<InvoiceState, SaveInvoiceSuccess>(_updateInvoice),
  TypedReducer<InvoiceState, AddInvoiceSuccess>(_addInvoice),
  TypedReducer<InvoiceState, LoadInvoicesSuccess>(_setLoadedInvoices),
  TypedReducer<InvoiceState, LoadInvoiceSuccess>(_updateInvoice),
  TypedReducer<InvoiceState, MarkInvoicesSentSuccess>(_markInvoicesSentSuccess),
  TypedReducer<InvoiceState, MarkInvoicesPaidSuccess>(_markInvoicesPaidSuccess),
  TypedReducer<InvoiceState, ArchiveInvoicesRequest>(_archiveInvoiceRequest),
  TypedReducer<InvoiceState, ArchiveInvoicesSuccess>(_archiveInvoiceSuccess),
  TypedReducer<InvoiceState, ArchiveInvoicesFailure>(_archiveInvoiceFailure),
  TypedReducer<InvoiceState, DeleteInvoicesRequest>(_deleteInvoiceRequest),
  TypedReducer<InvoiceState, DeleteInvoicesSuccess>(_deleteInvoiceSuccess),
  TypedReducer<InvoiceState, DeleteInvoicesFailure>(_deleteInvoiceFailure),
  TypedReducer<InvoiceState, RestoreInvoicesRequest>(_restoreInvoiceRequest),
  TypedReducer<InvoiceState, RestoreInvoicesSuccess>(_restoreInvoiceSuccess),
  TypedReducer<InvoiceState, RestoreInvoicesFailure>(_restoreInvoiceFailure),
]);

InvoiceState _markInvoicesSentSuccess(
    InvoiceState invoiceState, MarkInvoicesSentSuccess action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _markInvoicesPaidSuccess(
    InvoiceState invoiceState, MarkInvoicesPaidSuccess action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _archiveInvoiceRequest(
    InvoiceState invoiceState, ArchiveInvoicesRequest action) {
  final invoices = action.invoiceIds.map((id) => invoiceState.map[id]).toList();

  for (int i = 0; i < invoices.length; i++) {
    invoices[i] = invoices[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }

  return invoiceState.rebuild((b) {
    for (final invoice in invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _archiveInvoiceSuccess(
    InvoiceState invoiceState, ArchiveInvoicesSuccess action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _archiveInvoiceFailure(
    InvoiceState invoiceState, ArchiveInvoicesFailure action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _deleteInvoiceRequest(
    InvoiceState invoiceState, DeleteInvoicesRequest action) {
  final invoices = action.invoiceIds.map((id) => invoiceState.map[id]).toList();

  for (int i = 0; i < invoices.length; i++) {
    invoices[i] = invoices[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return invoiceState.rebuild((b) {
    for (final invoice in invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _deleteInvoiceSuccess(
    InvoiceState invoiceState, DeleteInvoicesSuccess action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _deleteInvoiceFailure(
    InvoiceState invoiceState, DeleteInvoicesFailure action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _restoreInvoiceRequest(
    InvoiceState invoiceState, RestoreInvoicesRequest action) {
  final invoices = action.invoiceIds.map((id) => invoiceState.map[id]).toList();

  for (int i = 0; i < invoices.length; i++) {
    invoices[i] = invoices[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return invoiceState.rebuild((b) {
    for (final invoice in invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _restoreInvoiceSuccess(
    InvoiceState invoiceState, RestoreInvoicesSuccess action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _restoreInvoiceFailure(
    InvoiceState invoiceState, RestoreInvoicesFailure action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _addInvoice(InvoiceState invoiceState, AddInvoiceSuccess action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
    ..list.add(action.invoice.id));
}

InvoiceState _updateInvoice(InvoiceState invoiceState, dynamic action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _setLoadedInvoices(
        InvoiceState invoiceState, LoadInvoicesSuccess action) =>
    invoiceState.loadInvoices(action.invoices);
