// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class InvoiceItemListTile extends StatelessWidget {
  const InvoiceItemListTile({
    required this.invoice,
    required this.invoiceItem,
    required this.onTap,
  });

  final Function onTap;
  final InvoiceEntity invoice;
  final InvoiceItemEntity? invoiceItem;

  @override
  Widget build(BuildContext context) {
    final String? cost = formatNumber(invoiceItem!.cost, context,
        clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
        vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
        roundToPrecision: false);
    final String? qty = formatNumber(invoiceItem!.quantity, context,
        clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
        vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
        formatNumberType: FormatNumberType.double);
    final localization = AppLocalization.of(context);

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final client = state.clientState.get(invoice.clientId);
    final precision =
        state.staticState.currencyMap[client.currencyId]?.precision ?? 2;

    String subtitle = '$qty x $cost';

    if (invoiceItem!.discount != 0) {
      subtitle += ' • ${localization!.discount} ';
      if (invoice.isAmountDiscount) {
        subtitle += formatNumber(
          invoiceItem!.discount,
          context,
          clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
          vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
        )!;
      } else {
        subtitle += formatNumber(invoiceItem!.discount, context,
            clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
            vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
            formatNumberType: FormatNumberType.percent)!;
      }
    }

    if (company.calculateTaxes) {
      subtitle += ' • ' +
          localization!.lookup(kTaxCategories[invoiceItem!.taxCategoryId]);
    }

    if (invoiceItem!.taxRate1 != 0) {
      final taxRate1 = formatNumber(invoiceItem!.taxRate1, context,
          formatNumberType: FormatNumberType.percent);
      subtitle += ' • $taxRate1 ${invoiceItem!.taxName1}';
    }

    if (invoiceItem!.taxRate2 != 0) {
      final taxRate2 = formatNumber(invoiceItem!.taxRate2, context,
          formatNumberType: FormatNumberType.percent);
      subtitle += ' • $taxRate2 ${invoiceItem!.taxName2}';
    }

    if (invoiceItem!.taxRate3 != 0) {
      final taxRate3 = formatNumber(invoiceItem!.taxRate3, context,
          formatNumberType: FormatNumberType.percent);
      subtitle += ' • $taxRate3 ${invoiceItem!.taxName3}';
    }

    final List<String?> parts = [];
    if (company.hasCustomField(CustomFieldType.product1) &&
        invoiceItem!.customValue1.isNotEmpty) {
      parts.add(formatCustomValue(
          context: context,
          field: CustomFieldType.product1,
          value: invoiceItem!.customValue1));
    }
    if (company.hasCustomField(CustomFieldType.product2) &&
        invoiceItem!.customValue2.isNotEmpty) {
      parts.add(formatCustomValue(
          context: context,
          field: CustomFieldType.product2,
          value: invoiceItem!.customValue2));
    }
    if (company.hasCustomField(CustomFieldType.product3) &&
        invoiceItem!.customValue3.isNotEmpty) {
      parts.add(formatCustomValue(
          context: context,
          field: CustomFieldType.product3,
          value: invoiceItem!.customValue3));
    }
    if (company.hasCustomField(CustomFieldType.product4) &&
        invoiceItem!.customValue4.isNotEmpty) {
      parts.add(formatCustomValue(
          context: context,
          field: CustomFieldType.product4,
          value: invoiceItem!.customValue4));
    }
    if (invoiceItem!.notes.isNotEmpty) {
      parts.add(removeAllHtmlTags(invoiceItem!.notes).trim());
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
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              onTap: onTap as void Function()?,
              title: Row(
                children: <Widget>[
                  Expanded(child: Text(invoiceItem!.productKey)),
                  Text(formatNumber(
                    invoiceItem!.total(invoice, precision),
                    context,
                    clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
                    vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
                  )!),
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
              trailing: Icon(Icons.navigate_next),
            ),
            ListDivider(),
          ],
        ));
  }
}
