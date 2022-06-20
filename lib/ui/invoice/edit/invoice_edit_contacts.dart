// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
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

    List<ClientContactEntity> contacts;
    if (client == null) {
      if (viewModel.state.prefState.isDesktop) {
        contacts = [];
      } else {
        return HelpText(localization.noClientSelected);
      }
    } else {
      contacts = client.contacts.toList()
        ..sort((contactA, contactB) {
          if (contactA.sendEmail != contactB.sendEmail) {
            return contactA.sendEmail ? 1 : -1;
          } else {
            return contactA.fullName
                .toLowerCase()
                .compareTo(contactB.fullName.toLowerCase());
          }
        });
    }

    return ScrollableListView(
      children: contacts.map((contact) {
        final invitation = invoice.getInvitationForClientContact(contact);
        return _ContactListTile(
          clientContact: contact,
          invoice: invoice,
          invitation: invitation,
          onTap: () => invitation == null
              ? viewModel.onAddClientContact(contact)
              : viewModel.onRemoveContact(invitation),
        );
      }).toList(),
    );
  }
}

class _ContactListTile extends StatelessWidget {
  const _ContactListTile({
    this.clientContact,
    this.invoice,
    this.invitation,
    this.onTap,
  });

  final InvoiceEntity invoice;
  final ClientContactEntity clientContact;
  final InvitationEntity invitation;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListTile(
      title: Text(clientContact.fullName.isNotEmpty
          ? clientContact.fullName
          : AppLocalization.of(context).blankContact),
      subtitle: clientContact.email != null ? Text(clientContact.email) : null,
      onTap: onTap,
      leading: IgnorePointer(
        child: Checkbox(
          activeColor: Theme.of(context).colorScheme.secondary,
          value: invitation != null,
          onChanged: (value) => null,
        ),
      ),
      trailing: (invitation?.link ?? '').isEmpty
          ? null
          : IconButton(
              tooltip: localization.copyLink,
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: invitation.link));
                showToast(localization.copiedToClipboard.replaceFirst(
                    ':value', invitation.link.substring(0, 40) + '...'));
              },
            ),
    );
  }
}
