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

class RecurringInvoiceEditPDFScreen extends StatelessWidget {
  const RecurringInvoiceEditPDFScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceEditPDFVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoiceEditPDFVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditPDF(
          viewModel: viewModel,
        );
      },
    );
  }
}

class RecurringInvoiceEditPDFVM extends EntityEditPDFVM {
  RecurringInvoiceEditPDFVM({
    required CompanyEntity? company,
    required InvoiceEntity? invoice,
    required AppState state,
  }) : super(
          company: company,
          invoice: invoice,
          state: state,
        );

  factory RecurringInvoiceEditPDFVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.recurringInvoiceUIState.editing;

    return RecurringInvoiceEditPDFVM(
      company: state.company,
      invoice: invoice,
      state: state,
    );
  }
}
