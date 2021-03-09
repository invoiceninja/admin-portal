import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceViewContacts extends StatelessWidget {
  const InvoiceViewContacts({Key key, @required this.viewModel})
      : super(key: key);

  final EntityViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final invoice = viewModel.invoice;

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
      {@required this.invitation, @required this.viewModel});

  final InvitationEntity invitation;
  final EntityViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = viewModel.state;
    final client = state.clientState.get(viewModel.invoice.clientId);
    final contact = client.contacts.firstWhere(
        (contact) => contact.id == invitation.contactId,
        orElse: () => ContactEntity());

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
      title: Text(contact.fullNameWithEmail.isEmpty
          ? client.displayName
          : contact.fullNameWithEmail),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
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
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                  child: OutlineButton(
                child: Text(localization.viewPortal.toUpperCase()),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  launch(
                      '${invitation.silentLink}&client_hash=${client.clientHash}',
                      forceWebView: false,
                      forceSafariVC: false);
                },
              )),
              SizedBox(width: kTableColumnGap),
              Expanded(
                  child: OutlineButton(
                child: Text(localization.copyLink.toUpperCase()),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: invitation.link));
                  showToast(localization.copiedToClipboard
                      .replaceFirst(':value ', ''));
                },
              )),
            ],
          )
        ],
      ),
      leading: icon,
      isThreeLine: true,
    );
  }
}
