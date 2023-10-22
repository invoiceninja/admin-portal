// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_pdf.dart';

class InvoiceEditPDFScreen extends StatelessWidget {
  const InvoiceEditPDFScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditPDFVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditPDFVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditPDF(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityEditPDFVM {
  EntityEditPDFVM({
    required this.state,
    required this.company,
    required this.invoice,
  });

  final AppState state;
  final CompanyEntity? company;
  final InvoiceEntity? invoice;
}

class InvoiceEditPDFVM extends EntityEditPDFVM {
  InvoiceEditPDFVM({
    required CompanyEntity? company,
    required InvoiceEntity? invoice,
    required AppState state,
  }) : super(
          company: company,
          invoice: invoice,
          state: state,
        );

  factory InvoiceEditPDFVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditPDFVM(
      company: state.company,
      invoice: invoice,
      state: state,
    );
  }
}
