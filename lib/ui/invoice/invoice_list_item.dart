import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceListItem extends StatelessWidget {
  const InvoiceListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.invoice,
    @required this.client,
    @required this.filter,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final String filter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter.isNotEmpty
        ? (invoice.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;

    final invoiceStatusId = invoice.isQuote && invoice.quoteInvoiceId > 0
        ? kInvoiceStatusApproved
        : invoice.invoiceStatusId;

    return DismissibleEntity(
      user: user,
      entity: invoice,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  client.displayName,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(
                  formatNumber(
                      invoice.balance > 0 ? invoice.balance : invoice.amount,
                      context,
                      clientId: invoice.clientId),
                  style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: filterMatch == null
                      ? Text(invoice.invoiceNumber +
                          ' • ' +
                          formatDate(
                              invoice.dueDate.isNotEmpty
                                  ? invoice.dueDate
                                  : invoice.invoiceDate,
                              context))
                      : Text(
                          filterMatch,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                Text(
                    invoice.isPastDue
                        ? localization.pastDue
                        : localization
                            .lookup('invoice_status_$invoiceStatusId'),
                    style: TextStyle(
                      color: invoice.isPastDue
                          ? Colors.red
                          : InvoiceStatusColors.colors[invoiceStatusId],
                    )),
              ],
            ),
            EntityStateLabel(invoice),
          ],
        ),
      ),
    );
  }
}
