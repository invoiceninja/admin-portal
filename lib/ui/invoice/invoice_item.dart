import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/dismissible_entity.dart';
import 'package:invoiceninja/utils/localization.dart';

import '../app/entity_state_label.dart';

class InvoiceItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final AppState state;
  final String filter;

  const InvoiceItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.invoice,
    @required this.client,
    @required this.state,
    @required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final searchMatch = filter != null && filter.isNotEmpty
        ? invoice.matchesSearchValue(filter)
        : null;

    return DismissibleEntity(
      entity: invoice,
      onDismissed: onDismissed,
      onTap: onTap,
      child: ListTile(
        onTap: onTap,
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
                  formatNumber(invoice.amount, context,
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
                  child: searchMatch == null
                      ? Text(invoice.invoiceNumber)
                      : Text(
                          searchMatch,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                /*
                Chip(
                  label: Text(invoiceStatusSelector(invoice, state.staticState),
                      style: TextStyle(color: Colors.white, fontSize: 12.0)),
                  backgroundColor:
                      InvoiceStatusColors.colors[invoice.invoiceStatusId],
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.all(0.0),
                  //labelPadding: EdgeInsets.all(0.0),
                ),
                */
                Text(invoice.isPastDue ? localization.pastDue : invoiceStatusSelector(invoice, state.staticState),
                    style: TextStyle(
                      color:
                          invoice.isPastDue ? Colors.red : InvoiceStatusColors.colors[invoice.invoiceStatusId],
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

