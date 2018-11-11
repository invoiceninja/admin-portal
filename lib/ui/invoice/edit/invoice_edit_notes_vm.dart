import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceEditNotesScreen extends StatelessWidget {
  const InvoiceEditNotesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditNotesVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditNotesVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditNotes(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityEditNotesVM {
  EntityEditNotesVM({
    @required this.company,
    @required this.invoice,
    @required this.onChanged,
  });

  final CompanyEntity company;
  final InvoiceEntity invoice;
  final Function(InvoiceEntity) onChanged;
}

class InvoiceEditNotesVM extends EntityEditNotesVM {
  InvoiceEditNotesVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    Function(InvoiceEntity) onChanged,
  }) : super(
    company: company,
    invoice: invoice,
    onChanged: onChanged,
  );

  factory InvoiceEditNotesVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditNotesVM(
      company: state.selectedCompany,
      invoice: invoice,
      onChanged: (InvoiceEntity invoice) =>
          store.dispatch(UpdateInvoice(invoice)),
    );
  }
}
