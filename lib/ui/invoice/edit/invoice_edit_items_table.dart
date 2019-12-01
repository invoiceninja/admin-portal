import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditItemsTable extends StatelessWidget {
  const InvoiceEditItemsTable({this.viewModel});

  final EntityEditItemsVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
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
          ),
          DataColumn(
            label: Text(localization.quantity),
          ),
          DataColumn(
            label: Text(localization.lineTotal),
          ),
        ],
        rows: invoice.lineItems.map((item) => DataRow(
          cells: [
            DataCell(Text(item.productKey)),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
          ],
        )).toList(),
      ),
    );
  }
}
