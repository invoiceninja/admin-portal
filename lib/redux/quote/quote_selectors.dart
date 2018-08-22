import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownQuoteList = memo2(
    (BuiltMap<int, QuoteEntity> quoteMap, BuiltList<int> quoteList) =>
        dropdownQuotesSelector(quoteMap, quoteList));

List<int> dropdownQuotesSelector(
    BuiltMap<int, QuoteEntity> quoteMap, BuiltList<int> quoteList) {
  final list =
      quoteList.where((quoteId) => quoteMap[quoteId].isActive).toList();

  list.sort((quoteAId, quoteBId) {
    final quoteA = quoteMap[quoteAId];
    final quoteB = quoteMap[quoteBId];
    return quoteA.compareTo(quoteB, QuoteFields.quoteNumber, true);
  });

  return list;
}

var memoizedFilteredQuoteList = memo3((BuiltMap<int, QuoteEntity> quoteMap,
        BuiltList<int> quoteList, ListUIState quoteListState) =>
    filteredQuotesSelector(quoteMap, quoteList, quoteListState));

List<int> filteredQuotesSelector(BuiltMap<int, QuoteEntity> quoteMap,
    BuiltList<int> quoteList, ListUIState quoteListState) {
  final list = quoteList.where((quoteId) {
    final quote = quoteMap[quoteId];
    if (!quote.matchesStates(quoteListState.stateFilters)) {
      return false;
    }
    if (quoteListState.custom1Filters.isNotEmpty &&
        !quoteListState.custom1Filters.contains(quote.customTextValue1)) {
      return false;
    }
    if (quoteListState.custom2Filters.isNotEmpty &&
        !quoteListState.custom2Filters.contains(quote.customTextValue2)) {
      return false;
    }
    return quote.matchesFilter(quoteListState.filter);
  }).toList();

  list.sort((quoteAId, quoteBId) {
    final quoteA = quoteMap[quoteAId];
    final quoteB = quoteMap[quoteBId];
    return quoteA.compareTo(
        quoteB, quoteListState.sortField, quoteListState.sortAscending);
  });

  return list;
}
