// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState invoiceUIReducer(InvoiceUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(invoiceListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..editingItemIndex = editingItemIndexReducer(state.editingItemIndex, action)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action)
    ..historyActivityId =
        historyActivityIdReducer(state.historyActivityId, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewInvoice>((completer, action) => true),
  TypedReducer<bool?, ViewInvoiceList>((completer, action) => false),
  TypedReducer<bool?, FilterInvoicesByState>((completer, action) => false),
  TypedReducer<bool?, FilterInvoicesByStatus>((completer, action) => false),
  TypedReducer<bool?, FilterInvoices>((completer, action) => false),
  TypedReducer<bool?, FilterInvoicesByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterInvoicesByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterInvoicesByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterInvoicesByCustom4>((completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateInvoiceTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

final historyActivityIdReducer = combineReducers<String?>([
  TypedReducer<String?, ShowPdfInvoice>((index, action) => action.activityId),
]);

final editingItemIndexReducer = combineReducers<int?>([
  TypedReducer<int?, EditInvoice>((index, action) => action.invoiceItemIndex),
  TypedReducer<int?, EditInvoiceItem>(
      (index, action) => action.invoiceItemIndex),
]);

/*
Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterInvoiceDropdown>(filterInvoiceDropdownReducer),
]);

String filterInvoiceDropdownReducer(
    String dropdownFilter, FilterInvoiceDropdown action) {
  return action.filter;
}
*/

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveInvoicesSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteInvoicesSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.invoice ? action.entityId : selectedId),
  TypedReducer<String?, ViewInvoice>((selectedId, action) => action.invoiceId),
  TypedReducer<String?, AddInvoiceSuccess>(
      (selectedId, action) => action.invoice.id),
  TypedReducer<String?, ShowEmailInvoice>(
      (selectedId, action) => action.invoice!.id),
  TypedReducer<String?, ShowPdfInvoice>(
      (selectedId, action) => action.invoice!.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortInvoices>((selectedId, action) => ''),
  TypedReducer<String?, FilterInvoices>((selectedId, action) => ''),
  TypedReducer<String?, FilterInvoicesByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterInvoicesByStatus>((selectedId, action) => ''),
  TypedReducer<String?, FilterInvoicesByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterInvoicesByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterInvoicesByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterInvoicesByCustom4>((selectedId, action) => ''),
  TypedReducer<String?, ClearEntitySelection>((selectedId, action) =>
      action.entityType == EntityType.invoice ? '' : selectedId),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.invoice
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<InvoiceEntity?>([
  TypedReducer<InvoiceEntity?, LoadInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity?, SaveInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity?, AddInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity?, EditInvoice>(_updateEditing),
  TypedReducer<InvoiceEntity?, UpdateInvoice>((invoice, action) {
    return action.invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity?, AddInvoiceItem>((invoice, action) {
    return invoice!.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity?, MoveInvoiceItem>((invoice, action) {
    return invoice!.moveLineItem(action.oldIndex!, action.newIndex);
  }),
  TypedReducer<InvoiceEntity?, DeleteInvoiceItem>((invoice, action) {
    return invoice!.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity?, UpdateInvoiceItem>((invoice, action) {
    return invoice!.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity?, UpdateInvoiceClient>((invoice, action) {
    final client = action.client;
    return invoice!.rebuild((b) => b
      ..isChanged = true
      ..clientId = client?.id ?? ''
      ..invitations.replace((client?.emailContacts ?? <ClientContactEntity>[])
          .map((contact) => InvitationEntity(clientContactId: contact.id))
          .toList()));
  }),
  TypedReducer<InvoiceEntity?, RestoreInvoicesSuccess>((invoices, action) {
    return action.invoices[0];
  }),
  TypedReducer<InvoiceEntity?, ArchiveInvoicesSuccess>((invoices, action) {
    return action.invoices[0];
  }),
  TypedReducer<InvoiceEntity?, DeleteInvoicesSuccess>((invoices, action) {
    return action.invoices[0];
  }),
  TypedReducer<InvoiceEntity?, AddInvoiceItem>(_addInvoiceItem),
  TypedReducer<InvoiceEntity?, AddInvoiceItems>(_addInvoiceItems),
  TypedReducer<InvoiceEntity?, DeleteInvoiceItem>(_removeInvoiceItem),
  TypedReducer<InvoiceEntity?, UpdateInvoiceItem>(_updateInvoiceItem),
  TypedReducer<InvoiceEntity?, DiscardChanges>(_clearEditing),
  TypedReducer<InvoiceEntity?, AddInvoiceContact>((invoice, action) {
    return invoice!.rebuild((b) => b
      ..invitations.add(action.invitation ??
          InvitationEntity(clientContactId: action.contact!.id)));
  }),
  TypedReducer<InvoiceEntity?, RemoveInvoiceContact>((invoice, action) {
    return invoice!.rebuild((b) => b..invitations.remove(action.invitation));
  }),
]);

InvoiceEntity _clearEditing(InvoiceEntity? invoice, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity? invoice, dynamic action) {
  return (action.invoice as InvoiceEntity)
      .rebuild((b) => b..idempotencyKey = BaseEntity.nextIdempotencyKey);
}

InvoiceEntity _addInvoiceItem(InvoiceEntity? invoice, AddInvoiceItem action) {
  final item = action.invoiceItem ?? InvoiceItemEntity();
  if (action.index == null) {
    return invoice!.rebuild((b) => b..lineItems.add(item));
  } else {
    return invoice!.rebuild((b) => b..lineItems.insert(action.index!, item));
  }
}

InvoiceEntity _addInvoiceItems(InvoiceEntity? invoice, AddInvoiceItems action) {
  return invoice!.rebuild((b) => b..lineItems.addAll(action.lineItems));
}

InvoiceEntity? _removeInvoiceItem(
    InvoiceEntity? invoice, DeleteInvoiceItem action) {
  if (invoice!.lineItems.length <= action.index) {
    return invoice;
  }
  return invoice.rebuild((b) => b..lineItems.removeAt(action.index));
}

InvoiceEntity? _updateInvoiceItem(
    InvoiceEntity? invoice, UpdateInvoiceItem action) {
  if (invoice!.lineItems.length <= action.index) {
    return invoice;
  }
  return invoice
      .rebuild((b) => b..lineItems[action.index] = action.invoiceItem);
}

final invoiceListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortInvoices>(_sortInvoices),
  TypedReducer<ListUIState, FilterInvoicesByState>(_filterInvoicesByState),
  TypedReducer<ListUIState, FilterInvoicesByStatus>(_filterInvoicesByStatus),
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
  TypedReducer<ListUIState, ViewInvoiceList>(_viewInvoiceList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewInvoiceList(
    ListUIState invoiceListState, ViewInvoiceList action) {
  return invoiceListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

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
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState invoiceListState, StartInvoiceMultiselect action) {
  return invoiceListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState invoiceListState, AddToInvoiceMultiselect action) {
  return invoiceListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState invoiceListState, RemoveFromInvoiceMultiselect action) {
  return invoiceListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState invoiceListState, ClearInvoiceMultiselect action) {
  return invoiceListState.rebuild((b) => b..selectedIds = null);
}

final invoicesReducer = combineReducers<InvoiceState>([
  TypedReducer<InvoiceState, SaveInvoiceSuccess>(_updateInvoice),
  TypedReducer<InvoiceState, AddInvoiceSuccess>(_addInvoice),
  TypedReducer<InvoiceState, LoadInvoicesSuccess>(_setLoadedInvoices),
  TypedReducer<InvoiceState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<InvoiceState, LoadInvoiceSuccess>(_updateInvoice),
  TypedReducer<InvoiceState, MarkInvoicesSentSuccess>(_markInvoicesSentSuccess),
  TypedReducer<InvoiceState, MarkInvoicesPaidSuccess>(_markInvoicesPaidSuccess),
  TypedReducer<InvoiceState, CancelInvoicesSuccess>(_cancelInvoicesSuccess),
  TypedReducer<InvoiceState, EmailInvoiceSuccess>(_emailInvoiceSuccess),
  TypedReducer<InvoiceState, ArchiveInvoicesSuccess>(_archiveInvoiceSuccess),
  TypedReducer<InvoiceState, DeleteInvoicesSuccess>(_deleteInvoiceSuccess),
  TypedReducer<InvoiceState, RestoreInvoicesSuccess>(_restoreInvoiceSuccess),
  TypedReducer<InvoiceState, PurgeClientSuccess>(_purgeClientSuccess),
]);

InvoiceState _purgeClientSuccess(
    InvoiceState invoiceState, PurgeClientSuccess action) {
  final ids = invoiceState.map.values
      .where((each) => each.clientId == action.clientId)
      .map((each) => each.id)
      .toList();

  return invoiceState.rebuild((b) => b
    ..map.removeWhere((p0, p1) => ids.contains(p0))
    ..list.removeWhere((p0) => ids.contains(p0)));
}

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

InvoiceState _cancelInvoicesSuccess(
    InvoiceState invoiceState, CancelInvoicesSuccess action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
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

InvoiceState _deleteInvoiceSuccess(
    InvoiceState invoiceState, DeleteInvoicesSuccess action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _emailInvoiceSuccess(
    InvoiceState invoiceState, EmailInvoiceSuccess action) {
  return invoiceState
      .rebuild((b) => b..map[action.invoice.id] = action.invoice);
}

InvoiceState _restoreInvoiceSuccess(
    InvoiceState invoiceState, RestoreInvoicesSuccess action) {
  return invoiceState.rebuild((b) {
    for (final invoice in action.invoices) {
      b.map[invoice.id] = invoice;
    }
  });
}

InvoiceState _addInvoice(InvoiceState invoiceState, AddInvoiceSuccess action) {
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = action.invoice
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch)
    ..list.add(action.invoice.id));
}

InvoiceState _updateInvoice(InvoiceState invoiceState, dynamic action) {
  final InvoiceEntity? invoice = action.invoice;
  return invoiceState.rebuild((b) => b
    ..map[action.invoice.id] = invoice!
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

InvoiceState _setLoadedInvoices(
        InvoiceState invoiceState, LoadInvoicesSuccess action) =>
    invoiceState.loadInvoices(action.invoices);

InvoiceState _setLoadedCompany(
    InvoiceState invoiceState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return invoiceState.loadInvoices(company.invoices);
}
