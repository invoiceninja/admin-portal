// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit_vm.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';

class PurchaseOrderEditDetailsScreen extends StatelessWidget {
  const PurchaseOrderEditDetailsScreen({Key? key, required this.viewModel})
      : super(key: key);

  final AbstractInvoiceEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderEditDetailsVM>(
      converter: (Store<AppState> store) {
        return PurchaseOrderEditDetailsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        if (viewModel.state!.prefState.isEditorFullScreen(EntityType.invoice)) {
          return InvoiceEditDesktop(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
            key: ValueKey('__purchaseOrder_${viewModel.invoice!.id}__'),
          );
        } else {
          return InvoiceEditDetails(
            viewModel: viewModel,
            entityType: EntityType.purchaseOrder,
          );
        }
      },
    );
  }
}

class PurchaseOrderEditDetailsVM extends EntityEditDetailsVM {
  PurchaseOrderEditDetailsVM({
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    Function(InvoiceEntity)? onChanged,
    Function(BuildContext, InvoiceEntity, ClientEntity?)? onClientChanged,
    Function(BuildContext, InvoiceEntity, VendorEntity?)? onVendorChanged,
    BuiltMap<String, ClientEntity>? clientMap,
    BuiltList<String>? clientList,
    Function(BuildContext context, Completer<SelectableEntity> completer)?
        onAddClientPressed,
    Function(BuildContext context, Completer<SelectableEntity> completer)?
        onAddVendorPressed,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          onChanged: onChanged,
          onClientChanged: onClientChanged,
          onVendorChanged: onVendorChanged,
          clientMap: clientMap,
          clientList: clientList,
          onAddClientPressed: onAddClientPressed,
          onAddVendorPressed: onAddVendorPressed,
        );

  factory PurchaseOrderEditDetailsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final purchaseOrder = state.purchaseOrderUIState.editing;
    final company = state.company;

    return PurchaseOrderEditDetailsVM(
      state: state,
      company: company,
      invoice: purchaseOrder,
      onChanged: (InvoiceEntity purchaseOrder) =>
          store.dispatch(UpdatePurchaseOrder(purchaseOrder)),
      clientMap: state.clientState.map,
      clientList: state.clientState.list,
      onVendorChanged: (context, purchaseOrder, vendor) {
        store.dispatch(UpdatePurchaseOrder(purchaseOrder));
        store.dispatch(UpdatePurchaseOrderVendor(vendor: vendor));
      },
      onAddVendorPressed: (context, completer) {
        createEntity(
            entity: VendorEntity(state: state),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then<Null>((_) {
                store.dispatch(
                    UpdateCurrentRoute(PurchaseOrderEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(PurchaseOrderEditScreen.route));
        });
      },
    );
  }
}
