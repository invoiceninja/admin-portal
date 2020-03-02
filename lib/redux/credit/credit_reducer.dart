import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_state.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';

EntityUIState creditUIReducer(CreditUIState state, dynamic action) {
  return state.rebuild((b) =>
  b
    ..listUIState.replace(creditListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewCredit>(
          (String selectedId, dynamic action) => action.creditId),
  TypedReducer<String, AddCreditSuccess>(
          (String selectedId, dynamic action) => action.credit.id),
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveCreditSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddCreditSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, RestoreCreditsSuccess>((credits, action) {
    return action.credits[0];
  }),
  TypedReducer<InvoiceEntity, ArchiveCreditsSuccess>((credits, action) {
    return action.credits[0];
  }),
  TypedReducer<InvoiceEntity, DeleteCreditsSuccess>((credits, action) {
    return action.credits[0];
  }),
  TypedReducer<InvoiceEntity, EditCredit>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdateCredit>((credit, action) {
    return action.credit.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, SelectCompany>(_clearEditing),
  TypedReducer<InvoiceEntity, DiscardChanges>(_clearEditing),
]);

InvoiceEntity _clearEditing(InvoiceEntity credit, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity credit, dynamic action) {
  return action.credit;
}


final creditListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortCredits>(_sortCredits),
  TypedReducer<ListUIState, FilterCreditsByState>(_filterCreditsByState),
  TypedReducer<ListUIState, FilterCredits>(_filterCredits),
  TypedReducer<ListUIState, FilterCreditsByCustom1>(_filterCreditsByCustom1),
  TypedReducer<ListUIState, FilterCreditsByCustom2>(_filterCreditsByCustom2),
  TypedReducer<ListUIState, FilterCreditsByEntity>(_filterCreditsByClient),
  TypedReducer<ListUIState, StartCreditMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToCreditMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromCreditMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearCreditMultiselect>(_clearListMultiselect),
]);

ListUIState _filterCreditsByClient(ListUIState creditListState,
    FilterCreditsByEntity action) {
  return creditListState.rebuild((b) =>
  b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterCreditsByCustom1(ListUIState creditListState,
    FilterCreditsByCustom1 action) {
  if (creditListState.custom1Filters.contains(action.value)) {
    return creditListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return creditListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterCreditsByCustom2(ListUIState creditListState,
    FilterCreditsByCustom2 action) {
  if (creditListState.custom2Filters.contains(action.value)) {
    return creditListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return creditListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterCreditsByState(ListUIState creditListState,
    FilterCreditsByState action) {
  if (creditListState.stateFilters.contains(action.state)) {
    return creditListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return creditListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterCredits(ListUIState creditListState, FilterCredits action) {
  return creditListState.rebuild((b) =>
  b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime
        .now()
        .millisecondsSinceEpoch
        : creditListState.filterClearedAt);
}

ListUIState _sortCredits(ListUIState creditListState, SortCredits action) {
  return creditListState.rebuild((b) =>
  b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(ListUIState productListState,
    StartCreditMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
  }

ListUIState _addToListMultiselect(ListUIState productListState,
    AddToCreditMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(ListUIState productListState,
    RemoveFromCreditMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(ListUIState productListState,
    ClearCreditMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
  }

final creditsReducer = combineReducers<CreditState>([
  TypedReducer<CreditState, SaveCreditSuccess>(_updateCredit),
  TypedReducer<CreditState, AddCreditSuccess>(_addCredit),
  TypedReducer<CreditState, LoadCreditsSuccess>(_setLoadedCredits),
  TypedReducer<CreditState, LoadCreditSuccess>(_setLoadedCredit),
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
  return creditState.rebuild((b) =>
  b
    ..map[action.credit.id] = action.credit
    ..list.add(action.credit.id));
}

CreditState _updateCredit(CreditState creditState, SaveCreditSuccess action) {
  return creditState.rebuild((b) =>
  b
    ..map[action.credit.id] = action.credit);
}

CreditState _setLoadedCredit(CreditState creditState,
    LoadCreditSuccess action) {
  return creditState.rebuild((b) =>
  b
    ..map[action.credit.id] = action.credit);
}

CreditState _setLoadedCredits(CreditState creditState,
    LoadCreditsSuccess action) =>
    creditState.loadCredits(action.credits);
