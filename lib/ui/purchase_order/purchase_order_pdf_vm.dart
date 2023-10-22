// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';

class PurchaseOrderPdfScreen extends StatelessWidget {
  const PurchaseOrderPdfScreen({Key? key, this.showAppBar = true})
      : super(key: key);

  final bool showAppBar;

  static const String route = '/purchase_order/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderPdfVM>(
      converter: (Store<AppState> store) {
        return PurchaseOrderPdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoicePdfView(
          key: ValueKey('__purchase_order_pdf_${vm.invoice!.id}__'),
          viewModel: vm,
          showAppBar: showAppBar,
        );
      },
    );
  }
}

class PurchaseOrderPdfVM extends EntityPdfVM {
  PurchaseOrderPdfVM({
    AppState? state,
    InvoiceEntity? invoice,
    String? activityId,
  }) : super(
          state: state,
          invoice: invoice,
          activityId: activityId,
        );

  factory PurchaseOrderPdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final purchaseOrderUIState = state.uiState.purchaseOrderUIState;
    final invoiceId = purchaseOrderUIState.selectedId!;
    final invoice = state.purchaseOrderState.get(invoiceId);

    return PurchaseOrderPdfVM(
      state: state,
      invoice: invoice,
      activityId: purchaseOrderUIState.historyActivityId,
    );
  }
}
