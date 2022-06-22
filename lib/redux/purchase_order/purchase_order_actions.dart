import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';

class ViewPurchaseOrderList implements PersistUI {
  ViewPurchaseOrderList({this.force = false});

  final bool force;
}

class ViewPurchaseOrder implements PersistUI, PersistPrefs {
  ViewPurchaseOrder({
    @required this.purchaseOrderId,
    this.force = false,
  });

  final String purchaseOrderId;
  final bool force;
}

class EditPurchaseOrder implements PersistUI, PersistPrefs {
  EditPurchaseOrder(
      {@required this.purchaseOrder,
      this.completer,
      this.purchaseOrderItemIndex,
      this.cancelCompleter,
      this.force = false});

  final InvoiceEntity purchaseOrder;
  final Completer completer;
  final int purchaseOrderItemIndex;
  final Completer cancelCompleter;
  final bool force;
}

class ShowEmailPurchaseOrder {
  ShowEmailPurchaseOrder({this.purchaseOrder, this.context, this.completer});

  final InvoiceEntity purchaseOrder;
  final BuildContext context;
  final Completer completer;
}

class ShowPdfPurchaseOrder {
  ShowPdfPurchaseOrder({this.purchaseOrder, this.context, this.activityId});

  final InvoiceEntity purchaseOrder;
  final BuildContext context;
  final String activityId;
}

class EditPurchaseOrderItem implements PersistUI {
  EditPurchaseOrderItem([this.itemIndex]);

  final int itemIndex;
}

class UpdatePurchaseOrder implements PersistUI {
  UpdatePurchaseOrder(this.purchaseOrder);

  final InvoiceEntity purchaseOrder;
}

class UpdatePurchaseOrderVendor implements PersistUI {
  UpdatePurchaseOrderVendor({this.vendor});

  final VendorEntity vendor;
}

class LoadPurchaseOrder {
  LoadPurchaseOrder({this.completer, this.purchaseOrderId});

  final Completer completer;
  final String purchaseOrderId;
}

class LoadPurchaseOrderActivity {
  LoadPurchaseOrderActivity({this.completer, this.purchaseOrderId});

  final Completer completer;
  final String purchaseOrderId;
}

class LoadPurchaseOrders {
  LoadPurchaseOrders({this.completer});

  final Completer completer;
}

class LoadPurchaseOrderRequest implements StartLoading {}

class LoadPurchaseOrderFailure implements StopLoading {
  LoadPurchaseOrderFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadPurchaseOrderFailure{error: $error}';
  }
}

class LoadPurchaseOrderSuccess implements StopLoading, PersistData {
  LoadPurchaseOrderSuccess(this.purchaseOrder);

  final InvoiceEntity purchaseOrder;

  @override
  String toString() {
    return 'LoadPurchaseOrderSuccess{purchaseOrder: $purchaseOrder}';
  }
}

class LoadPurchaseOrdersRequest implements StartLoading {}

class LoadPurchaseOrdersFailure implements StopLoading {
  LoadPurchaseOrdersFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadPurchaseOrdersFailure{error: $error}';
  }
}

class LoadPurchaseOrdersSuccess implements StopLoading {
  LoadPurchaseOrdersSuccess(this.purchaseOrders);

  final BuiltList<InvoiceEntity> purchaseOrders;

  @override
  String toString() {
    return 'LoadPurchaseOrdersSuccess{purchaseOrders: $purchaseOrders}';
  }
}

class SavePurchaseOrderRequest implements StartSaving {
  SavePurchaseOrderRequest({
    this.completer,
    this.purchaseOrder,
    this.action,
  });

  final Completer completer;
  final InvoiceEntity purchaseOrder;
  final EntityAction action;
}

class SavePurchaseOrderSuccess implements StopSaving, PersistData, PersistUI {
  SavePurchaseOrderSuccess(this.purchaseOrder);

  final InvoiceEntity purchaseOrder;
}

class AddPurchaseOrderSuccess implements StopSaving, PersistData, PersistUI {
  AddPurchaseOrderSuccess(this.purchaseOrder);

  final InvoiceEntity purchaseOrder;
}

class SavePurchaseOrderFailure implements StopSaving {
  SavePurchaseOrderFailure(this.error);

  final Object error;
}

class ArchivePurchaseOrdersRequest implements StartSaving {
  ArchivePurchaseOrdersRequest(this.completer, this.purchaseOrderIds);

  final Completer completer;
  final List<String> purchaseOrderIds;
}

class ArchivePurchaseOrdersSuccess implements StopSaving, PersistData {
  ArchivePurchaseOrdersSuccess(this.purchaseOrders);

  final List<InvoiceEntity> purchaseOrders;
}

class ArchivePurchaseOrdersFailure implements StopSaving {
  ArchivePurchaseOrdersFailure(this.purchaseOrders);

  final List<InvoiceEntity> purchaseOrders;
}

class DeletePurchaseOrdersRequest implements StartSaving {
  DeletePurchaseOrdersRequest(this.completer, this.purchaseOrderIds);

  final Completer completer;
  final List<String> purchaseOrderIds;
}

class DeletePurchaseOrdersSuccess implements StopSaving, PersistData {
  DeletePurchaseOrdersSuccess(this.purchaseOrders);

  final List<InvoiceEntity> purchaseOrders;
}

class DeletePurchaseOrdersFailure implements StopSaving {
  DeletePurchaseOrdersFailure(this.purchaseOrders);

  final List<InvoiceEntity> purchaseOrders;
}

class RestorePurchaseOrdersRequest implements StartSaving {
  RestorePurchaseOrdersRequest(this.completer, this.purchaseOrderIds);

  final Completer completer;
  final List<String> purchaseOrderIds;
}

class RestorePurchaseOrdersSuccess implements StopSaving, PersistData {
  RestorePurchaseOrdersSuccess(this.purchaseOrders);

  final List<InvoiceEntity> purchaseOrders;
}

class RestorePurchaseOrdersFailure implements StopSaving {
  RestorePurchaseOrdersFailure(this.purchaseOrders);

  final List<InvoiceEntity> purchaseOrders;
}

class EmailPurchaseOrderRequest implements StartSaving {
  EmailPurchaseOrderRequest(
      {this.completer,
      this.purchaseOrderId,
      this.template,
      this.subject,
      this.body});

  final Completer completer;
  final String purchaseOrderId;
  final EmailTemplate template;
  final String subject;
  final String body;
}

class EmailPurchaseOrderSuccess implements StopSaving, PersistData {
  EmailPurchaseOrderSuccess(this.purchaseOrder);

  final InvoiceEntity purchaseOrder;
}

class EmailPurchaseOrderFailure implements StopSaving {
  EmailPurchaseOrderFailure(this.error);

  final dynamic error;
}

class MarkPurchaseOrdersSentRequest implements StartSaving {
  MarkPurchaseOrdersSentRequest(this.completer, this.purchaseOrderIds);

  final Completer completer;
  final List<String> purchaseOrderIds;
}

class MarkPurchaseOrderSentSuccess implements StopSaving, PersistData {
  MarkPurchaseOrderSentSuccess(this.purchaseOrders);

  final List<InvoiceEntity> purchaseOrders;
}

class MarkPurchaseOrderSentFailure implements StopSaving {
  MarkPurchaseOrderSentFailure(this.error);

  final Object error;
}

class ApprovePurchaseOrders implements StartSaving {
  ApprovePurchaseOrders(this.completer, this.purchaseOrderIds);

  final List<String> purchaseOrderIds;
  final Completer completer;
}

class ApprovePurchaseOrderSuccess implements StopSaving {
  ApprovePurchaseOrderSuccess({this.purchaseOrders});

  final List<InvoiceEntity> purchaseOrders;
}

class ApprovePurchaseOrderFailure implements StopSaving {
  ApprovePurchaseOrderFailure(this.error);

  final dynamic error;
}

class AddPurchaseOrderContact implements PersistUI {
  AddPurchaseOrderContact({this.contact, this.invitation});

  final VendorContactEntity contact;
  final InvitationEntity invitation;
}

class RemovePurchaseOrderContact implements PersistUI {
  RemovePurchaseOrderContact({this.invitation});

  final InvitationEntity invitation;
}

class AddPurchaseOrderItem implements PersistUI {
  AddPurchaseOrderItem({this.purchaseOrderItem});

  final InvoiceItemEntity purchaseOrderItem;
}

class MovePurchaseOrderItem implements PersistUI {
  MovePurchaseOrderItem({
    this.oldIndex,
    this.newIndex,
  });

  final int oldIndex;
  final int newIndex;
}

class AddPurchaseOrderItems implements PersistUI {
  AddPurchaseOrderItems(this.lineItems);

  final List<InvoiceItemEntity> lineItems;
}

class UpdatePurchaseOrderItem implements PersistUI {
  UpdatePurchaseOrderItem({this.index, this.purchaseOrderItem});

  final int index;
  final InvoiceItemEntity purchaseOrderItem;
}

class DeletePurchaseOrderItem implements PersistUI {
  DeletePurchaseOrderItem(this.index);

  final int index;
}

class FilterPurchaseOrders implements PersistUI {
  FilterPurchaseOrders(this.filter);

  final String filter;
}

class SortPurchaseOrders implements PersistUI, PersistPrefs {
  SortPurchaseOrders(this.field);

  final String field;
}

class FilterPurchaseOrdersByState implements PersistUI {
  FilterPurchaseOrdersByState(this.state);

  final EntityState state;
}

class FilterPurchaseOrdersByStatus implements PersistUI {
  FilterPurchaseOrdersByStatus(this.status);

  final EntityStatus status;
}

class FilterPurchaseOrderDropdown {
  FilterPurchaseOrderDropdown(this.filter);

  final String filter;
}

class FilterPurchaseOrdersByCustom1 implements PersistUI {
  FilterPurchaseOrdersByCustom1(this.value);

  final String value;
}

class FilterPurchaseOrdersByCustom2 implements PersistUI {
  FilterPurchaseOrdersByCustom2(this.value);

  final String value;
}

class FilterPurchaseOrdersByCustom3 implements PersistUI {
  FilterPurchaseOrdersByCustom3(this.value);

  final String value;
}

class FilterPurchaseOrdersByCustom4 implements PersistUI {
  FilterPurchaseOrdersByCustom4(this.value);

  final String value;
}

class StartPurchaseOrderMultiselect {
  StartPurchaseOrderMultiselect();
}

class AddToPurchaseOrderMultiselect {
  AddToPurchaseOrderMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromPurchaseOrderMultiselect {
  RemoveFromPurchaseOrderMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearPurchaseOrderMultiselect {
  ClearPurchaseOrderMultiselect();
}

class UpdatePurchaseOrderTab implements PersistUI {
  UpdatePurchaseOrderTab({this.tabIndex});

  final int tabIndex;
}

void handlePurchaseOrderAction(BuildContext context,
    List<BaseEntity> purchaseOrders, EntityAction action) {
  if (purchaseOrders.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final purchaseOrder = purchaseOrders.first as InvoiceEntity;
  final purchaseOrderIds =
      purchaseOrders.map((purchaseOrder) => purchaseOrder.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: purchaseOrder);
      break;
    case EntityAction.restore:
      store.dispatch(RestorePurchaseOrdersRequest(
          snackBarCompleter<Null>(context, localization.restoredPurchaseOrder),
          purchaseOrderIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchivePurchaseOrdersRequest(
          snackBarCompleter<Null>(context, localization.archivedPurchaseOrder),
          purchaseOrderIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeletePurchaseOrdersRequest(
          snackBarCompleter<Null>(context, localization.deletedPurchaseOrder),
          purchaseOrderIds));
      break;
    case EntityAction.markSent:
      store.dispatch(MarkPurchaseOrdersSentRequest(
          snackBarCompleter<Null>(
              context,
              purchaseOrders.length == 1
                  ? localization.markedInvoiceAsSent
                  : localization.markedInvoicesAsSent),
          purchaseOrderIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.purchaseOrderListState.isInMultiselect()) {
        store.dispatch(StartPurchaseOrderMultiselect());
      }

      if (purchaseOrders.isEmpty) {
        break;
      }

      for (final purchaseOrder in purchaseOrders) {
        if (!store.state.purchaseOrderListState.isSelected(purchaseOrder.id)) {
          store.dispatch(AddToPurchaseOrderMultiselect(entity: purchaseOrder));
        } else {
          store.dispatch(
              RemoveFromPurchaseOrderMultiselect(entity: purchaseOrder));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [purchaseOrder],
      );
      break;
    default:
      print('## ERROR: unhandled action $action in purchase_order_actions');
      break;
  }
}
