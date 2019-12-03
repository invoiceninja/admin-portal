import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditContacts extends StatelessWidget {
  const InvoiceEditContacts({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditContactsVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice;
    final client = viewModel.client;

    List<ContactEntity> contacts;
    if (client == null) {
      if (viewModel.state.prefState.isDesktop) {
        contacts = [];
      } else {
        return HelpText(localization.noClientSelected);
      }
    } else {
      contacts = client.contacts.toList()
        ..sort((contactA, contactB) {
          if (contactA.sendInvoice != contactB.sendInvoice) {
            return contactA.sendInvoice ? 1 : -1;
          } else {
            return contactA.fullName
                .toLowerCase()
                .compareTo(contactB.fullName.toLowerCase());
          }
        });
    }

    return ListView(
      children: contacts.map((contact) {
        final invitation = invoice.getInvitationForContact(contact);
        return _ContactListTile(
          contact: contact,
          invoice: invoice,
          invitation: invitation,
          onTap: () => invitation == null
              ? viewModel.onAddContact(contact)
              : viewModel.onRemoveContact(invitation),
        );
      }).toList(),
    );
  }
}

class _ContactListTile extends StatelessWidget {
  const _ContactListTile({
    this.contact,
    this.invoice,
    this.invitation,
    this.onTap,
  });

  final InvoiceEntity invoice;
  final ContactEntity contact;
  final InvitationEntity invitation;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullName.isNotEmpty
          ? contact.fullName
          : AppLocalization.of(context).blankContact),
      subtitle: contact.email != null ? Text(contact.email) : null,
      onTap: onTap,
      leading: Checkbox(
        activeColor: Theme.of(context).accentColor,
        value: invitation != null,
        onChanged: (value) => null,
      ),
    );
  }
}
