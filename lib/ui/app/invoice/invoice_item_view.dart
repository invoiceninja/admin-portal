import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceItemListTile extends StatelessWidget {
  const InvoiceItemListTile({
    @required this.invoice,
    @required this.invoiceItem,
    @required this.onTap,
  });

  final Function onTap;
  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;

  @override
  Widget build(BuildContext context) {
    final String cost =
        formatNumber(invoiceItem.cost, context, clientId: invoice.clientId);
    final String qty = formatNumber(invoiceItem.qty, context,
        clientId: invoice.clientId, formatNumberType: FormatNumberType.double);
    final localization = AppLocalization.of(context);

    String subtitle = '$qty x $cost';

    if (invoiceItem.discount != 0) {
      subtitle += ' • ${localization.discount} ';
      if (invoice.isAmountDiscount) {
        subtitle += formatNumber(invoiceItem.discount, context,
            clientId: invoice.clientId);
      } else {
        subtitle += formatNumber(invoiceItem.discount, context,
            clientId: invoice.clientId,
            formatNumberType: FormatNumberType.percent);
      }
    }

    if (invoiceItem.taxRate1 != 0) {
      final taxRate1 = formatNumber(invoiceItem.taxRate1, context, formatNumberType: FormatNumberType.percent);
      subtitle += ' • $taxRate1 ${invoiceItem.taxName1}';
    }

    if (invoiceItem.taxRate2 != 0) {
      final taxRate2 = formatNumber(invoiceItem.taxRate2, context, formatNumberType: FormatNumberType.percent);
      subtitle += ' • $taxRate2 ${invoiceItem.taxName2}';
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

    return Material(
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              ListTile(
                  onTap: onTap,
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text(invoiceItem.productKey)),
                      Text(formatNumber(invoiceItem.total, context,
                          clientId: invoice.clientId)),
                    ],
                  ),
                  subtitle: Text(subtitle),
                  trailing: onTap != null ? Icon(Icons.navigate_next) : null,
              ),
              Divider(height: 1.0,),
            ],
          ),
        )
    );
  }
}
