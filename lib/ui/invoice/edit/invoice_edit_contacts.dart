// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import '../../../redux/app/app_state.dart';

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
        showScrollbar: true,
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
    final store = StoreProvider.of<AppState>(context);
    final invitationButton = (invitation?.link ?? '').isNotEmpty
        ? IconButton(
            tooltip: localization.copyLink,
            icon: Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: invitation.link));
              showToast(localization.copiedToClipboard.replaceFirst(
                  ':value', invitation.link.substring(0, 40) + '...'));
            },
          )
        : SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Checkbox(
                activeColor: Theme.of(context).colorScheme.secondary,
                value: invitation != null,
                onChanged: (value) => onTap(),
              ),
              if (store.state.prefState.showPdfPreviewSideBySide)
                invitationButton,
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientContact.fullName.isNotEmpty
                      ? clientContact.fullName
                      : AppLocalization.of(context).blankContact,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                if (clientContact.email != null)
                  Text(
                    clientContact.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
              ],
            ),
          ),
          if (!store.state.prefState.showPdfPreviewSideBySide) invitationButton,
        ],
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
    final store = StoreProvider.of<AppState>(context);
    final invitationButton = (invitation?.link ?? '').isNotEmpty
        ? IconButton(
            tooltip: localization.copyLink,
            icon: Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: invitation.link));
              showToast(localization.copiedToClipboard.replaceFirst(
                  ':value', invitation.link.substring(0, 40) + '...'));
            },
          )
        : SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Checkbox(
                activeColor: Theme.of(context).colorScheme.secondary,
                value: invitation != null,
                onChanged: (value) => onTap(),
              ),
              if (store.state.prefState.showPdfPreviewSideBySide)
                invitationButton,
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vendorContact.fullName.isNotEmpty
                      ? vendorContact.fullName
                      : AppLocalization.of(context).blankContact,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                if (vendorContact.email != null)
                  Text(
                    vendorContact.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
              ],
            ),
          ),
          if (!store.state.prefState.showPdfPreviewSideBySide) invitationButton,
        ],
      ),
    );
  }
}
