import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CreditPdfScreen extends StatelessWidget {
  const CreditPdfScreen({Key key}) : super(key: key);

  static const String route = '/credit/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoicePdfVM>(
      converter: (Store<AppState> store) {
        return InvoicePdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoicePdfView(
          key: ValueKey('__credit_pdf_${vm.invoice.id}__'),
          viewModel: vm,
        );
      },
    );
  }
}

class CreditPdfVM extends EntityPdfVM {
  CreditPdfVM({
    AppState state,
    InvoiceEntity invoice,
  }) : super(
          state: state,
          invoice: invoice,
        );

  factory CreditPdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoiceId = state.uiState.creditUIState.selectedId;
    final invoice = state.creditState.get(invoiceId);

    return CreditPdfVM(
      state: state,
      invoice: invoice,
    );
  }
}
