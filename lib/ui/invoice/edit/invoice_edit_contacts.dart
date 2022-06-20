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
    final vendor = viewModel.vendor;

    if (invoice.isPurchaseOrder) {
      List<VendorContactEntity> vendorContacts;
      if (vendor == null) {
        if (viewModel.state.prefState.isDesktop) {
          vendorContacts = [];
        } else {
          return HelpText(localization.noClientSelected);
        }
      } else {
        vendorContacts = vendor.contacts.toList()
          ..sort((contactA, contactB) {
            /*
            if (contactA.sendEmail != contactB.sendEmail) {
              return contactA.sendEmail ? 1 : -1;
            } else {
              return contactA.fullName
                  .toLowerCase()
                  .compareTo(contactB.fullName.toLowerCase());
            }
            */
            return contactA.fullName
                .toLowerCase()
                .compareTo(contactB.fullName.toLowerCase());
          });
      }

      return ScrollableListView(
        children: vendorContacts.map((contact) {
          final invitation = invoice.getInvitationForVendorContact(contact);
          return _VendorContactListTile(
            vendorContact: contact,
            invoice: invoice,
            invitation: invitation,
            onTap: () => invitation == null
                ? viewModel.onAddVendorContact(contact)
                : viewModel.onRemoveContact(invitation),
          );
        }).toList(),
      );
    } else {
      List<ClientContactEntity> clientContacts;
      if (client == null) {
        if (viewModel.state.prefState.isDesktop) {
          clientContacts = [];
        } else {
          return HelpText(localization.noClientSelected);
        }
      } else {
        clientContacts = client.contacts.toList()
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
        children: clientContacts.map((contact) {
          final invitation = invoice.getInvitationForClientContact(contact);
          return _ClientContactListTile(
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
}

class _ClientContactListTile extends StatelessWidget {
  const _ClientContactListTile({
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

class _VendorContactListTile extends StatelessWidget {
  const _VendorContactListTile({
    this.vendorContact,
    this.invoice,
    this.invitation,
    this.onTap,
  });

  final InvoiceEntity invoice;
  final VendorContactEntity vendorContact;
  final InvitationEntity invitation;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListTile(
      title: Text(vendorContact.fullName.isNotEmpty
          ? vendorContact.fullName
          : AppLocalization.of(context).blankContact),
      subtitle: vendorContact.email != null ? Text(vendorContact.email) : null,
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
