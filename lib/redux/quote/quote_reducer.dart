import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_state.dart';

EntityUIState quoteUIReducer(QuoteUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(quoteListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<int> selectedIdReducer = combineReducers([
  TypedReducer<int, ViewQuote>(
      (int selectedId, dynamic action) => action.quoteId),
  TypedReducer<int, AddQuoteSuccess>(
      (int selectedId, dynamic action) => action.quote.id),
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, RestoreQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, ArchiveQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, DeleteQuoteSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, EditQuote>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdateQuote>(_updateEditing),
  TypedReducer<InvoiceEntity, SelectCompany>(_clearEditing),
]);

InvoiceEntity _clearEditing(InvoiceEntity quote, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity quote, dynamic action) {
  return action.quote;
}


final quoteListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortQuotes>(_sortQuotes),
  TypedReducer<ListUIState, FilterQuotesByState>(_filterQuotesByState),
  TypedReducer<ListUIState, FilterQuotes>(_filterQuotes),
  TypedReducer<ListUIState, FilterQuotesByCustom1>(_filterQuotesByCustom1),
  TypedReducer<ListUIState, FilterQuotesByCustom2>(_filterQuotesByCustom2),
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

ListUIState _filterQuotes(ListUIState quoteListState, FilterQuotes action) {
  return quoteListState.rebuild((b) => b..filter = action.filter);
}

ListUIState _sortQuotes(ListUIState quoteListState, SortQuotes action) {
  return quoteListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

final quotesReducer = combineReducers<QuoteState>([
  TypedReducer<QuoteState, SaveQuoteSuccess>(_updateQuote),
  TypedReducer<QuoteState, AddQuoteSuccess>(_addQuote),
  TypedReducer<QuoteState, LoadQuotesSuccess>(_setLoadedQuotes),
  TypedReducer<QuoteState, LoadQuotesFailure>(_setNoQuotes),
  TypedReducer<QuoteState, LoadQuoteSuccess>(_setLoadedQuote),
  TypedReducer<QuoteState, ArchiveQuoteRequest>(_archiveQuoteRequest),
  TypedReducer<QuoteState, ArchiveQuoteSuccess>(_archiveQuoteSuccess),
  TypedReducer<QuoteState, ArchiveQuoteFailure>(_archiveQuoteFailure),
  TypedReducer<QuoteState, DeleteQuoteRequest>(_deleteQuoteRequest),
  TypedReducer<QuoteState, DeleteQuoteSuccess>(_deleteQuoteSuccess),
  TypedReducer<QuoteState, DeleteQuoteFailure>(_deleteQuoteFailure),
  TypedReducer<QuoteState, RestoreQuoteRequest>(_restoreQuoteRequest),
  TypedReducer<QuoteState, RestoreQuoteSuccess>(_restoreQuoteSuccess),
  TypedReducer<QuoteState, RestoreQuoteFailure>(_restoreQuoteFailure),
]);

QuoteState _archiveQuoteRequest(
    QuoteState quoteState, ArchiveQuoteRequest action) {
  final quote = quoteState.map[action.quoteId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return quoteState.rebuild((b) => b..map[action.quoteId] = quote);
}

QuoteState _archiveQuoteSuccess(
    QuoteState quoteState, ArchiveQuoteSuccess action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _archiveQuoteFailure(
    QuoteState quoteState, ArchiveQuoteFailure action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _deleteQuoteRequest(
    QuoteState quoteState, DeleteQuoteRequest action) {
  final quote = quoteState.map[action.quoteId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return quoteState.rebuild((b) => b..map[action.quoteId] = quote);
}

QuoteState _deleteQuoteSuccess(
    QuoteState quoteState, DeleteQuoteSuccess action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _deleteQuoteFailure(
    QuoteState quoteState, DeleteQuoteFailure action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _restoreQuoteRequest(
    QuoteState quoteState, RestoreQuoteRequest action) {
  final quote = quoteState.map[action.quoteId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return quoteState.rebuild((b) => b..map[action.quoteId] = quote);
}

QuoteState _restoreQuoteSuccess(
    QuoteState quoteState, RestoreQuoteSuccess action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _restoreQuoteFailure(
    QuoteState quoteState, RestoreQuoteFailure action) {
  return quoteState.rebuild((b) => b..map[action.quote.id] = action.quote);
}

QuoteState _addQuote(QuoteState quoteState, AddQuoteSuccess action) {
  return quoteState.rebuild((b) => b
    ..map[action.quote.id] = action.quote
    ..list.add(action.quote.id));
}

QuoteState _updateQuote(QuoteState quoteState, SaveQuoteSuccess action) {
  return quoteState.rebuild((b) => b
    ..map[action.quote.id] = action.quote);
}

QuoteState _setLoadedQuote(
    QuoteState quoteState, LoadQuoteSuccess action) {
  return quoteState.rebuild((b) => b
    ..map[action.quote.id] = action.quote);
}

QuoteState _setNoQuotes(QuoteState quoteState, LoadQuotesFailure action) {
  return quoteState;
}

QuoteState _setLoadedQuotes(
    QuoteState quoteState, LoadQuotesSuccess action) {
  final state = quoteState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.quotes,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
