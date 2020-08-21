import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';

class InvoiceViewContacts extends StatelessWidget {
  const InvoiceViewContacts({Key key, @required this.viewModel})
      : super(key: key);

  final EntityViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final invoice = viewModel.invoice;

    return ListView(
      shrinkWrap: true,
      children: invoice.invitations
          .map((invitation) => _InvitationListTile(
                invitation: invitation,
              ))
          .toList(),
    );
  }
}

class _InvitationListTile extends StatelessWidget {
  const _InvitationListTile({@required this.invitation});

  final InvitationEntity invitation;

  @override
  Widget build(BuildContext context) {
    return Text('$invitation');
  }
}
