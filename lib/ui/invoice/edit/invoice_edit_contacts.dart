// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

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
            hash: '',
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
            hash: client?.clientHash ?? '',
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

class _ContactListTile extends StatefulWidget {
  const _ContactListTile({
    required this.fullName,
    required this.email,
    required this.invoice,
    required this.hash,
    this.invitation,
    this.onTap,
  });

  final String fullName;
  final String email;
  final String hash;
  final InvoiceEntity invoice;
  final InvitationEntity? invitation;
  final Function? onTap;

  @override
  State<_ContactListTile> createState() => _ContactListTileState();
}

class _ContactListTileState extends State<_ContactListTile> {
  bool _showEmailError = true;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    /*
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
    */

    final invitationButton = (widget.invitation?.link ?? '').isNotEmpty
        ? PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  child: IconText(
                    text: localization.viewPortal,
                    icon: Icons.open_in_new,
                  ),
                  value: localization.viewPortal,
                ),
                PopupMenuItem<String>(
                  child: IconText(
                    text: localization.copyLink,
                    icon: Icons.copy,
                  ),
                  value: localization.copyLink,
                ),
              ];
            },
            onSelected: (String action) {
              var viewLinkWithHash = widget.invitation!.silentLink;
              if (!viewLinkWithHash.contains('?')) {
                viewLinkWithHash += '?';
              }
              viewLinkWithHash += '&client_hash=${widget.hash}';

              if (action == localization.viewPortal) {
                launchUrl(Uri.parse(viewLinkWithHash));
              } else if (action == localization.copyLink) {
                Clipboard.setData(ClipboardData(text: widget.invitation!.link));
                showToast(
                    localization.copiedToClipboard.replaceFirst(':value ', ''));
              } else if (action == localization.reactivateEmail) {
                //
              }
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
                value: widget.invitation != null,
                onChanged: (value) => widget.onTap!(),
              ),
              if (store.state.prefState.showPdfPreviewSideBySide)
                invitationButton,
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.fullName.isNotEmpty
                      ? widget.fullName
                      : AppLocalization.of(context)!.blankContact,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (widget.email.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.email,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  if ((widget.invitation?.emailStatus ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        localization
                                .lookup(widget.invitation!.latestEmailStatus) +
                            ' • ' +
                            formatDate(widget.invitation!.latestEmailStatusDate,
                                context),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  if ((widget.invitation?.emailError ?? '').isNotEmpty &&
                      widget.invitation?.emailStatus !=
                          InvitationEntity.EMAIL_STATUS_DELIVERED &&
                      _showEmailError) ...[
                    if (state.isUsingPostmark) ...[
                      SizedBox(height: 16),
                      OutlinedButton(
                          onPressed: () {
                            final credentials = state.credentials;
                            store.dispatch(StartSaving());
                            WebClient()
                                .post(
                                    '${credentials.url}/reactivate_email/${widget.invitation!.messageId}',
                                    credentials.token)
                                .then((value) {
                              store.dispatch(StopSaving());
                              showToast(localization.emailReactivated);
                              setState(() {
                                _showEmailError = false;
                              });
                            }).catchError((error) {
                              store.dispatch(StopSaving());
                            });
                          },
                          child: Text(localization.reactivateEmail)),
                    ],
                    SizedBox(height: 16),
                    Text(
                      widget.invitation!.emailError,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
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
