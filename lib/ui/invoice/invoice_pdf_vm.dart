import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoicePdfScreen extends StatelessWidget {
  const InvoicePdfScreen({Key key}) : super(key: key);

  static const String route = '/invoice/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoicePdfVM>(
      converter: (Store<AppState> store) {
        return InvoicePdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoicePdfView(
          key: ValueKey('__invoice_pdf_${vm.invoice.id}__'),
          viewModel: vm,
        );
      },
    );
  }
}

abstract class EntityPdfVM {
  EntityPdfVM({
    @required this.state,
    @required this.invoice,
  });

  final AppState state;
  final InvoiceEntity invoice;
}

class InvoicePdfVM extends EntityPdfVM {
  InvoicePdfVM({
    AppState state,
    InvoiceEntity invoice,
  }) : super(
          state: state,
          invoice: invoice,
        );

  factory InvoicePdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoiceId = state.uiState.invoiceUIState.selectedId;
    final invoice = state.invoiceState.get(invoiceId);

    return InvoicePdfVM(
      state: state,
      invoice: invoice,
    );
  }
}
