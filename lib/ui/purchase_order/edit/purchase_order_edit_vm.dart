import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/view/purchase_order_view_vm.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PurchaseOrderEditScreen extends StatelessWidget {
  const PurchaseOrderEditScreen({Key key}) : super(key: key);
  static const String route = '/purchase_order/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderEditVM>(
      converter: (Store<AppState> store) {
        return PurchaseOrderEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return PurchaseOrderEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.purchaseOrder.updatedAt),
        );
      },
    );
  }
}

class PurchaseOrderEditVM {
  PurchaseOrderEditVM({
    @required this.state,
    @required this.purchaseOrder,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origPurchaseOrder,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory PurchaseOrderEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final purchaseOrder = state.purchaseOrderUIState.editing;

    return PurchaseOrderEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origPurchaseOrder: state.purchaseOrderState.map[purchaseOrder.id],
      purchaseOrder: purchaseOrder,
      company: state.company,
      onChanged: (InvoiceEntity purchaseOrder) {
        store.dispatch(UpdatePurchaseOrder(purchaseOrder));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: InvoiceEntity(), force: true);
        if (state.purchaseOrderUIState.cancelCompleter != null) {
          state.purchaseOrderUIState.cancelCompleter.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final purchaseOrder = store.state.purchaseOrderUIState.editing;
          final localization = AppLocalization.of(context);
          final Completer<InvoiceEntity> completer =
              new Completer<InvoiceEntity>();
          store.dispatch(SavePurchaseOrderRequest(
              completer: completer, purchaseOrder: purchaseOrder));
          return completer.future.then((savedPurchaseOrder) {
            showToast(purchaseOrder.isNew
                ? localization.createdPurchaseOrder
                : localization.updatedPurchaseOrder);
            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(PurchaseOrderViewScreen.route));
              if (purchaseOrder.isNew) {
                Navigator.of(context)
                    .pushReplacementNamed(PurchaseOrderViewScreen.route);
              } else {
                Navigator.of(context).pop(savedPurchaseOrder);
              }
            } else {
              viewEntity(entity: savedPurchaseOrder, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final InvoiceEntity purchaseOrder;
  final CompanyEntity company;
  final Function(InvoiceEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final InvoiceEntity origPurchaseOrder;
  final AppState state;
}
