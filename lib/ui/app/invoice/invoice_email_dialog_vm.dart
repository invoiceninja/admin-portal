import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_email_dialog.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceEmailDialog extends StatelessWidget {
  static const String route = '/invoice/email';

  const InvoiceEmailDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailInvoiceDialogVM>(
      onInit: (Store<AppState> store) {
        final invoiceId = store.state.uiState.invoiceUIState.selectedId;
        final invoice = store.state.invoiceState.map[invoiceId];
        final client = store.state.clientState.map[invoice.clientId];
        if (client.areActivitiesStale) {
          store.dispatch(LoadClient(clientId: client.id, loadActivities: true));
        }
      },
      converter: (Store<AppState> store) {
        final invoiceId = store.state.uiState.invoiceUIState.selectedId;
        final invoice = store.state.invoiceState.map[invoiceId];
        return EmailInvoiceDialogVM.fromStore(store, invoice);
      },
      builder: (context, vm) {
        return InvoiceEmailView(
          viewModel: vm,
        );
      },
    );
  }
}

class EmailInvoiceDialogVM {
  final CompanyEntity company;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final Function(EmailTemplate, String, String) onSendPressed;

  //final List<ContactEntity> recipients;

  EmailInvoiceDialogVM({
    @required this.company,
    @required this.invoice,
    @required this.client,
    @required this.onSendPressed,
    //@required this.recipients,
  });

  factory EmailInvoiceDialogVM.fromStore(
      Store<AppState> store, InvoiceEntity invoice) {
    final state = store.state;

    return EmailInvoiceDialogVM(
        company: state.selectedCompany,
        invoice: invoice,
        client: state.clientState.map[invoice.clientId],
        onSendPressed: (template, subject, body) => store.dispatch(EmailInvoiceRequest(
              invoiceId: invoice.id,
              template: template,
              subject: subject,
              body: body,
            ))
        /*
        recipients: invoice.invitations.map((invitation,) {
          final client = state.clientState.map[invoice.clientId];
          client.contacts.where((contact) => contact.id == invitation.;
        }).toList(),
        */
        );
  }
}
