import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/email_invoice_dialog.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class EmailInvoiceDialog extends StatelessWidget {

  const EmailInvoiceDialog({Key key, this.invoice}) : super(key: key);

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailInvoiceDialogVM>(
      onInit: (Store<AppState> store) {
        final client = store.state.clientState.map[invoice.clientId];
        if (client.areActivitiesStale) {
          store.dispatch(LoadClient(clientId: client.id, loadActivities: true));
        }
      },
      converter: (Store<AppState> store) {
        return EmailInvoiceDialogVM.fromStore(store, invoice);
      },
      builder: (context, vm) {
        return EmailInvoiceView(
          viewModel: vm,
        );
      },
    );
  }
}

class EmailInvoiceDialogVM {
  final InvoiceEntity invoice;
  final ClientEntity client;
  //final List<ContactEntity> recipients;

  EmailInvoiceDialogVM({
    @required this.invoice,
    @required this.client,
    //@required this.recipients,
  });

  factory EmailInvoiceDialogVM.fromStore(
      Store<AppState> store, InvoiceEntity invoice) {
    final state = store.state;

    return EmailInvoiceDialogVM(
      invoice: invoice,
      client: state.clientState.map[invoice.clientId],
        /*
        recipients: invoice.invitations.map((invitation,) {
          final client = state.clientState.map[invoice.clientId];
          client.contacts.where((contact) => contact.id == invitation.;
        }).toList(),
        */
    );
  }
}
