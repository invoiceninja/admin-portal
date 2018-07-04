import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/invoice_model.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/utils/localization.dart';

class InvoiceItemListTile extends StatelessWidget {
  const InvoiceItemListTile({
    @required this.invoice,
    @required this.invoiceItem,
    @required this.state,
  });

  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final String cost =
        formatNumber(invoiceItem.cost, state, clientId: invoice.clientId);
    final String qty = formatNumber(invoiceItem.qty, state,
        clientId: invoice.clientId, formatNumberType: FormatNumberType.double);
    final localization = AppLocalization.of(context);

    String subtitle = '$qty x $cost';
    if (invoiceItem.discount != 0) {
      subtitle += ' | ${localization.discount} ';
      if (invoice.isAmountDiscount) {
        subtitle += formatNumber(invoiceItem.discount, state,
            clientId: invoice.clientId);
      } else {
        subtitle += formatNumber(invoiceItem.discount, state,
            clientId: invoice.clientId,
            formatNumberType: FormatNumberType.percent);
      }
    }

    final List<String> parts = [];
    if (invoiceItem.customValue1.isNotEmpty) {
      parts.add(invoiceItem.customValue1);
    }
    if (invoiceItem.customValue2.isNotEmpty) {
      parts.add(invoiceItem.customValue2);
    }
    if (invoiceItem.notes.isNotEmpty) {
      parts.add(invoiceItem.notes);
    }
    if (parts.isNotEmpty) {
      subtitle += '\n' + parts.join(' • ');
    }

    return Container(
      color: Theme.of(context).canvasColor,
      child: ListTile(
        title: Text(invoiceItem.productKey),
        subtitle: Text(subtitle),
        trailing: Text(
            formatNumber(invoiceItem.total, state, clientId: invoice.clientId)),
      ),
    );
  }
}
