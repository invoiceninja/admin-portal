import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';

EntityUIState creditUIReducer(CreditUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(creditListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..editingItemIndex = editingItemReducer(state.editingItemIndex, action)
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

final editingItemReducer = combineReducers<int>([
  TypedReducer<int, EditCredit>((index, action) => action.creditItemIndex),
  TypedReducer<int, EditCreditItem>((index, action) => action.creditItemIndex),
]);

Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterCreditDropdown>(filtercreditDropdownReducer),
]);

String filtercreditDropdownReducer(
    String dropdownFilter, FilterCreditDropdown action) {
  return action.filter;
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewCredit>((selectedId, action) => action.creditId),
  TypedReducer<String, AddCreditSuccess>(
      (selectedId, action) => action.credit.id),
  TypedReducer<String, ShowEmailCredit>(
      (selectedId, action) => action.credit.id),
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveCreditSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddCreditSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, EditCredit>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdateCredit>((credit, action) {
    return action.credit.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, AddCreditItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, DeleteCreditItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, UpdateCreditItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, UpdateCreditClient>((credit, action) {
    final client = action.client;
    return credit.rebuild((b) => b
      ..isChanged = true
      ..clientId = client.id
      ..invitations.addAll(client.contacts
          .map((contact) => InvitationEntity(contactId: contact.id))));
  }),
  TypedReducer<InvoiceEntity, RestoreCreditsSuccess>((credits, action) {
    return action.credits[0];
  }),
  TypedReducer<InvoiceEntity, ArchiveCreditsSuccess>((credits, action) {
    return action.credits[0];
  }),
  TypedReducer<InvoiceEntity, DeleteCreditsSuccess>((credits, action) {
    return action.credits[0];
  }),
  TypedReducer<InvoiceEntity, AddCreditItem>(_addCreditItem),
  TypedReducer<InvoiceEntity, AddCreditItems>(_addCreditItems),
  TypedReducer<InvoiceEntity, DeleteCreditItem>(_removeCreditItem),
  TypedReducer<InvoiceEntity, UpdateCreditItem>(_updateCreditItem),
  TypedReducer<InvoiceEntity, SelectCompany>(_clearEditing),
  TypedReducer<InvoiceEntity, DiscardChanges>(_clearEditing),
  TypedReducer<InvoiceEntity, AddCreditContact>((invoice, action) {
    return invoice.rebuild((b) => b
      ..invitations.add(
          action.invitation ?? InvitationEntity(contactId: action.contact.id)));
  }),
  TypedReducer<InvoiceEntity, RemoveCreditContact>((invoice, action) {
    return invoice.rebuild((b) => b..invitations.remove(action.invitation));
  }),
]);

InvoiceEntity _clearEditing(InvoiceEntity credit, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity credit, dynamic action) {
  return action.credit;
}

InvoiceEntity _addCreditItem(InvoiceEntity credit, AddCreditItem action) {
  return credit.rebuild(
      (b) => b..lineItems.add(action.creditItem ?? InvoiceItemEntity()));
}

InvoiceEntity _addCreditItems(InvoiceEntity credit, AddCreditItems action) {
  return credit.rebuild((b) => b..lineItems.addAll(action.creditItems));
}

InvoiceEntity _removeCreditItem(InvoiceEntity credit, DeleteCreditItem action) {
  if (credit.lineItems.length <= action.index) {
    return credit;
  }
  return credit.rebuild((b) => b..lineItems.removeAt(action.index));
}

InvoiceEntity _updateCreditItem(InvoiceEntity credit, UpdateCreditItem action) {
  if (credit.lineItems.length <= action.index) {
    return credit;
  }
  return credit.rebuild((b) => b..lineItems[action.index] = action.creditItem);
}

final creditListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortCredits>(_sortCredits),
  TypedReducer<ListUIState, FilterCreditsByState>(_filterCreditsByState),
  TypedReducer<ListUIState, FilterCreditsByStatus>(_filterCreditsByStatus),
  TypedReducer<ListUIState, FilterCreditsByEntity>(_filterCreditsByEntity),
  TypedReducer<ListUIState, FilterCredits>(_filterCredits),
  TypedReducer<ListUIState, FilterCreditsByCustom1>(_filterCreditsByCustom1),
  TypedReducer<ListUIState, FilterCreditsByCustom2>(_filterCreditsByCustom2),
  TypedReducer<ListUIState, FilterCreditsByCustom3>(_filterCreditsByCustom3),
  TypedReducer<ListUIState, FilterCreditsByCustom4>(_filterCreditsByCustom4),
  TypedReducer<ListUIState, StartCreditMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToCreditMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromCreditMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearCreditMultiselect>(_clearListMultiselect),
]);

ListUIState _filterCreditsByCustom1(
    ListUIState creditListState, FilterCreditsByCustom1 action) {
  if (creditListState.custom1Filters.contains(action.value)) {
    return creditListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return creditListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterCreditsByCustom2(
    ListUIState creditListState, FilterCreditsByCustom2 action) {
  if (creditListState.custom2Filters.contains(action.value)) {
    return creditListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return creditListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterCreditsByCustom3(
    ListUIState creditListState, FilterCreditsByCustom3 action) {
  if (creditListState.custom3Filters.contains(action.value)) {
    return creditListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return creditListState.rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterCreditsByCustom4(
    ListUIState creditListState, FilterCreditsByCustom4 action) {
  if (creditListState.custom4Filters.contains(action.value)) {
    return creditListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return creditListState.rebuild((b) => b..custom4Filters.add(action.value));
  }
}

ListUIState _filterCreditsByState(
    ListUIState creditListState, FilterCreditsByState action) {
  if (creditListState.stateFilters.contains(action.state)) {
    return creditListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return creditListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterCreditsByStatus(
    ListUIState creditListState, FilterCreditsByStatus action) {
  if (creditListState.statusFilters.contains(action.status)) {
    return creditListState
        .rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return creditListState.rebuild((b) => b..statusFilters.add(action.status));
  }
}

ListUIState _filterCreditsByEntity(
    ListUIState creditListState, FilterCreditsByEntity action) {
  return creditListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterCredits(ListUIState creditListState, FilterCredits action) {
  return creditListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : creditListState.filterClearedAt);
}

ListUIState _sortCredits(ListUIState creditListState, SortCredits action) {
  return creditListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState creditListState, StartCreditMultiselect action) {
  return creditListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState creditListState, AddToCreditMultiselect action) {
  return creditListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState creditListState, RemoveFromCreditMultiselect action) {
  return creditListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState creditListState, ClearCreditMultiselect action) {
  return creditListState.rebuild((b) => b..selectedIds = null);
}

final creditsReducer = combineReducers<CreditState>([
  TypedReducer<CreditState, SaveCreditSuccess>(_updateCredit),
  TypedReducer<CreditState, AddCreditSuccess>(_addCredit),
  TypedReducer<CreditState, LoadCreditsSuccess>(_setLoadedCredits),
  TypedReducer<CreditState, LoadCreditSuccess>(_updateCredit),
  TypedReducer<CreditState, MarkSentCreditSuccess>(_markSentCreditSuccess),
  TypedReducer<CreditState, ArchiveCreditsRequest>(_archiveCreditRequest),
  TypedReducer<CreditState, ArchiveCreditsSuccess>(_archiveCreditSuccess),
  TypedReducer<CreditState, ArchiveCreditsFailure>(_archiveCreditFailure),
  TypedReducer<CreditState, DeleteCreditsRequest>(_deleteCreditRequest),
  TypedReducer<CreditState, DeleteCreditsSuccess>(_deleteCreditSuccess),
  TypedReducer<CreditState, DeleteCreditsFailure>(_deleteCreditFailure),
  TypedReducer<CreditState, RestoreCreditsRequest>(_restoreCreditRequest),
  TypedReducer<CreditState, RestoreCreditsSuccess>(_restoreCreditSuccess),
  TypedReducer<CreditState, RestoreCreditsFailure>(_restoreCreditFailure),
]);

CreditState _markSentCreditSuccess(
    CreditState creditState, MarkSentCreditSuccess action) {
  final creditMap = Map<String, InvoiceEntity>.fromIterable(
    action.credits,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return creditState.rebuild((b) => b..map.addAll(creditMap));
}

CreditState _archiveCreditRequest(
    CreditState creditState, ArchiveCreditsRequest action) {
  final credits = action.creditIds.map((id) => creditState.map[id]).toList();

  for (int i = 0; i < credits.length; i++) {
    credits[i] = credits[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return creditState.rebuild((b) {
    for (final credit in credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _archiveCreditSuccess(
    CreditState creditState, ArchiveCreditsSuccess action) {
  return creditState.rebuild((b) {
    for (final credit in action.credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _archiveCreditFailure(
    CreditState creditState, ArchiveCreditsFailure action) {
  return creditState.rebuild((b) {
    for (final credit in action.credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _deleteCreditRequest(
    CreditState creditState, DeleteCreditsRequest action) {
  final credits = action.creditIds.map((id) => creditState.map[id]).toList();

  for (int i = 0; i < credits.length; i++) {
    credits[i] = credits[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return creditState.rebuild((b) {
    for (final credit in credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _deleteCreditSuccess(
    CreditState creditState, DeleteCreditsSuccess action) {
  return creditState.rebuild((b) {
    for (final credit in action.credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _deleteCreditFailure(
    CreditState creditState, DeleteCreditsFailure action) {
  return creditState.rebuild((b) {
    for (final credit in action.credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _restoreCreditRequest(
    CreditState creditState, RestoreCreditsRequest action) {
  final credits = action.creditIds.map((id) => creditState.map[id]).toList();

  for (int i = 0; i < credits.length; i++) {
    credits[i] = credits[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return creditState.rebuild((b) {
    for (final credit in credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _restoreCreditSuccess(
    CreditState creditState, RestoreCreditsSuccess action) {
  return creditState.rebuild((b) {
    for (final credit in action.credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _restoreCreditFailure(
    CreditState creditState, RestoreCreditsFailure action) {
  return creditState.rebuild((b) {
    for (final credit in action.credits) {
      b.map[credit.id] = credit;
    }
  });
}

CreditState _addCredit(CreditState creditState, AddCreditSuccess action) {
  return creditState.rebuild((b) => b
    ..map[action.credit.id] = action.credit
    ..list.add(action.credit.id));
}

CreditState _updateCredit(CreditState creditState, dynamic action) {
  return creditState.rebuild((b) => b..map[action.credit.id] = action.credit);
}

CreditState _setLoadedCredits(
        CreditState creditState, LoadCreditsSuccess action) =>
    creditState.loadCredits(action.credits);
