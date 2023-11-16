// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditContacts extends StatelessWidget {
  const InvoiceEditContacts({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EntityEditContactsVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice!;
    final client = viewModel.client;
    final vendor = viewModel.vendor;

    if (invoice.isPurchaseOrder) {
      List<VendorContactEntity> vendorContacts;
      if (vendor == null) {
        if (viewModel.state.prefState.isDesktop) {
          vendorContacts = [];
        } else {
          return HelpText(localization!.noClientSelected);
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

          return _ContactListTile(
            fullName: contact.fullName,
            email: contact.email,
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
          return HelpText(localization!.noClientSelected);
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
          return _ContactListTile(
            fullName: contact.fullName,
            email: contact.email,
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

class _ContactListTile extends StatelessWidget {
  const _ContactListTile({
    required this.fullName,
    required this.email,
    required this.invoice,
    this.invitation,
    this.onTap,
  });

  final String fullName;
  final String email;
  final InvoiceEntity invoice;
  final InvitationEntity? invitation;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final invitationButton = (invitation?.link ?? '').isNotEmpty
        ? IconButton(
            tooltip: localization.copyLink,
            icon: Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: invitation!.link));
              showToast(localization.copiedToClipboard.replaceFirst(
                  ':value', invitation!.link.substring(0, 40) + '...'));
            },
          )
        : SizedBox();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Checkbox(
                activeColor: Theme.of(context).colorScheme.secondary,
                value: invitation != null,
                onChanged: (value) => onTap!(),
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
                  fullName.isNotEmpty
                      ? fullName
                      : AppLocalization.of(context)!.blankContact,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (email.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      email,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  if ((invitation?.emailStatus ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        localization.lookup(invitation!.latestEmailStatus) +
                            ' • ' +
                            formatDate(
                                invitation!.latestEmailStatusDate, context),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  if ((invitation?.emailError ?? '').isNotEmpty &&
                      invitation?.emailStatus !=
                          InvitationEntity.EMAIL_STATUS_DELIVERED)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        invitation!.emailError,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  SizedBox(height: 8),
                ],
              ],
            ),
          ),
          if (!store.state.prefState.showPdfPreviewSideBySide) invitationButton,
        ],
      ),
    );
  }
}
