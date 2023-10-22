// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState purchaseOrderUIReducer(
    PurchaseOrderUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(purchaseOrderListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..editingItemIndex = editingItemReducer(state.editingItemIndex, action)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action)
    ..historyActivityId =
        historyActivityIdReducer(state.historyActivityId, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewPurchaseOrder>((completer, action) => true),
  TypedReducer<bool?, ViewPurchaseOrderList>((completer, action) => false),
  TypedReducer<bool?, FilterPurchaseOrdersByState>(
      (completer, action) => false),
  TypedReducer<bool?, FilterPurchaseOrdersByStatus>(
      (completer, action) => false),
  TypedReducer<bool?, FilterPurchaseOrders>((completer, action) => false),
  TypedReducer<bool?, FilterPurchaseOrdersByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterPurchaseOrdersByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterPurchaseOrdersByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterPurchaseOrdersByCustom4>(
      (completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdatePurchaseOrderTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

final historyActivityIdReducer = combineReducers<String?>([
  TypedReducer<String?, ShowPdfPurchaseOrder>(
      (index, action) => action.activityId),
]);

final editingItemReducer = combineReducers<int?>([
  TypedReducer<int?, EditPurchaseOrder>(
      (index, action) => action.purchaseOrderItemIndex),
  TypedReducer<int?, EditPurchaseOrderItem>(
      (index, action) => action.itemIndex),
]);

/*
Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterPurchaseOrderDropdown>(
      filterpurchaseOrderDropdownReducer),
]);

String filterpurchaseOrderDropdownReducer(
    String dropdownFilter, FilterPurchaseOrderDropdown action) {
  return action.filter;
}
*/

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchivePurchaseOrdersSuccess>(
      (completer, action) => ''),
  TypedReducer<String?, DeletePurchaseOrdersSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.purchaseOrder
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewPurchaseOrder>(
      (selectedId, action) => action.purchaseOrderId),
  TypedReducer<String?, AddPurchaseOrderSuccess>(
      (selectedId, action) => action.purchaseOrder.id),
  TypedReducer<String?, ShowEmailPurchaseOrder>(
      (selectedId, action) => action.purchaseOrder!.id),
  TypedReducer<String?, ShowPdfPurchaseOrder>(
      (selectedId, action) => action.purchaseOrder!.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortPurchaseOrders>((selectedId, action) => ''),
  TypedReducer<String?, FilterPurchaseOrders>((selectedId, action) => ''),
  TypedReducer<String?, FilterPurchaseOrdersByState>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterPurchaseOrdersByStatus>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterPurchaseOrdersByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterPurchaseOrdersByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterPurchaseOrdersByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterPurchaseOrdersByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, ClearEntitySelection>((selectedId, action) =>
      action.entityType == EntityType.purchaseOrder ? '' : selectedId),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.purchaseOrder
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<InvoiceEntity?>([
  TypedReducer<InvoiceEntity?, LoadPurchaseOrderSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity?, SavePurchaseOrderSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity?, AddPurchaseOrderSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity?, EditPurchaseOrder>(_updateEditing),
  TypedReducer<InvoiceEntity?, UpdatePurchaseOrder>((purchaseOrder, action) {
    return action.purchaseOrder.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity?, AddPurchaseOrderItem>((invoice, action) {
    return invoice!.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity?, MovePurchaseOrderItem>((invoice, action) {
    return invoice!.moveLineItem(action.oldIndex!, action.newIndex);
  }),
  TypedReducer<InvoiceEntity?, DeletePurchaseOrderItem>((invoice, action) {
    return invoice!.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity?, UpdatePurchaseOrderItem>((invoice, action) {
    return invoice!.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity?, UpdatePurchaseOrderVendor>(
      (purchaseOrder, action) {
    final vendor = action.vendor;
    return purchaseOrder!.rebuild((b) => b
      ..isChanged = true
      ..vendorId = vendor?.id ?? ''
      ..invitations.replace((vendor?.emailContacts ?? <VendorContactEntity>[])
          .map((contact) => InvitationEntity(vendorContactId: contact.id))
          .toList()));
  }),
  TypedReducer<InvoiceEntity?, RestorePurchaseOrdersSuccess>(
      (purchaseOrders, action) {
    return action.purchaseOrders[0];
  }),
  TypedReducer<InvoiceEntity?, ArchivePurchaseOrdersSuccess>(
      (purchaseOrders, action) {
    return action.purchaseOrders[0];
  }),
  TypedReducer<InvoiceEntity?, DeletePurchaseOrdersSuccess>(
      (purchaseOrders, action) {
    return action.purchaseOrders[0];
  }),
  TypedReducer<InvoiceEntity?, AddPurchaseOrderItem>(_addPurchaseOrderItem),
  TypedReducer<InvoiceEntity?, AddPurchaseOrderItems>(_addPurchaseOrderItems),
  TypedReducer<InvoiceEntity?, DeletePurchaseOrderItem>(
      _removePurchaseOrderItem),
  TypedReducer<InvoiceEntity?, UpdatePurchaseOrderItem>(
      _updatePurchaseOrderItem),
  TypedReducer<InvoiceEntity?, DiscardChanges>(_clearEditing),
  TypedReducer<InvoiceEntity?, AddPurchaseOrderContact>((invoice, action) {
    return invoice!.rebuild((b) => b
      ..invitations.add(action.invitation ??
          InvitationEntity(vendorContactId: action.contact!.id)));
  }),
  TypedReducer<InvoiceEntity?, RemovePurchaseOrderContact>((invoice, action) {
    return invoice!.rebuild((b) => b..invitations.remove(action.invitation));
  }),
]);

InvoiceEntity _clearEditing(InvoiceEntity? purchaseOrder, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity? _updateEditing(InvoiceEntity? purchaseOrder, dynamic action) {
  return action.purchaseOrder;
}

InvoiceEntity _addPurchaseOrderItem(
    InvoiceEntity? purchaseOrder, AddPurchaseOrderItem action) {
  return purchaseOrder!.rebuild(
      (b) => b..lineItems.add(action.purchaseOrderItem ?? InvoiceItemEntity()));
}

InvoiceEntity _addPurchaseOrderItems(
    InvoiceEntity? purchaseOrder, AddPurchaseOrderItems action) {
  return purchaseOrder!.rebuild((b) => b..lineItems.addAll(action.lineItems));
}

InvoiceEntity? _removePurchaseOrderItem(
    InvoiceEntity? purchaseOrder, DeletePurchaseOrderItem action) {
  if (purchaseOrder!.lineItems.length <= action.index) {
    return purchaseOrder;
  }
  return purchaseOrder.rebuild((b) => b..lineItems.removeAt(action.index));
}

InvoiceEntity? _updatePurchaseOrderItem(
    InvoiceEntity? purchaseOrder, UpdatePurchaseOrderItem action) {
  if (purchaseOrder!.lineItems.length <= action.index) {
    return purchaseOrder;
  }
  return purchaseOrder
      .rebuild((b) => b..lineItems[action.index] = action.purchaseOrderItem);
}

final purchaseOrderListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortPurchaseOrders>(_sortPurchaseOrders),
  TypedReducer<ListUIState, FilterPurchaseOrdersByState>(
      _filterPurchaseOrdersByState),
  TypedReducer<ListUIState, FilterPurchaseOrdersByStatus>(
      _filterPurchaseOrdersByStatus),
  TypedReducer<ListUIState, FilterPurchaseOrders>(_filterPurchaseOrders),
  TypedReducer<ListUIState, FilterPurchaseOrdersByCustom1>(
      _filterPurchaseOrdersByCustom1),
  TypedReducer<ListUIState, FilterPurchaseOrdersByCustom2>(
      _filterPurchaseOrdersByCustom2),
  TypedReducer<ListUIState, FilterPurchaseOrdersByCustom3>(
      _filterPurchaseOrdersByCustom3),
  TypedReducer<ListUIState, FilterPurchaseOrdersByCustom4>(
      _filterPurchaseOrdersByCustom4),
  TypedReducer<ListUIState, StartPurchaseOrderMultiselect>(
      _startListMultiselect),
  TypedReducer<ListUIState, AddToPurchaseOrderMultiselect>(
      _addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromPurchaseOrderMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearPurchaseOrderMultiselect>(
      _clearListMultiselect),
  TypedReducer<ListUIState, ViewPurchaseOrderList>(_viewPurchaseOrderList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewPurchaseOrderList(
    ListUIState purchaseOrderListState, ViewPurchaseOrderList action) {
  return purchaseOrderListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterPurchaseOrdersByCustom1(
    ListUIState purchaseOrderListState, FilterPurchaseOrdersByCustom1 action) {
  if (purchaseOrderListState.custom1Filters.contains(action.value)) {
    return purchaseOrderListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return purchaseOrderListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterPurchaseOrdersByCustom2(
    ListUIState purchaseOrderListState, FilterPurchaseOrdersByCustom2 action) {
  if (purchaseOrderListState.custom2Filters.contains(action.value)) {
    return purchaseOrderListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return purchaseOrderListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterPurchaseOrdersByCustom3(
    ListUIState purchaseOrderListState, FilterPurchaseOrdersByCustom3 action) {
  if (purchaseOrderListState.custom3Filters.contains(action.value)) {
    return purchaseOrderListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return purchaseOrderListState
        .rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterPurchaseOrdersByCustom4(
    ListUIState purchaseOrderListState, FilterPurchaseOrdersByCustom4 action) {
  if (purchaseOrderListState.custom4Filters.contains(action.value)) {
    return purchaseOrderListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return purchaseOrderListState
        .rebuild((b) => b..custom4Filters.add(action.value));
  }
}

ListUIState _filterPurchaseOrdersByState(
    ListUIState purchaseOrderListState, FilterPurchaseOrdersByState action) {
  if (purchaseOrderListState.stateFilters.contains(action.state)) {
    return purchaseOrderListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return purchaseOrderListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterPurchaseOrdersByStatus(
    ListUIState purchaseOrderListState, FilterPurchaseOrdersByStatus action) {
  if (purchaseOrderListState.statusFilters.contains(action.status)) {
    return purchaseOrderListState
        .rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return purchaseOrderListState
        .rebuild((b) => b..statusFilters.add(action.status));
  }
}

ListUIState _filterPurchaseOrders(
    ListUIState purchaseOrderListState, FilterPurchaseOrders action) {
  return purchaseOrderListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : purchaseOrderListState.filterClearedAt);
}

ListUIState _sortPurchaseOrders(
    ListUIState purchaseOrderListState, SortPurchaseOrders action) {
  return purchaseOrderListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState purchaseOrderListState, StartPurchaseOrderMultiselect action) {
  return purchaseOrderListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState purchaseOrderListState, AddToPurchaseOrderMultiselect action) {
  return purchaseOrderListState
      .rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(ListUIState purchaseOrderListState,
    RemoveFromPurchaseOrderMultiselect action) {
  return purchaseOrderListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState purchaseOrderListState, ClearPurchaseOrderMultiselect action) {
  return purchaseOrderListState.rebuild((b) => b..selectedIds = null);
}

final purchaseOrdersReducer = combineReducers<PurchaseOrderState>([
  TypedReducer<PurchaseOrderState, SavePurchaseOrderSuccess>(
      _updatePurchaseOrder),
  TypedReducer<PurchaseOrderState, AddPurchaseOrderSuccess>(_addPurchaseOrder),
  TypedReducer<PurchaseOrderState, LoadPurchaseOrdersSuccess>(
      _setLoadedPurchaseOrders),
  TypedReducer<PurchaseOrderState, LoadPurchaseOrderSuccess>(
      _updatePurchaseOrder),
  TypedReducer<PurchaseOrderState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<PurchaseOrderState, MarkPurchaseOrderSentSuccess>(
      _markSentPurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, ConvertPurchaseOrdersToExpensesSuccess>(
      _convertPurchaseOrdersToExpenses),
  TypedReducer<PurchaseOrderState, AddPurchaseOrdersToInventorySuccess>(
      _addPurchaseOrdersToInventorySuccess),
  TypedReducer<PurchaseOrderState, AcceptPurchaseOrderSuccess>(
      _acceptPurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, CancelPurchaseOrderSuccess>(
      _cancelPurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, EmailPurchaseOrderSuccess>(
      _emailPurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, ArchivePurchaseOrdersSuccess>(
      _archivePurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, DeletePurchaseOrdersSuccess>(
      _deletePurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, RestorePurchaseOrdersSuccess>(
      _restorePurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, ApprovePurchaseOrderSuccess>(
      _approvePurchaseOrderSuccess),
]);

PurchaseOrderState _markSentPurchaseOrderSuccess(
    PurchaseOrderState purchaseOrderState,
    MarkPurchaseOrderSentSuccess action) {
  final purchaseOrderMap = Map<String, InvoiceEntity>.fromIterable(
    action.purchaseOrders,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return purchaseOrderState.rebuild((b) => b..map.addAll(purchaseOrderMap));
}

PurchaseOrderState _convertPurchaseOrdersToExpenses(
    PurchaseOrderState purchaseOrderState,
    ConvertPurchaseOrdersToExpensesSuccess action) {
  final purchaseOrderMap = Map<String, InvoiceEntity>.fromIterable(
    action.purchaseOrders,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return purchaseOrderState.rebuild((b) => b..map.addAll(purchaseOrderMap));
}

PurchaseOrderState _addPurchaseOrdersToInventorySuccess(
    PurchaseOrderState purchaseOrderState,
    AddPurchaseOrdersToInventorySuccess action) {
  final purchaseOrderMap = Map<String, InvoiceEntity>.fromIterable(
    action.purchaseOrders,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return purchaseOrderState.rebuild((b) => b..map.addAll(purchaseOrderMap));
}

PurchaseOrderState _acceptPurchaseOrderSuccess(
    PurchaseOrderState purchaseOrderState, AcceptPurchaseOrderSuccess action) {
  final purchaseOrderMap = Map<String, InvoiceEntity>.fromIterable(
    action.purchaseOrders,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return purchaseOrderState.rebuild((b) => b..map.addAll(purchaseOrderMap));
}

PurchaseOrderState _cancelPurchaseOrderSuccess(
    PurchaseOrderState purchaseOrderState, CancelPurchaseOrderSuccess action) {
  final purchaseOrderMap = Map<String, InvoiceEntity>.fromIterable(
    action.purchaseOrders,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return purchaseOrderState.rebuild((b) => b..map.addAll(purchaseOrderMap));
}

PurchaseOrderState _archivePurchaseOrderSuccess(
    PurchaseOrderState purchaseOrderState,
    ArchivePurchaseOrdersSuccess action) {
  return purchaseOrderState.rebuild((b) {
    for (final purchaseOrder in action.purchaseOrders) {
      b.map[purchaseOrder.id] = purchaseOrder;
    }
  });
}

PurchaseOrderState _deletePurchaseOrderSuccess(
    PurchaseOrderState purchaseOrderState, DeletePurchaseOrdersSuccess action) {
  return purchaseOrderState.rebuild((b) {
    for (final purchaseOrder in action.purchaseOrders) {
      b.map[purchaseOrder.id] = purchaseOrder;
    }
  });
}

PurchaseOrderState _restorePurchaseOrderSuccess(
    PurchaseOrderState purchaseOrderState,
    RestorePurchaseOrdersSuccess action) {
  return purchaseOrderState.rebuild((b) {
    for (final purchaseOrder in action.purchaseOrders) {
      b.map[purchaseOrder.id] = purchaseOrder;
    }
  });
}

PurchaseOrderState _emailPurchaseOrderSuccess(
    PurchaseOrderState purchaseOrderState, EmailPurchaseOrderSuccess action) {
  return purchaseOrderState
      .rebuild((b) => b..map[action.purchaseOrder.id] = action.purchaseOrder);
}

PurchaseOrderState _approvePurchaseOrderSuccess(
    PurchaseOrderState purchaseOrderState, ApprovePurchaseOrderSuccess action) {
  final purchaseOrderMap = Map<String, InvoiceEntity>.fromIterable(
    action.purchaseOrders!,
    key: (dynamic item) => item.id,
    value: (dynamic item) => item,
  );
  return purchaseOrderState.rebuild((b) => b..map.addAll(purchaseOrderMap));
}

PurchaseOrderState _addPurchaseOrder(
    PurchaseOrderState purchaseOrderState, AddPurchaseOrderSuccess action) {
  return purchaseOrderState.rebuild((b) => b
    ..map[action.purchaseOrder.id] = action.purchaseOrder
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch)
    ..list.add(action.purchaseOrder.id));
}

PurchaseOrderState _updatePurchaseOrder(
    PurchaseOrderState invoiceState, dynamic action) {
  final InvoiceEntity? purchaseOrder = action.purchaseOrder;
  return invoiceState.rebuild((b) => b
    ..map[purchaseOrder!.id] = purchaseOrder
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

PurchaseOrderState _setLoadedPurchaseOrders(
        PurchaseOrderState purchaseOrderState,
        LoadPurchaseOrdersSuccess action) =>
    purchaseOrderState.loadPurchaseOrders(action.purchaseOrders);

PurchaseOrderState _setLoadedCompany(
    PurchaseOrderState purchaseOrderState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return purchaseOrderState.loadPurchaseOrders(company.purchaseOrders);
}
