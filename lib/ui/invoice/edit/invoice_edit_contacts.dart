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
    //final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final client = viewModel.client;

    if (client == null) {
      return HelpText(localization.noClientSelected);
    }

    return ListView(
      children: client.contacts
          .map((contact) => _ContactListTile(
                contact: contact,
                invoice: invoice,
                onTap: () => null,
              ))
          .toList(),
    );
  }
}

class _ContactListTile extends StatelessWidget {
  const _ContactListTile({
    this.contact,
    this.invoice,
    this.onTap,
  });

  final InvoiceEntity invoice;
  final ContactEntity contact;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final invitation = invoice.getInvitationForContact(contact);

    return ListTile(
      title: Text(contact.fullName),
      subtitle: Text(contact.email),
      onTap: onTap,
      leading: Checkbox(
        value: invitation != null,
        onChanged: (value) => null,
      ),
    );
  }
}
