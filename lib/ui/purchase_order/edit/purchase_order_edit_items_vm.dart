// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';

class PurchaseOrderEditItemsScreen extends StatelessWidget {
  const PurchaseOrderEditItemsScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AbstractInvoiceEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderEditItemsVM>(
      converter: (Store<AppState> store) {
        return PurchaseOrderEditItemsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        if (viewModel.state!.prefState.isEditorFullScreen(EntityType.invoice)) {
          return InvoiceEditItemsDesktop(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
            isTasks: false,
          );
        } else {
          return InvoiceEditItems(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
          );
        }
      },
    );
  }
}

class PurchaseOrderEditItemsVM extends EntityEditItemsVM {
  PurchaseOrderEditItemsVM({
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    int? invoiceItemIndex,
    Function? addLineItem,
    Function? deleteLineItem,
    Function(int)? onRemoveInvoiceItemPressed,
    Function? onDoneInvoiceItemPressed,
    Function(InvoiceItemEntity, int)? onChangedInvoiceItem,
    Function(int, int)? onMovedInvoiceItem,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          addLineItem: addLineItem,
          deleteLineItem: deleteLineItem,
          invoiceItemIndex: invoiceItemIndex,
          onRemoveInvoiceItemPressed: onRemoveInvoiceItemPressed,
          clearSelectedInvoiceItem: onDoneInvoiceItemPressed,
          onChangedInvoiceItem: onChangedInvoiceItem,
          onMovedInvoiceItem: onMovedInvoiceItem,
        );

  factory PurchaseOrderEditItemsVM.fromStore(Store<AppState> store) {
    return PurchaseOrderEditItemsVM(
      state: store.state,
      company: store.state.company,
      invoice: store.state.purchaseOrderUIState.editing,
      invoiceItemIndex: store.state.purchaseOrderUIState.editingItemIndex,
      onRemoveInvoiceItemPressed: (index) {
        store.dispatch(DeletePurchaseOrderItem(index));
      },
      onDoneInvoiceItemPressed: () {
        store.dispatch(EditPurchaseOrderItem());
      },
      onChangedInvoiceItem: (purchaseOrderItem, index) {
        final purchaseOrder = store.state.purchaseOrderUIState.editing!;
        if (index == purchaseOrder.lineItems.length) {
          store.dispatch(
              AddPurchaseOrderItem(purchaseOrderItem: purchaseOrderItem));
        } else {
          store.dispatch(UpdatePurchaseOrderItem(
              purchaseOrderItem: purchaseOrderItem, index: index));
        }
      },
      onMovedInvoiceItem: (oldIndex, newIndex) {
        store.dispatch(
          MovePurchaseOrderItem(oldIndex: oldIndex, newIndex: newIndex),
        );
      },
    );
  }
}
