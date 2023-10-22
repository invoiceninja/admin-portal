// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/view/purchase_order_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class PurchaseOrderEditScreen extends StatelessWidget {
  const PurchaseOrderEditScreen({Key? key}) : super(key: key);

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
          key: ValueKey(viewModel.invoice!.updatedAt),
        );
      },
    );
  }
}

class PurchaseOrderEditVM extends AbstractInvoiceEditVM {
  PurchaseOrderEditVM({
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? purchaseOrder,
    int? invoiceItemIndex,
    InvoiceEntity? origInvoice,
    Function(BuildContext, [EntityAction?])? onSavePressed,
    Function(List<InvoiceItemEntity>, String?, String?)? onItemsAdded,
    bool? isSaving,
    Function(BuildContext)? onCancelPressed,
    Function(BuildContext, List<MultipartFile>, bool?)? onUploadDocuments,
  }) : super(
          state: state,
          company: company,
          invoice: purchaseOrder,
          invoiceItemIndex: invoiceItemIndex,
          origInvoice: origInvoice,
          onSavePressed: onSavePressed,
          onItemsAdded: onItemsAdded,
          isSaving: isSaving,
          onCancelPressed: onCancelPressed,
          onUploadDocuments: onUploadDocuments,
        );

  factory PurchaseOrderEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final purchaseOrder = state.purchaseOrderUIState.editing!;

    return PurchaseOrderEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      purchaseOrder: purchaseOrder,
      invoiceItemIndex: state.purchaseOrderUIState.editingItemIndex,
      origInvoice: store.state.purchaseOrderState.map[purchaseOrder.id],
      onSavePressed: (BuildContext context, [EntityAction? action]) {
        Debouncer.runOnComplete(() {
          final purchaseOrder = store.state.purchaseOrderUIState.editing!;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          if (purchaseOrder.vendorId.isEmpty) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(localization!.pleaseSelectAVendor);
                });
            return null;
          }
          if (purchaseOrder.isOld &&
              purchaseOrder.isChanged != true &&
              action != null &&
              action.isClientSide) {
            handleEntityAction(purchaseOrder, action);
          } else {
            final Completer<InvoiceEntity> completer =
                Completer<InvoiceEntity>();
            store.dispatch(SavePurchaseOrderRequest(
              completer: completer,
              purchaseOrder: purchaseOrder,
              action: action,
            ));
            return completer.future.then((savedPurchaseOrder) {
              showToast(purchaseOrder.isNew
                  ? localization!.createdPurchaseOrder
                  : localization!.updatedPurchaseOrder);

              if (state.prefState.isMobile) {
                store.dispatch(
                    UpdateCurrentRoute(PurchaseOrderViewScreen.route));
                if (purchaseOrder.isNew) {
                  navigator!
                      .pushReplacementNamed(PurchaseOrderViewScreen.route);
                } else {
                  navigator!.pop(savedPurchaseOrder);
                }
              } else {
                if (!state.prefState.isPreviewVisible) {
                  store.dispatch(TogglePreviewSidebar());
                }

                viewEntity(entity: savedPurchaseOrder);

                if (state.prefState.isEditorFullScreen(EntityType.invoice) &&
                    state.prefState.editAfterSaving) {
                  editEntity(entity: savedPurchaseOrder);
                }
              }

              if (action != null && action.isClientSide) {
                handleEntityAction(savedPurchaseOrder, action);
              } else if (action != null && action.requiresSecondRequest) {
                handleEntityAction(savedPurchaseOrder, action);
                viewEntity(entity: savedPurchaseOrder, force: true);
              }
            }).catchError((Object error) {
              showDialog<ErrorDialog>(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return ErrorDialog(error);
                  });
            });
          }
        });
      },
      onItemsAdded: (items, clientId, projectId) {
        if (items.length == 1) {
          store.dispatch(EditPurchaseOrderItem(purchaseOrder.lineItems.length));
        }
        store.dispatch(AddPurchaseOrderItems(items));
      },
      onCancelPressed: (BuildContext context) {
        if (['pdf', 'email'].contains(state.uiState.previousSubRoute)) {
          viewEntitiesByType(entityType: EntityType.purchaseOrder);
        } else {
          createEntity(entity: InvoiceEntity(), force: true);
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFiles, bool? isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SavePurchaseOrderDocumentRequest(
            isPrivate: isPrivate,
            multipartFiles: multipartFiles,
            purchaseOrder: purchaseOrder,
            completer: completer));
        completer.future.then((client) {
          showToast(AppLocalization.of(context)!.uploadedDocument);
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }
}
