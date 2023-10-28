// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';

// Package imports:
import 'package:invoiceninja_flutter/ui/app/portal_links.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceViewContacts extends StatelessWidget {
  const InvoiceViewContacts({Key? key, required this.viewModel})
      : super(key: key);

  final AbstractInvoiceViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final invoice = viewModel.invoice!;

    return ScrollableListView(
      padding: const EdgeInsets.all(8),
      children: invoice.invitations
          .map((invitation) => _InvitationListTile(
                invitation: invitation,
                viewModel: viewModel,
              ))
          .toList(),
    );
  }
}

class _InvitationListTile extends StatelessWidget {
  const _InvitationListTile(
      {required this.invitation, required this.viewModel});

  final InvitationEntity invitation;
  final AbstractInvoiceViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final state = viewModel.state!;
    final client = state.clientState.get(viewModel.invoice!.clientId);
    final vendor = state.vendorState.get(viewModel.invoice!.vendorId);

    String contactName = '';

    if (viewModel.invoice!.isPurchaseOrder) {
      final contact = vendor.contacts.firstWhere(
          (contact) => contact.id == invitation.vendorContactId,
          orElse: () => VendorContactEntity());
      if (contact.isNew) {
        return SizedBox();
      }
      contactName = contact.fullNameOrEmail;
      if (contactName.isEmpty) {
        contactName = vendor.name;
      }
    } else {
      final contact = client.contacts.firstWhere(
          (contact) => contact.id == invitation.clientContactId,
          orElse: () => ClientContactEntity());
      if (contact.isNew) {
        return SizedBox();
      }
      contactName = contact.fullNameOrEmail;
      if (contactName.isEmpty) {
        contactName = client.displayName;
      }
    }

    Widget icon = Icon(Icons.contacts);
    switch (invitation.emailStatus) {
      case InvitationEntity.EMAIL_STATUS_DELIVERED:
        icon = Tooltip(
          child: Icon(Icons.check_circle),
          message: localization.delivered,
        );
        break;
      case InvitationEntity.EMAIL_STATUS_BOUNCED:
        icon = Tooltip(
          child: Icon(Icons.error),
          message: localization.bounced,
        );
        break;
      case InvitationEntity.EMAIL_STATUS_SPAM:
        icon = Tooltip(
          child: Icon(Icons.error),
          message: localization.spam,
        );
        break;
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: Text(contactName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          if (invitation.sentDate.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '${localization.sent}: ' +
                    formatDate(invitation.sentDate, context, showTime: true),
              ),
            ),
          if (invitation.openedDate.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '${localization.opened}: ' +
                    formatDate(invitation.openedDate, context, showTime: true),
              ),
            ),
          if (invitation.viewedDate.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '${localization.viewed}: ' +
                    formatDate(invitation.viewedDate, context, showTime: true),
              ),
            ),
          if (invitation.emailError.isNotEmpty)
            CopyToClipboard(
              value: invitation.emailError,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  invitation.emailError,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          SizedBox(height: 16),
          PortalLinks(
            viewLink: invitation.silentLink,
            copyLink: invitation.link,
            client: client,
          )
        ],
      ),
      leading: icon,
      isThreeLine: true,
    );
  }
}
