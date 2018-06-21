import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/invoice_model.dart';

class InvoiceItemListTile extends StatelessWidget {

  InvoiceItemListTile(this.invoiceItem);
  final InvoiceItemEntity invoiceItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(invoiceItem.productKey),
      subtitle: Text('${invoiceItem.qty} x ${invoiceItem.cost.toStringAsFixed(2)}\n${invoiceItem.notes}'),
      trailing: Text(invoiceItem.total.toStringAsFixed(2)),
    );
  }
}
