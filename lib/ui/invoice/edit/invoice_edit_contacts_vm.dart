import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceEditContactsScreen extends StatelessWidget {
  const InvoiceEditContactsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditContactsVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditContactsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditContacts(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityEditContactsVM {
  EntityEditContactsVM({
    @required this.company,
    @required this.invoice,
    @required this.client,
    @required this.onChanged,
  });

  final CompanyEntity company;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final Function(InvoiceEntity) onChanged;
}

class InvoiceEditContactsVM extends EntityEditContactsVM {
  InvoiceEditContactsVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    Function(InvoiceEntity) onChanged,
  }) : super(
          company: company,
          invoice: invoice,
          client: client,
          onChanged: onChanged,
        );

  factory InvoiceEditContactsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditContactsVM(
      company: state.selectedCompany,
      invoice: invoice,
      client: state.clientState.map[invoice.clientId],
      onChanged: (InvoiceEntity invoice) =>
          store.dispatch(UpdateInvoice(invoice)),
    );
  }
}
