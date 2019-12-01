import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditItemsDesktop extends StatelessWidget {
  const InvoiceEditItemsDesktop({this.viewModel});

  final EntityEditItemsVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice;

    return FormCard(
      padding: const EdgeInsets.symmetric(horizontal: kMobileDialogPadding),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(localization.item),
          ),
          DataColumn(
            label: Text(localization.description),
          ),
          DataColumn(
            label: Text(localization.unitCost),
            numeric: true,
          ),
          DataColumn(
            label: Text(localization.quantity),
            numeric: true,
          ),
          DataColumn(
            label: Text(localization.lineTotal),
            numeric: true,
          ),
        ],
        rows: invoice.lineItems
            .map((item) => DataRow(
                  cells: [
                    DataCell(TextFormField(
                      initialValue: item.productKey,
                    )),
                    DataCell(TextFormField(
                      initialValue: item.notes,
                    )),
                    DataCell(TextFormField(
                      textAlign: TextAlign.right,
                      initialValue: formatNumber(item.cost, context,
                          formatNumberType: FormatNumberType.input),
                    )),
                    DataCell(TextFormField(
                      textAlign: TextAlign.right,
                      initialValue: formatNumber(item.quantity, context,
                          formatNumberType: FormatNumberType.input),
                    )),
                    DataCell(Text(
                      formatNumber(item.total, context),
                      textAlign: TextAlign.right,
                    )),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
