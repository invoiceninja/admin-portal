// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentOverview extends StatefulWidget {
  const PaymentOverview({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PaymentViewVM viewModel;

  @override
  _PaymentOverviewState createState() => _PaymentOverviewState();
}

class _PaymentOverviewState extends State<PaymentOverview> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final payment = viewModel.payment;
    final company = viewModel.company!;

    final fields = <String, String?>{};
    /*
    fields[PaymentFields.paymentStatusId] =
        localization.lookup('payment_status_${payment.statusId}');
     */
    if (payment.date.isNotEmpty) {
      fields[PaymentFields.date] = formatDate(payment.date, context);
    }
    if (payment.typeId.isNotEmpty) {
      final paymentType = state.staticState.paymentTypeMap[payment.typeId];
      if (paymentType != null) {
        fields[PaymentFields.typeId] = paymentType.name;
      }
    }
    if (payment.transactionReference.isNotEmpty) {
      fields[PaymentFields.transactionReference] = payment.transactionReference;
    }
    if (payment.refunded != 0) {
      fields[PaymentFields.refunded] =
          formatNumber(payment.refunded, context, clientId: client.id);
    }

    return ScrollableListView(
      children: <Widget>[
        EntityHeader(
          entity: payment,
          statusColor: PaymentStatusColors(state.prefState.colorThemeModel)
              .colors[payment.statusId],
          statusLabel:
              localization!.lookup('payment_status_${payment.statusId}'),
          label: localization.amount,
          value: formatNumber(payment.amount - payment.refunded, context,
              clientId: client.id),
          secondLabel: localization.applied,
          secondValue:
              formatNumber(payment.applied, context, clientId: client.id),
        ),
        ListDivider(),
        EntityListTile(
          isFilter: widget.isFilter,
          entity: client,
          subtitle: client
              .getContact(invoice.invitations.first.clientContactId)
              .emailOrFullName,
        ),
        for (final paymentable in payment.invoicePaymentables)
          EntityListTile(
            isFilter: widget.isFilter,
            entity: state.invoiceState.map[paymentable.invoiceId]!,
            subtitle: formatNumber(paymentable.amount, context,
                    clientId: payment.clientId)! +
                ' • ' +
                formatDate(convertTimestampToDateString(paymentable.createdAt),
                    context),
          ),
        for (final paymentable in payment.creditPaymentables)
          EntityListTile(
            isFilter: widget.isFilter,
            entity: state.creditState.map[paymentable.creditId]!,
            subtitle: formatNumber(paymentable.amount, context,
                    clientId: payment.clientId)! +
                ' • ' +
                formatDate(convertTimestampToDateString(paymentable.createdAt),
                    context),
          ),
        if (payment.companyGatewayId.isNotEmpty) ...[
          ListTile(
            title: Text('${localization.gateway}  ›  ${companyGateway.label}'),
            onTap: companyGatewayLink != null
                ? () => launchUrl(Uri.parse(companyGatewayLink))
                : null,
            leading: IgnorePointer(
              child: IconButton(
                icon: Icon(Icons.payment),
                onPressed: () => null,
              ),
            ),
            trailing: companyGatewayLink != null
                ? IgnorePointer(
                    child: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () => null,
                    ),
                  )
                : null,
          ),
          ListDivider(),
        ],
        if (payment.transactionId.isNotEmpty)
          EntityListTile(
            isFilter: widget.isFilter,
            entity: transaction,
          ),
        payment.privateNotes.isNotEmpty
            ? Column(
                children: <Widget>[
                  IconMessage(payment.privateNotes, copyToClipboard: true),
                  Container(
                    color: Theme.of(context).cardColor,
                    height: 12.0,
                  ),
                ],
              )
            : Container(),
        FieldGrid(fields),
      ],
    );
  }
}
