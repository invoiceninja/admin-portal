import 'package:built_collection/built_collection.dart';
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
    ..editingItemIndex = editingItemReducer(state.editingItemIndex, action)
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

final editingItemReducer = combineReducers<int>([
  TypedReducer<int, EditQuote>((index, action) => action.quoteItemIndex),
  TypedReducer<int, EditQuoteItem>((index, action) => action.quoteItemIndex),
]);

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
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, EditQuote>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdateQuote>((quote, action) {
    return action.quote.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, AddQuoteItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, DeleteQuoteItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, UpdateQuoteItem>((invoice, action) {
    return invoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, UpdateQuoteClient>((quote, action) {
    final client = action.client;
    return quote.rebuild((b) => b
      ..isChanged = true
      ..clientId = client.id
      ..invitations.addAll(client.contacts
          .map((contact) => InvitationEntity(contactId: contact.id))));
  }),
  TypedReducer<InvoiceEntity, RestoreQuotesSuccess>((quotes, action) {
    return action.quotes[0];
  }),
  TypedReducer<InvoiceEntity, ArchiveQuotesSuccess>((quotes, action) {
    return action.quotes[0];
  }),
  TypedReducer<InvoiceEntity, DeleteQuotesSuccess>((quotes, action) {
    return action.quotes[0];
  }),
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
  TypedReducer<ListUIState, FilterQuotesByCustom3>(_filterQuotesByCustom3),
  TypedReducer<ListUIState, FilterQuotesByCustom4>(_filterQuotesByCustom4),
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

ListUIState _filterQuotesByCustom3(
    ListUIState quoteListState, FilterQuotesByCustom3 action) {
  if (quoteListState.custom3Filters.contains(action.value)) {
    return quoteListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return quoteListState.rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterQuotesByCustom4(
    ListUIState quoteListState, FilterQuotesByCustom4 action) {
  if (quoteListState.custom4Filters.contains(action.value)) {
    return quoteListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return quoteListState.rebuild((b) => b..custom4Filters.add(action.value));
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
  TypedReducer<QuoteState, ArchiveQuotesRequest>(_archiveQuoteRequest),
  TypedReducer<QuoteState, ArchiveQuotesSuccess>(_archiveQuoteSuccess),
  TypedReducer<QuoteState, ArchiveQuotesFailure>(_archiveQuoteFailure),
  TypedReducer<QuoteState, DeleteQuotesRequest>(_deleteQuoteRequest),
  TypedReducer<QuoteState, DeleteQuotesSuccess>(_deleteQuoteSuccess),
  TypedReducer<QuoteState, DeleteQuotesFailure>(_deleteQuoteFailure),
  TypedReducer<QuoteState, RestoreQuotesRequest>(_restoreQuoteRequest),
  TypedReducer<QuoteState, RestoreQuotesSuccess>(_restoreQuoteSuccess),
  TypedReducer<QuoteState, RestoreQuotesFailure>(_restoreQuoteFailure),
  TypedReducer<QuoteState, ConvertQuoteSuccess>(_convertQuoteSuccess),
]);

QuoteState _markSentQuoteSuccess(
    QuoteState quoteState, MarkSentQuoteSuccess action) {
  final quoteMap = Map<String, InvoiceEntity>.fromIterable(
    action.quotes,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return quoteState.rebuild((b) => b..map.addAll(quoteMap));
}

QuoteState _archiveQuoteRequest(
    QuoteState quoteState, ArchiveQuotesRequest action) {
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
    QuoteState quoteState, ArchiveQuotesSuccess action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _archiveQuoteFailure(
    QuoteState quoteState, ArchiveQuotesFailure action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _deleteQuoteRequest(
    QuoteState quoteState, DeleteQuotesRequest action) {
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
    QuoteState quoteState, DeleteQuotesSuccess action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _deleteQuoteFailure(
    QuoteState quoteState, DeleteQuotesFailure action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _restoreQuoteRequest(
    QuoteState quoteState, RestoreQuotesRequest action) {
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
    QuoteState quoteState, RestoreQuotesSuccess action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _restoreQuoteFailure(
    QuoteState quoteState, RestoreQuotesFailure action) {
  return quoteState.rebuild((b) {
    for (final quote in action.quotes) {
      b.map[quote.id] = quote;
    }
  });
}

QuoteState _convertQuoteSuccess(
    QuoteState quoteState, ConvertQuoteSuccess action) {
  final quoteMap = Map<String, InvoiceEntity>.fromIterable(
    action.quotes,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return quoteState.rebuild((b) => b..map.addAll(quoteMap));
}

QuoteState _addQuote(QuoteState quoteState, AddQuoteSuccess action) {
  return quoteState.rebuild((b) => b
    ..map[action.quote.id] = action.quote
    ..list.add(action.quote.id));
}

QuoteState _updateQuote(QuoteState quoteState, dynamic action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _setLoadedQuotes(QuoteState quoteState, LoadQuotesSuccess action) =>
    quoteState.loadQuotes(action.quotes);
