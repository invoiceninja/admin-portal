import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';

EntityUIState quoteUIReducer(QuoteUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(quoteListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..editingItem.replace(editingItemReducer(state.editingItem, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

final editingItemReducer = combineReducers<InvoiceItemEntity>([
  TypedReducer<InvoiceItemEntity, EditQuote>(editQuoteItem),
  TypedReducer<InvoiceItemEntity, EditQuoteItem>(editQuoteItem),
]);

InvoiceItemEntity editQuoteItem(InvoiceItemEntity quoteItem, dynamic action) {
  return action.quoteItem ?? InvoiceItemEntity();
}

Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterQuoteDropdown>(filterquoteDropdownReducer),
]);

String filterquoteDropdownReducer(
    String dropdownFilter, FilterQuoteDropdown action) {
  return action.filter;
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewQuote>((selectedId, action) => action.quoteId),
  TypedReducer<String, AddQuoteSuccess>(
      (selectedId, action) => action.quote.id),
  TypedReducer<String, ShowEmailQuote>((selectedId, action) => action.quote.id),
  TypedReducer<String, FilterQuotesByEntity>(
      (selectedId, action) => action.entityId == null ? selectedId : '')
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, EditQuote>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdateQuote>((quote, action) {
    return action.quote.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, UpdateQuoteClient>((quote, action) {
    final client = action.client;
    return quote.rebuild((b) => b
      ..isChanged = true
      ..clientId = client.id
      ..invitations.addAll(client.contacts
          .map((contact) => InvitationEntity(contactId: contact.id))));
  }),
  TypedReducer<InvoiceEntity, RestoreQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, ArchiveQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, DeleteQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddQuoteItem>(_addQuoteItem),
  TypedReducer<InvoiceEntity, AddQuoteItems>(_addQuoteItems),
  TypedReducer<InvoiceEntity, DeleteQuoteItem>(_removeQuoteItem),
  TypedReducer<InvoiceEntity, UpdateQuoteItem>(_updateQuoteItem),
  TypedReducer<InvoiceEntity, SelectCompany>(_clearEditing),
  TypedReducer<InvoiceEntity, DiscardChanges>(_clearEditing),
  TypedReducer<InvoiceEntity, AddQuoteContact>((invoice, action) {
    return invoice.rebuild((b) => b
      ..invitations.add(
          action.invitation ?? InvitationEntity(contactId: action.contact.id)));
  }),
  TypedReducer<InvoiceEntity, RemoveQuoteContact>((invoice, action) {
    return invoice.rebuild((b) => b..invitations.remove(action.invitation));
  }),
]);

InvoiceEntity _clearEditing(InvoiceEntity quote, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity quote, dynamic action) {
  return action.quote;
}

InvoiceEntity _addQuoteItem(InvoiceEntity quote, AddQuoteItem action) {
  return quote.rebuild(
      (b) => b..lineItems.add(action.quoteItem ?? InvoiceItemEntity()));
}

InvoiceEntity _addQuoteItems(InvoiceEntity quote, AddQuoteItems action) {
  return quote.rebuild((b) => b..lineItems.addAll(action.quoteItems));
}

InvoiceEntity _removeQuoteItem(InvoiceEntity quote, DeleteQuoteItem action) {
  if (quote.lineItems.length <= action.index) {
    return quote;
  }
  return quote.rebuild((b) => b..lineItems.removeAt(action.index));
}

InvoiceEntity _updateQuoteItem(InvoiceEntity quote, UpdateQuoteItem action) {
  if (quote.lineItems.length <= action.index) {
    return quote;
  }
  return quote.rebuild((b) => b..lineItems[action.index] = action.quoteItem);
}

final quoteListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortQuotes>(_sortQuotes),
  TypedReducer<ListUIState, FilterQuotesByState>(_filterQuotesByState),
  TypedReducer<ListUIState, FilterQuotesByStatus>(_filterQuotesByStatus),
  TypedReducer<ListUIState, FilterQuotesByEntity>(_filterQuotesByEntity),
  TypedReducer<ListUIState, FilterQuotes>(_filterQuotes),
  TypedReducer<ListUIState, FilterQuotesByCustom1>(_filterQuotesByCustom1),
  TypedReducer<ListUIState, FilterQuotesByCustom2>(_filterQuotesByCustom2),
  TypedReducer<ListUIState, StartQuoteMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToQuoteMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromQuoteMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearQuoteMultiselect>(_clearListMultiselect),
]);

ListUIState _filterQuotesByCustom1(
    ListUIState quoteListState, FilterQuotesByCustom1 action) {
  if (quoteListState.custom1Filters.contains(action.value)) {
    return quoteListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return quoteListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterQuotesByCustom2(
    ListUIState quoteListState, FilterQuotesByCustom2 action) {
  if (quoteListState.custom2Filters.contains(action.value)) {
    return quoteListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return quoteListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterQuotesByState(
    ListUIState quoteListState, FilterQuotesByState action) {
  if (quoteListState.stateFilters.contains(action.state)) {
    return quoteListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return quoteListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterQuotesByStatus(
    ListUIState quoteListState, FilterQuotesByStatus action) {
  if (quoteListState.statusFilters.contains(action.status)) {
    return quoteListState
        .rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return quoteListState.rebuild((b) => b..statusFilters.add(action.status));
  }
}

ListUIState _filterQuotesByEntity(
    ListUIState quoteListState, FilterQuotesByEntity action) {
  return quoteListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterQuotes(ListUIState quoteListState, FilterQuotes action) {
  return quoteListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : quoteListState.filterClearedAt);
}

ListUIState _sortQuotes(ListUIState quoteListState, SortQuotes action) {
  return quoteListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState quoteListState, StartQuoteMultiselect action) {
  return quoteListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState quoteListState, AddToQuoteMultiselect action) {
  return quoteListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState quoteListState, RemoveFromQuoteMultiselect action) {
  return quoteListState.rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState quoteListState, ClearQuoteMultiselect action) {
  return quoteListState.rebuild((b) => b..selectedIds = null);
}

final quotesReducer = combineReducers<QuoteState>([
  TypedReducer<QuoteState, SaveQuoteSuccess>(_updateQuote),
  TypedReducer<QuoteState, AddQuoteSuccess>(_addQuote),
  TypedReducer<QuoteState, LoadQuotesSuccess>(_setLoadedQuotes),
  TypedReducer<QuoteState, LoadQuoteSuccess>(_updateQuote),
  TypedReducer<QuoteState, MarkSentQuoteSuccess>(_markSentQuoteSuccess),
  TypedReducer<QuoteState, ArchiveQuoteRequest>(_archiveQuoteRequest),
  TypedReducer<QuoteState, ArchiveQuoteSuccess>(_archiveQuoteSuccess),
  TypedReducer<QuoteState, ArchiveQuoteFailure>(_archiveQuoteFailure),
  TypedReducer<QuoteState, DeleteQuoteRequest>(_deleteQuoteRequest),
  TypedReducer<QuoteState, DeleteQuoteSuccess>(_deleteQuoteSuccess),
  TypedReducer<QuoteState, DeleteQuoteFailure>(_deleteQuoteFailure),
  TypedReducer<QuoteState, RestoreQuoteRequest>(_restoreQuoteRequest),
  TypedReducer<QuoteState, RestoreQuoteSuccess>(_restoreQuoteSuccess),
  TypedReducer<QuoteState, RestoreQuoteFailure>(_restoreQuoteFailure),
  TypedReducer<QuoteState, ConvertQuoteSuccess>(_convertQuoteSuccess),
]);

QuoteState _markSentQuoteSuccess(
    QuoteState quoteState, MarkSentQuoteSuccess action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _archiveQuoteRequest(
    QuoteState quoteState, ArchiveQuoteRequest action) {
  final quotes = action.quoteIds.map((id) => quoteState.map[id]).toList();

  for (int i = 0; i < quotes.length; i++) {
    quotes[i] = quotes[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return quoteState.rebuild((b) {
    for (final quote in quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _archiveQuoteSuccess(
    QuoteState quoteState, ArchiveQuoteSuccess action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _archiveQuoteFailure(
    QuoteState quoteState, ArchiveQuoteFailure action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _deleteQuoteRequest(
    QuoteState quoteState, DeleteQuoteRequest action) {
  final quotes = action.quoteIds.map((id) => quoteState.map[id]).toList();

  for (int i = 0; i < quotes.length; i++) {
    quotes[i] = quotes[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return quoteState.rebuild((b) {
    for (final quote in quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _deleteQuoteSuccess(
    QuoteState quoteState, DeleteQuoteSuccess action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _deleteQuoteFailure(
    QuoteState quoteState, DeleteQuoteFailure action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _restoreQuoteRequest(
    QuoteState quoteState, RestoreQuoteRequest action) {
  final quotes = action.quoteIds.map((id) => quoteState.map[id]).toList();

  for (int i = 0; i < quotes.length; i++) {
    quotes[i] = quotes[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return quoteState.rebuild((b) {
    for (final quote in quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _restoreQuoteSuccess(
    QuoteState quoteState, RestoreQuoteSuccess action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _restoreQuoteFailure(
    QuoteState quoteState, RestoreQuoteFailure action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _convertQuoteSuccess(
    QuoteState quoteState, ConvertQuoteSuccess action) {
  final quote = action.quote.rebuild((b) => b
    ..quoteInvoiceId = action.invoice.id
    ..statusId = kInvoiceStatusApproved);
  return quoteState.rebuild((b) => b..map[action.quote.id] = quote);
}

QuoteState _addQuote(QuoteState quoteState, AddQuoteSuccess action) {
  return quoteState.rebuild((b) => b
    ..map[action.quote.id] = action.quote
    ..list.add(action.quote.id));
}

QuoteState _updateQuote(QuoteState quoteState, dynamic action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _setLoadedQuotes(QuoteState quoteState, LoadQuotesSuccess action) {
  final state = quoteState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.quotes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
