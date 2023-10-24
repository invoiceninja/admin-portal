// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedHasActiveUnpaidInvoices = memo2(
    (String clientId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        hasActiveUnpaidInvoices(clientId, invoiceMap));

bool hasActiveUnpaidInvoices(
    String clientId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  bool hasUnapid = false;

  final invoiceIds = invoiceMap.keys.toList();
  for (var i = 0; i < invoiceIds.length; i++) {
    final invoiceId = invoiceIds[i];
    final invoice = invoiceMap[invoiceId]!;

    if (invoice.clientId == clientId && invoice.isUnpaid) {
      hasUnapid = true;
    }
  }

  return hasUnapid;
}

var memoizedInvoiceQuoteSelector = memo2(
    (InvoiceEntity invoice, BuiltMap<String, InvoiceEntity> quoteMap) =>
        invoiceQuoteSelector(invoice, quoteMap));

InvoiceEntity? invoiceQuoteSelector(
    InvoiceEntity invoice, BuiltMap<String, InvoiceEntity> quoteMap) {
  InvoiceEntity? invoiceQuote;
  quoteMap.forEach((quoteId, quote) {
    if (quote.invoiceId == invoice.id) {
      invoiceQuote = quote;
    }
  });
  return invoiceQuote;
}

ClientContactEntity? invoiceContactSelector(
    InvoiceEntity invoice, ClientEntity client) {
  var contactIds = invoice.invitations
      .map((invitation) => invitation.clientContactId)
      .toList();
  if (contactIds.contains(client.primaryContact.id)) {
    contactIds = [client.primaryContact.id];
  }
  return client.contacts
      .firstWhere((contact) => contactIds.contains(contact.id), orElse: null);
}

var memoizedDropdownInvoiceList = memo8(
    (BuiltMap<String, InvoiceEntity> invoiceMap,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltMap<String, VendorEntity> vendorMap,
            BuiltList<String> invoiceList,
            String clientId,
            BuiltMap<String, UserEntity> userMap,
            List<String?> excludedIds,
            String? recurringPrefix) =>
        dropdownInvoiceSelector(
          invoiceMap,
          clientMap,
          vendorMap,
          invoiceList,
          clientId,
          userMap,
          excludedIds,
          recurringPrefix,
        ));

List<String> dropdownInvoiceSelector(
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltList<String> invoiceList,
  String clientId,
  BuiltMap<String, UserEntity> userMap,
  List<String?> excludedIds,
  String? recurringPrefix,
) {
  final list = invoiceList.where((invoiceId) {
    final invoice = invoiceMap[invoiceId];
    if (excludedIds.contains(invoiceId)) {
      return false;
    }
    if (clientId.isNotEmpty && invoice!.clientId != clientId) {
      return false;
    }
    if (!clientMap.containsKey(invoice!.clientId) ||
        !clientMap[invoice.clientId]!.isActive) {
      return false;
    }
    return invoice.isActive &&
        invoice.isUnpaid &&
        !invoice.isCancelledOrReversed;
  }).toList();

  list.sort((invoiceAId, invoiceBId) {
    final invoiceA = invoiceMap[invoiceAId]!;
    final invoiceB = invoiceMap[invoiceBId];
    return invoiceA.compareTo(
      invoice: invoiceB,
      clientMap: clientMap,
      vendorMap: vendorMap,
      sortAscending: true,
      sortField: InvoiceFields.number,
      recurringPrefix: recurringPrefix,
      userMap: userMap,
    );
  });

  return list;
}

var memoizedFilteredInvoiceList = memo9((SelectionState selectionState,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltList<String> invoiceList,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, VendorEntity> vendorMap,
        BuiltMap<String, PaymentEntity> paymentMap,
        ListUIState invoiceListState,
        BuiltMap<String, UserEntity> userMap,
        String? recurringPrefix) =>
    filteredInvoicesSelector(
      selectionState,
      invoiceMap,
      invoiceList,
      clientMap,
      vendorMap,
      paymentMap,
      invoiceListState,
      userMap,
      recurringPrefix,
    ));

List<String> filteredInvoicesSelector(
  SelectionState selectionState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltList<String> invoiceList,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  ListUIState invoiceListState,
  BuiltMap<String, UserEntity> userMap,
  String? recurringPrefix,
) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final Map<String?, List<String>> invoicePaymentMap = {};
  if (filterEntityType == EntityType.payment) {
    paymentMap.forEach((paymentId, payment) {
      payment.invoicePaymentables.forEach((invoicePaymentable) {
        final List<String> paymentIds =
            invoicePaymentMap[invoicePaymentable.invoiceId] ?? [];
        paymentIds.add(payment.id);
        invoicePaymentMap[invoicePaymentable.invoiceId] = paymentIds;
      });
    });
  }

  final list = invoiceList.where((invoiceId) {
    final invoice = invoiceMap[invoiceId]!;
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);

    if (invoice.id == selectionState.selectedId) {
      return true;
    }

    if (!client.isActive &&
        !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (filterEntityType == EntityType.client && client.id != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.user &&
        invoice.assignedUserId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.recurringInvoice &&
        invoice.recurringId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.paymentLink &&
        invoice.subscriptionId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.design &&
        invoice.designId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.group &&
        client.groupId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.project &&
        invoice.projectId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.quote &&
        invoice.invoiceId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.payment) {
      bool isMatch = false;
      (invoicePaymentMap[invoiceId] ?? []).forEach((paymentId) {
        if (filterEntityId == paymentId) {
          isMatch = true;
        }
      });

      if (!isMatch) {
        return false;
      }
    }

    if (!invoice.matchesStates(invoiceListState.stateFilters)) {
      return false;
    }
    if (!invoice.matchesStatuses(invoiceListState.statusFilters)) {
      return false;
    }
    if (!invoice.matchesFilter(invoiceListState.filter) &&
        !client.matchesNameOrEmail(invoiceListState.filter)) {
      return false;
    }
    if (invoiceListState.custom1Filters.isNotEmpty &&
        !invoiceListState.custom1Filters.contains(invoice.customValue1)) {
      return false;
    } else if (invoiceListState.custom2Filters.isNotEmpty &&
        !invoiceListState.custom2Filters.contains(invoice.customValue2)) {
      return false;
    } else if (invoiceListState.custom3Filters.isNotEmpty &&
        !invoiceListState.custom3Filters.contains(invoice.customValue3)) {
      return false;
    } else if (invoiceListState.custom4Filters.isNotEmpty &&
        !invoiceListState.custom4Filters.contains(invoice.customValue4)) {
      return false;
    }
    return true;
  }).toList();

  list.sort((invoiceAId, invoiceBId) {
    return invoiceMap[invoiceAId]!.compareTo(
      invoice: invoiceMap[invoiceBId],
      sortField: invoiceListState.sortField,
      sortAscending: invoiceListState.sortAscending,
      clientMap: clientMap,
      vendorMap: vendorMap,
      userMap: userMap,
      recurringPrefix: recurringPrefix,
    );
  });

  return list;
}

var memoizedInvoiceStatsForClient = memo2(
    (String clientId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        invoiceStatsForClient(clientId, invoiceMap));

EntityStats invoiceStatsForClient(
    String clientId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.clientId == clientId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedInvoiceStatsForDesign = memo2(
    (String designId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        invoiceStatsForDesign(designId, invoiceMap));

EntityStats invoiceStatsForDesign(
    String designId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.designId == designId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedInvoiceStatsForSubscription = memo2(
    (String subscriptionId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        invoiceStatsForSubscription(subscriptionId, invoiceMap));

EntityStats invoiceStatsForSubscription(
    String subscriptionId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.subscriptionId == subscriptionId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedInvoiceStatsForProject = memo2((
  String projectId,
  BuiltMap<String, InvoiceEntity> invoiceMap,
) =>
    invoiceStatsForProject(projectId, invoiceMap));

EntityStats invoiceStatsForProject(
    String projectId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.projectId == projectId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedQuoteStatsForProject = memo2((
  String projectId,
  BuiltMap<String, InvoiceEntity> quoteMap,
) =>
    quoteStatsForProject(projectId, quoteMap));

EntityStats quoteStatsForProject(
    String projectId, BuiltMap<String, InvoiceEntity> quoteMap) {
  int countActive = 0;
  int countArchived = 0;
  quoteMap.forEach((quoteId, quote) {
    if (quote.projectId == projectId) {
      if (quote.isActive) {
        countActive++;
      } else if (quote.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedInvoiceStatsForUser = memo2(
    (String userId, BuiltMap<String, InvoiceEntity> invoiceMap) =>
        invoiceStatsForUser(userId, invoiceMap));

EntityStats invoiceStatsForUser(
    String userId, BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  invoiceMap.forEach((invoiceId, invoice) {
    if (invoice.assignedUserId == userId) {
      if (invoice.isActive) {
        countActive++;
      } else if (invoice.isDeleted!) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

int precisionForInvoice(AppState state, InvoiceEntity invoice) {
  final client = state.clientState.get(invoice.clientId);
  final currency = state.staticState.currencyMap[client.currencyId];
  return currency?.precision ?? 2;
}
