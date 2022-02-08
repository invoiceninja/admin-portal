// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

ClientEntity quoteClientSelector(
    InvoiceEntity quote, BuiltMap<String, ClientEntity> clientMap) {
  return clientMap[quote.clientId];
}

ContactEntity quoteContactSelector(InvoiceEntity quote, ClientEntity client) {
  var contactIds =
      quote.invitations.map((invitation) => invitation.contactId).toList();
  if (contactIds.contains(client.primaryContact.id)) {
    contactIds = [client.primaryContact.id];
  }
  return client.contacts
      .firstWhere((contact) => contactIds.contains(contact.id), orElse: null);
}

var memoizedFilteredQuoteList = memo6((SelectionState selectionState,
        BuiltMap<String, InvoiceEntity> quoteMap,
        BuiltList<String> quoteList,
        BuiltMap<String, ClientEntity> clientMap,
        ListUIState quoteListState,
        BuiltMap<String, UserEntity> userMap) =>
    filteredQuotesSelector(selectionState, quoteMap, quoteList, clientMap,
        quoteListState, userMap));

List<String> filteredQuotesSelector(
    SelectionState selectionState,
    BuiltMap<String, InvoiceEntity> quoteMap,
    BuiltList<String> quoteList,
    BuiltMap<String, ClientEntity> clientMap,
    ListUIState quoteListState,
    BuiltMap<String, UserEntity> userMap) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = quoteList.where((quoteId) {
    final quote = quoteMap[quoteId];
    final client =
        clientMap[quote.clientId] ?? ClientEntity(id: quote.clientId);

    if (quote.id == selectionState.selectedId) {
      return true;
    }

    if (!client.isActive &&
        !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (filterEntityType == EntityType.client &&
        quote.clientId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.user &&
        quote.assignedUserId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.design &&
        quote.designId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.group &&
        client.groupId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.invoice &&
        quote.invoiceId != filterEntityId) {
      return false;
    }

    if (!quote.matchesStates(quoteListState.stateFilters)) {
      return false;
    } else if (!quote.matchesStatuses(quoteListState.statusFilters)) {
      return false;
    } else if (!quote.matchesFilter(quoteListState.filter) &&
        !client.matchesNameOrEmail(quoteListState.filter)) {
      return false;
    }

    if (quoteListState.custom1Filters.isNotEmpty &&
        !quoteListState.custom1Filters.contains(quote.customValue1)) {
      return false;
    } else if (quoteListState.custom2Filters.isNotEmpty &&
        !quoteListState.custom2Filters.contains(quote.customValue2)) {
      return false;
    } else if (quoteListState.custom3Filters.isNotEmpty &&
        !quoteListState.custom3Filters.contains(quote.customValue3)) {
      return false;
    } else if (quoteListState.custom4Filters.isNotEmpty &&
        !quoteListState.custom4Filters.contains(quote.customValue4)) {
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
        userMap: userMap);
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

var memoizedQuoteStatsForDesign = memo2(
    (String designId, BuiltMap<String, InvoiceEntity> quoteMap) =>
        quoteStatsForDesign(designId, quoteMap));

EntityStats quoteStatsForDesign(
    String designId, BuiltMap<String, InvoiceEntity> quoteMap) {
  int countActive = 0;
  int countArchived = 0;
  quoteMap.forEach((quoteId, quote) {
    if (quote.designId == designId) {
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
    if (quote.assignedUserId == userId) {
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
