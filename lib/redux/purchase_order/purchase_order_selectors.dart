import 'package:invoiceninja_flutter/data/models/purchase_order_model.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

VendorEntity? purchaseOrderClientSelector(
    InvoiceEntity purchaseOrder, BuiltMap<String, VendorEntity> vendorMap) {
  return vendorMap[purchaseOrder.vendorId];
}

VendorContactEntity? purchaseOrderContactSelector(
    InvoiceEntity purchaseOrder, VendorEntity vendor) {
  var contactIds = purchaseOrder.invitations
      .map((invitation) => invitation.clientContactId)
      .toList();
  if (contactIds.contains(vendor.primaryContact.id)) {
    contactIds = [vendor.primaryContact.id];
  }
  return vendor.contacts
      .firstWhere((contact) => contactIds.contains(contact.id), orElse: null);
}

var memoizedDropdownPurchaseOrderList = memo7(
    (BuiltMap<String, InvoiceEntity> purchaseOrderMap,
            BuiltList<String> purchaseOrderList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltMap<String, VendorEntity> vendorMap,
            String clientId) =>
        dropdownPurchaseOrdersSelector(purchaseOrderMap, purchaseOrderList,
            staticState, userMap, clientMap, vendorMap, clientId));

List<String> dropdownPurchaseOrdersSelector(
    BuiltMap<String, InvoiceEntity> purchaseOrderMap,
    BuiltList<String> purchaseOrderList,
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, VendorEntity> vendorMap,
    String clientId) {
  final list = purchaseOrderList.where((purchaseOrderId) {
    final purchaseOrder = purchaseOrderMap[purchaseOrderId]!;
    /*
    if (clientId != null && clientId > 0 && purchaseOrder.clientId != clientId) {
      return false;
    }
    */
    return purchaseOrder.isActive;
  }).toList();

  list.sort((purchaseOrderAId, purchaseOrderBId) {
    final purchaseOrderA = purchaseOrderMap[purchaseOrderAId]!;
    final purchaseOrderB = purchaseOrderMap[purchaseOrderBId];
    return purchaseOrderA.compareTo(
      invoice: purchaseOrderB,
      sortAscending: false,
      sortField: PurchaseOrderFields.number,
      userMap: userMap,
      clientMap: clientMap,
      vendorMap: vendorMap,
    );
  });

  return list;
}

var memoizedFilteredPurchaseOrderList = memo7((
  SelectionState selectionState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltList<String> invoiceList,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  ListUIState invoiceListState,
  BuiltMap<String, UserEntity> userMap,
) =>
    filteredPurchaseOrdersSelector(selectionState, invoiceMap, invoiceList,
        clientMap, vendorMap, invoiceListState, userMap));

List<String> filteredPurchaseOrdersSelector(
  SelectionState selectionState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltList<String> invoiceList,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  ListUIState invoiceListState,
  BuiltMap<String, UserEntity> userMap,
) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = invoiceList.where((invoiceId) {
    final invoice = invoiceMap[invoiceId]!;
    final vendor =
        vendorMap[invoice.vendorId] ?? VendorEntity(id: invoice.vendorId);

    if (invoice.id == selectionState.selectedId) {
      return true;
    }

    if (!vendor.isActive &&
        !vendor.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (filterEntityType == EntityType.vendor && vendor.id != filterEntityId) {
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
//    } else if (filterEntityType == EntityType.group &&
//        vendor.groupId != filterEntityId) {
//      return false;
    } else if (filterEntityType == EntityType.project &&
        invoice.projectId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.quote &&
        invoice.invoiceId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.client &&
        invoice.clientId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.expense &&
        invoice.expenseId != filterEntityId) {
      return false;
    }

    if (!invoice.matchesStates(invoiceListState.stateFilters)) {
      return false;
    }
    if (!invoice.matchesStatuses(invoiceListState.statusFilters)) {
      return false;
    }
    if (!invoice.matchesFilter(invoiceListState.filter) &&
        !vendor.matchesNameOrEmail(invoiceListState.filter)) {
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
    );
  });

  return list;
}

var memoizedPurchaseOrderStatsForVendor = memo2(
    (String vendorId, BuiltMap<String, InvoiceEntity> purchaseOrderMap) =>
        purchaseOrderStatsForVendor(vendorId, purchaseOrderMap));

EntityStats purchaseOrderStatsForVendor(
    String vendorId, BuiltMap<String, InvoiceEntity> purchaseOrderMap) {
  int countActive = 0;
  int countArchived = 0;
  purchaseOrderMap.forEach((purchaseOrderId, purchaseOrder) {
    if (purchaseOrder.vendorId == vendorId) {
      if (purchaseOrder.isActive) {
        countActive++;
      } else if (purchaseOrder.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}
