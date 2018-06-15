import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/dismissible_entity.dart';
import 'package:invoiceninja/utils/localization.dart';

import '../app/entity_state_label.dart';

class InvoiceItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  //final ValueChanged<bool> onCheckboxChanged;
  final InvoiceEntity invoice;
  final ClientEntity client;

  static final invoiceItemKey = (int id) => Key('__invoice_item_${id}__');

  InvoiceItem({
    @required this.onDismissed,
    @required this.onTap,
    //@required this.onCheckboxChanged,
    @required this.invoice,
    @required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return DismissibleEntity(
      entity: invoice,
      onDismissed: onDismissed,
      onTap: onTap,
      child: ListTile(
        onTap: onTap,
        /*
        leading: Checkbox(
          //key: NinjaKeys.invoiceItemCheckbox(invoice.id),
          value: true,
          //onChanged: onCheckboxChanged,
          onChanged: (value) {
            return true;
          },
        ),
        */
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  client.displayName,
                  //invoice.invoiceNumber,
                  //key: NinjaKeys.clientItemClientKey(client.id),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(invoice.invoiceNumber),
            /*
            invoice.notes.isNotEmpty
                ? Text(
                    invoice.notes,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
                */
            EntityStateLabel(invoice),
          ],
        ),
        trailing: Text(invoice.amount.toStringAsFixed(2),
            style: Theme.of(context).textTheme.title),
      ),
    );
  }
}
