import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
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
    final String cost = formatNumber(invoiceItem.cost, context,
        clientId: invoice.clientId, roundToPrecision: false);
    final String qty = formatNumber(invoiceItem.quantity, context,
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
      final taxRate1 = formatNumber(invoiceItem.taxRate1, context,
          formatNumberType: FormatNumberType.percent);
      subtitle += ' • $taxRate1 ${invoiceItem.taxName1}';
    }

    if (invoiceItem.taxRate2 != 0) {
      final taxRate2 = formatNumber(invoiceItem.taxRate2, context,
          formatNumberType: FormatNumberType.percent);
      subtitle += ' • $taxRate2 ${invoiceItem.taxName2}';
    }

    final List<String> parts = [];
    if (invoiceItem.customValue1.isNotEmpty) {
      parts.add(formatCustomValue(
          context: context,
          field: CustomFieldType.product1,
          value: invoiceItem.customValue1));
    }
    if (invoiceItem.customValue2.isNotEmpty) {
      parts.add(formatCustomValue(
          context: context,
          field: CustomFieldType.product2,
          value: invoiceItem.customValue2));
    }
    if (invoiceItem.customValue3.isNotEmpty) {
      parts.add(formatCustomValue(
          context: context,
          field: CustomFieldType.product3,
          value: invoiceItem.customValue3));
    }
    if (invoiceItem.customValue4.isNotEmpty) {
      parts.add(formatCustomValue(
          context: context,
          field: CustomFieldType.product4,
          value: invoiceItem.customValue4));
    }
    if (invoiceItem.notes.isNotEmpty) {
      parts.add(invoiceItem.notes);
    }
    if (parts.isNotEmpty) {
      subtitle += '\n' + parts.join(' • ');
    }

    return Material(
        color: Theme.of(context).cardColor,
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              onTap: onTap,
              title: Row(
                children: <Widget>[
                  Expanded(child: Text(invoiceItem.productKey)),
                  Text(formatNumber(invoiceItem.total, context,
                      clientId: invoice.clientId)),
                ],
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Prevent scrollbars on web
                  SizedBox(width: 1),
                ],
              ),
              trailing: onTap != null ? Icon(Icons.navigate_next) : null,
            ),
            ListDivider(),
          ],
        ));
  }
}
