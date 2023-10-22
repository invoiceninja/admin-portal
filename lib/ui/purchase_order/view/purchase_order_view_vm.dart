// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PurchaseOrderViewScreen extends StatelessWidget {
  const PurchaseOrderViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);

  final bool isFilter;
  static const String route = '/purchase_order/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderViewVM>(
      //distinct: true,
      converter: (Store<AppState> store) {
        return PurchaseOrderViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceView(
          viewModel: viewModel,
          isFilter: isFilter,
          tabIndex: viewModel.state!.purchaseOrderUIState.tabIndex,
        );
      },
    );
  }
}

class PurchaseOrderViewVM extends AbstractInvoiceViewVM {
  PurchaseOrderViewVM({
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    ClientEntity? client,
    bool? isSaving,
    bool? isDirty,
    Function(BuildContext, EntityAction)? onEntityAction,
    Function(BuildContext, [int])? onEditPressed,
    Function(BuildContext)? onPaymentsPressed,
    Function(BuildContext, PaymentEntity)? onPaymentPressed,
    Function(BuildContext)? onRefreshed,
    Function(BuildContext, List<MultipartFile>, bool)? onUploadDocuments,
    Function(BuildContext, DocumentEntity)? onViewExpense,
    Function(BuildContext, InvoiceEntity, [String?])? onViewPdf,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          client: client,
          isSaving: isSaving,
          isDirty: isDirty,
          onActionSelected: onEntityAction,
          onEditPressed: onEditPressed,
          onPaymentsPressed: onPaymentsPressed,
          onRefreshed: onRefreshed,
          onUploadDocuments: onUploadDocuments,
          onViewExpense: onViewExpense,
          onViewPdf: onViewPdf,
        );

  factory PurchaseOrderViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final purchaseOrder =
        state.purchaseOrderState.map[state.purchaseOrderUIState.selectedId] ??
            InvoiceEntity(id: state.purchaseOrderUIState.selectedId);
    final client = store.state.clientState.map[purchaseOrder.clientId] ??
        ClientEntity(id: purchaseOrder.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadPurchaseOrder(
          completer: completer, purchaseOrderId: purchaseOrder.id));
      return completer.future;
    }

    return PurchaseOrderViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: purchaseOrder.isNew,
      invoice: purchaseOrder,
      client: client,
      onEditPressed: (BuildContext context, [int? index]) {
        editEntity(
            entity: purchaseOrder,
            subIndex: index,
            completer: snackBarCompleter<InvoiceEntity>(
                AppLocalization.of(context)!.updatedPurchaseOrder));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([purchaseOrder], action, autoPop: true),
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFile, bool isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SavePurchaseOrderDocumentRequest(
            isPrivate: isPrivate,
            multipartFiles: multipartFile,
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
      onViewPdf: (context, purchaseOrder, [activityId]) {
        store.dispatch(ShowPdfPurchaseOrder(
            context: context,
            purchaseOrder: purchaseOrder,
            activityId: activityId));
      },
    );
  }
}
