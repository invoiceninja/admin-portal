// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_pdf.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_pdf_vm.dart';

class PurchaseOrderEditPDFScreen extends StatelessWidget {
  const PurchaseOrderEditPDFScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderEditPDFVM>(
      converter: (Store<AppState> store) {
        return PurchaseOrderEditPDFVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditPDF(
          viewModel: viewModel,
        );
      },
    );
  }
}

class PurchaseOrderEditPDFVM extends EntityEditPDFVM {
  PurchaseOrderEditPDFVM({
    required CompanyEntity? company,
    required InvoiceEntity? invoice,
    required AppState state,
  }) : super(
          company: company,
          invoice: invoice,
          state: state,
        );

  factory PurchaseOrderEditPDFVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.purchaseOrderUIState.editing;

    return PurchaseOrderEditPDFVM(
      company: state.company,
      invoice: invoice,
      state: state,
    );
  }
}
