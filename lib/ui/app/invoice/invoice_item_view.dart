import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/invoice_model.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

class InvoiceItemListTile extends StatelessWidget {

  InvoiceItemListTile({
    @required this.invoice,
    @required this.invoiceItem,
    @required this.state,
  });

  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(invoiceItem.productKey),
      subtitle: Text('${invoiceItem.qty} x ${invoiceItem.cost.toStringAsFixed(2)}\n${invoiceItem.notes}'),
      trailing: Text(formatNumber(invoiceItem.total, state, clientId: invoice.clientId)),
    );
  }
}
