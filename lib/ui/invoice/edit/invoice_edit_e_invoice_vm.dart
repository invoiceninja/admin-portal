// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_e_invoice.dart';

class InvoiceEditEInvoiceScreen extends StatelessWidget {
  const InvoiceEditEInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditEInvoiceVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditEInvoiceVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditEInvoice(viewModel: viewModel);
      },
    );
  }
}

class EntityEditEInvoiceVM {
  EntityEditEInvoiceVM({
    required this.state,
    required this.company,
    required this.invoice,
    required this.onChanged,
  });

  final AppState? state;
  final CompanyEntity? company;
  final InvoiceEntity? invoice;
  final Function(InvoiceEntity)? onChanged;
}

class InvoiceEditEInvoiceVM extends EntityEditEInvoiceVM {
  InvoiceEditEInvoiceVM({
    required CompanyEntity? company,
    required InvoiceEntity? invoice,
    required Function(InvoiceEntity) onChanged,
    required AppState state,
  }) : super(
          company: company,
          invoice: invoice,
          onChanged: onChanged,
          state: state,
        );

  factory InvoiceEditEInvoiceVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditEInvoiceVM(
      company: state.company,
      invoice: invoice,
      onChanged: (InvoiceEntity invoice) =>
          store.dispatch(UpdateInvoice(invoice)),
      state: state,
    );
  }
}
