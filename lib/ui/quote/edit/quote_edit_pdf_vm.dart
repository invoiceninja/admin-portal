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

class QuoteEditPDFScreen extends StatelessWidget {
  const QuoteEditPDFScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditPDFVM>(
      converter: (Store<AppState> store) {
        return QuoteEditPDFVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditPDF(
          viewModel: viewModel,
        );
      },
    );
  }
}

class QuoteEditPDFVM extends EntityEditPDFVM {
  QuoteEditPDFVM({
    required CompanyEntity? company,
    required InvoiceEntity? invoice,
    required AppState state,
  }) : super(
          company: company,
          invoice: invoice,
          state: state,
        );

  factory QuoteEditPDFVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.quoteUIState.editing;

    return QuoteEditPDFVM(
      company: state.company,
      invoice: invoice,
      state: state,
    );
  }
}
