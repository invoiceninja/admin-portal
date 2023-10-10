// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_email_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class PurchaseOrderEmailScreen extends StatelessWidget {
  const PurchaseOrderEmailScreen({Key? key}) : super(key: key);

  static const String route = '/purchase_order/email';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailPurchaseOrderVM>(
      onInit: (Store<AppState> store) {
        final state = store.state;
        final purchaseOrderId = state.uiState.purchaseOrderUIState.selectedId;
        final purchaseOrder = state.purchaseOrderState.map[purchaseOrderId]!;
        final vendor = state.vendorState.map[purchaseOrder.vendorId]!;
        if (vendor.isStale) {
          store.dispatch(LoadVendor(vendorId: vendor.id));
        }
      },
      converter: (Store<AppState> store) {
        final state = store.state;
        final purchaseOrderId = state.uiState.purchaseOrderUIState.selectedId;
        final purchaseOrder = state.purchaseOrderState.map[purchaseOrderId]!;
        return EmailPurchaseOrderVM.fromStore(store, purchaseOrder);
      },
      builder: (context, viewModel) {
        return InvoiceEmailView(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EmailPurchaseOrderVM extends EmailEntityVM {
  EmailPurchaseOrderVM({
    required AppState state,
    required bool isLoading,
    required bool isSaving,
    required CompanyEntity? company,
    required InvoiceEntity invoice,
    required ClientEntity? client,
    required VendorEntity? vendor,
    required Function(BuildContext, EmailTemplate, String, String, String)
        onSendPressed,
  }) : super(
          state: state,
          isLoading: isLoading,
          isSaving: isSaving,
          company: company,
          invoice: invoice,
          client: client,
          vendor: vendor,
          onSendPressed: onSendPressed,
        );

  factory EmailPurchaseOrderVM.fromStore(
      Store<AppState> store, InvoiceEntity purchaseOrder) {
    final state = store.state;

    return EmailPurchaseOrderVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      company: state.company,
      invoice: purchaseOrder,
      client: state.clientState.map[purchaseOrder.clientId],
      vendor: state.vendorState.map[purchaseOrder.vendorId],
      onSendPressed: (context, template, subject, body, ccEmail) {
        final completer = snackBarCompleter<Null>(
            AppLocalization.of(context)!.emailedPurchaseOrder,
            shouldPop: isMobile(context));
        if (!isMobile(context)) {
          completer.future.then<Null>((_) {
            viewEntity(entity: purchaseOrder);
          });
        }
        store.dispatch(EmailPurchaseOrderRequest(
          completer: completer,
          purchaseOrderId: purchaseOrder.id,
          template: template,
          subject: subject,
          body: body,
          ccEmail: ccEmail,
        ));
      },
    );
  }
}
