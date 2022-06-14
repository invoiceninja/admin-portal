import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_state.dart';

EntityUIState purchaseOrderUIReducer(
    PurchaseOrderUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(purchaseOrderListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action));
}

final forceSelectedReducer = combineReducers<bool>([
  TypedReducer<bool, ViewPurchaseOrder>((completer, action) => true),
  TypedReducer<bool, ViewPurchaseOrderList>((completer, action) => false),
  TypedReducer<bool, FilterPurchaseOrdersByState>((completer, action) => false),
  TypedReducer<bool, FilterPurchaseOrders>((completer, action) => false),
  TypedReducer<bool, FilterPurchaseOrdersByCustom1>(
      (completer, action) => false),
  TypedReducer<bool, FilterPurchaseOrdersByCustom2>(
      (completer, action) => false),
  TypedReducer<bool, FilterPurchaseOrdersByCustom3>(
      (completer, action) => false),
  TypedReducer<bool, FilterPurchaseOrdersByCustom4>(
      (completer, action) => false),
]);

final tabIndexReducer = combineReducers<int>([
  TypedReducer<int, UpdatePurchaseOrderTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ArchivePurchaseOrdersSuccess>((completer, action) => ''),
  TypedReducer<String, DeletePurchaseOrdersSuccess>((completer, action) => ''),
  TypedReducer<String, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.purchaseOrder
          ? action.entityId
          : selectedId),
  TypedReducer<String, ViewPurchaseOrder>(
      (String selectedId, dynamic action) => action.purchaseOrderId),
  TypedReducer<String, AddPurchaseOrderSuccess>(
      (String selectedId, dynamic action) => action.purchaseOrder.id),
  TypedReducer<String, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String, SortPurchaseOrders>((selectedId, action) => ''),
  TypedReducer<String, FilterPurchaseOrders>((selectedId, action) => ''),
  TypedReducer<String, FilterPurchaseOrdersByState>((selectedId, action) => ''),
  TypedReducer<String, FilterPurchaseOrdersByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String, FilterPurchaseOrdersByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String, FilterPurchaseOrdersByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String, FilterPurchaseOrdersByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.purchaseOrder
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SavePurchaseOrderSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddPurchaseOrderSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, RestorePurchaseOrdersSuccess>(
      (purchaseOrders, action) {
    return action.purchaseOrders[0];
  }),
  TypedReducer<InvoiceEntity, ArchivePurchaseOrdersSuccess>(
      (purchaseOrders, action) {
    return action.purchaseOrders[0];
  }),
  TypedReducer<InvoiceEntity, DeletePurchaseOrdersSuccess>(
      (purchaseOrders, action) {
    return action.purchaseOrders[0];
  }),
  TypedReducer<InvoiceEntity, EditPurchaseOrder>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdatePurchaseOrder>((purchaseOrder, action) {
    return action.purchaseOrder.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, DiscardChanges>(_clearEditing),
]);

InvoiceEntity _clearEditing(InvoiceEntity purchaseOrder, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity purchaseOrder, dynamic action) {
  return action.purchaseOrder;
}

final purchaseOrderListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortPurchaseOrders>(_sortPurchaseOrders),
  TypedReducer<ListUIState, FilterPurchaseOrdersByState>(
      _filterPurchaseOrdersByState),
  TypedReducer<ListUIState, FilterPurchaseOrders>(_filterPurchaseOrders),
  TypedReducer<ListUIState, FilterPurchaseOrdersByCustom1>(
      _filterPurchaseOrdersByCustom1),
  TypedReducer<ListUIState, FilterPurchaseOrdersByCustom2>(
      _filterPurchaseOrdersByCustom2),
  TypedReducer<ListUIState, StartPurchaseOrderMultiselect>(
      _startListMultiselect),
  TypedReducer<ListUIState, AddToPurchaseOrderMultiselect>(
      _addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromPurchaseOrderMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearPurchaseOrderMultiselect>(
      _clearListMultiselect),
  TypedReducer<ListUIState, ViewPurchaseOrderList>(_viewPurchaseOrderList),
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
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartPurchaseOrderMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToPurchaseOrderMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromPurchaseOrderMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearPurchaseOrderMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final purchaseOrdersReducer = combineReducers<PurchaseOrderState>([
  TypedReducer<PurchaseOrderState, SavePurchaseOrderSuccess>(
      _updatePurchaseOrder),
  TypedReducer<PurchaseOrderState, AddPurchaseOrderSuccess>(_addPurchaseOrder),
  TypedReducer<PurchaseOrderState, LoadPurchaseOrdersSuccess>(
      _setLoadedPurchaseOrders),
  TypedReducer<PurchaseOrderState, LoadPurchaseOrderSuccess>(
      _setLoadedPurchaseOrder),
  TypedReducer<PurchaseOrderState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<PurchaseOrderState, ArchivePurchaseOrdersSuccess>(
      _archivePurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, DeletePurchaseOrdersSuccess>(
      _deletePurchaseOrderSuccess),
  TypedReducer<PurchaseOrderState, RestorePurchaseOrdersSuccess>(
      _restorePurchaseOrderSuccess),
]);

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

PurchaseOrderState _addPurchaseOrder(
    PurchaseOrderState purchaseOrderState, AddPurchaseOrderSuccess action) {
  return purchaseOrderState.rebuild((b) => b
    ..map[action.purchaseOrder.id] = action.purchaseOrder
    ..list.add(action.purchaseOrder.id));
}

PurchaseOrderState _updatePurchaseOrder(
    PurchaseOrderState purchaseOrderState, SavePurchaseOrderSuccess action) {
  return purchaseOrderState
      .rebuild((b) => b..map[action.purchaseOrder.id] = action.purchaseOrder);
}

PurchaseOrderState _setLoadedPurchaseOrder(
    PurchaseOrderState purchaseOrderState, LoadPurchaseOrderSuccess action) {
  return purchaseOrderState
      .rebuild((b) => b..map[action.purchaseOrder.id] = action.purchaseOrder);
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
