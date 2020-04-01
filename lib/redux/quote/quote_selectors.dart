import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

ClientEntity quoteClientSelector(
    InvoiceEntity quote, BuiltMap<String, ClientEntity> clientMap) {
  return clientMap[quote.clientId];
}

var memoizedFilteredQuoteList = memo4((BuiltMap<String, InvoiceEntity> quoteMap,
        BuiltList<String> quoteList,
        BuiltMap<String, ClientEntity> clientMap,
        ListUIState quoteListState) =>
    filteredQuotesSelector(quoteMap, quoteList, clientMap, quoteListState));

List<String> filteredQuotesSelector(
    BuiltMap<String, InvoiceEntity> quoteMap,
    BuiltList<String> quoteList,
    BuiltMap<String, ClientEntity> clientMap,
    ListUIState quoteListState) {
  final list = quoteList.where((quoteId) {
    final quote = quoteMap[quoteId];
    final client =
        clientMap[quote.clientId] ?? ClientEntity(id: quote.clientId);

    if (quoteListState.filterEntityType == EntityType.client) {
      if (!quoteListState.entityMatchesFilter(client)) {
        return false;
      }
    } else if (quoteListState.filterEntityType == EntityType.user) {
      if (!quote.userCanAccess(quoteListState.filterEntityId)) {
        return false;
      }
    }

    if (!quote.matchesStates(quoteListState.stateFilters)) {
      return false;
    }
    if (!quote.matchesStatuses(quoteListState.statusFilters)) {
      return false;
    }
    if (!quote.matchesFilter(quoteListState.filter) &&
        !client.matchesFilter(quoteListState.filter)) {
      return false;
    }
    if (quoteListState.custom1Filters.isNotEmpty &&
        !quoteListState.custom1Filters.contains(quote.customValue1)) {
      return false;
    }
    if (quoteListState.custom2Filters.isNotEmpty &&
        !quoteListState.custom2Filters.contains(quote.customValue2)) {
      return false;
    }
    return true;
  }).toList();

  list.sort((quoteAId, quoteBId) {
    return quoteMap[quoteAId].compareTo(
      invoice: quoteMap[quoteBId],
      sortField: quoteListState.sortField,
      sortAscending: quoteListState.sortAscending,
      clientMap: clientMap,
    );
  });

  return list;
}

var memoizedQuoteStatsForClient = memo2(
    (String clientId, BuiltMap<String, InvoiceEntity> quoteMap) =>
        quoteStatsForClient(clientId, quoteMap));

EntityStats quoteStatsForClient(
    String clientId, BuiltMap<String, InvoiceEntity> quoteMap) {
  int countActive = 0;
  int countArchived = 0;
  quoteMap.forEach((quoteId, quote) {
    if (quote.clientId == clientId) {
      if (quote.isActive) {
        countActive++;
      } else if (quote.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedQuoteStatsForUser = memo2(
    (String userId, BuiltMap<String, InvoiceEntity> quoteMap) =>
        quoteStatsForUser(userId, quoteMap));

EntityStats quoteStatsForUser(
  String userId,
  BuiltMap<String, InvoiceEntity> quoteMap,
) {
  int countActive = 0;
  int countArchived = 0;
  quoteMap.forEach((quoteId, quote) {
    if (quote.userCanAccess(userId)) {
      if (quote.isActive) {
        countActive++;
      } else if (quote.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

bool hasQuoteChanges(
        InvoiceEntity quote, BuiltMap<String, InvoiceEntity> quoteMap) =>
    quote.isNew ? quote.isChanged : quote != quoteMap[quote.id];
