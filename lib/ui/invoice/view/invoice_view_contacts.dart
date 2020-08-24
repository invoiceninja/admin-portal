import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceViewContacts extends StatelessWidget {
  const InvoiceViewContacts({Key key, @required this.viewModel})
      : super(key: key);

  final EntityViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final invoice = viewModel.invoice;

    return ListView(
      shrinkWrap: true,
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

    return ListTile(
      title: Text(contact.fullNameWithEmail.isEmpty
          ? client.displayName
          : contact.fullNameWithEmail),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${localization.sent}: ${invitation.sentDate.isNotEmpty ? formatDate(invitation.sentDate, context, showTime: true) : ''}'),
          Text(
              '${localization.viewed}: ${invitation.viewedDate.isNotEmpty ? formatDate(invitation.viewedDate, context, showTime: true) : ''}'),
          Row(
            children: [
              Expanded(
                  child: FlatButton(
                child: Text(localization.clientPortal.toUpperCase()),
                onPressed: () {
                  //
                },
              )),
              Expanded(
                  child: FlatButton(
                child: Text(localization.copyLink.toUpperCase()),
                onPressed: () {
                  //
                },
              )),
            ],
          )
        ],
      ),
      leading: Icon(Icons.contacts),
      isThreeLine: true,
    );
  }
}
