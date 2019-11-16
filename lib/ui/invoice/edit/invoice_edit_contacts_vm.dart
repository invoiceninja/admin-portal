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
    @required this.onAddContact,
    @required this.onRemoveContact,
  });

  final CompanyEntity company;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final Function(ContactEntity) onAddContact;
  final Function(InvitationEntity) onRemoveContact;
}

class InvoiceEditContactsVM extends EntityEditContactsVM {
  InvoiceEditContactsVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    Function(ContactEntity) onAddContact,
    Function(InvitationEntity) onRemoveContact,
  }) : super(
          company: company,
          invoice: invoice,
          client: client,
          onAddContact: onAddContact,
          onRemoveContact: onRemoveContact,
        );

  factory InvoiceEditContactsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditContactsVM(
      company: state.company,
      invoice: invoice,
      client: state.clientState.map[invoice.clientId],
      onAddContact: (ContactEntity contact) {
        InvitationEntity invitation;
        // prevent un-checking/checking a contact
        // from creating a new invitation
        if (invoice.isOld) {
          invitation = state.invoiceState.map[invoice.id]
              .getInvitationForContact(contact);
        }
        store.dispatch(
            AddInvoiceContact(contact: contact, invitation: invitation));
      },
      onRemoveContact: (InvitationEntity invitation) =>
          store.dispatch(RemoveInvoiceContact(invitation: invitation)),
    );
  }
}
