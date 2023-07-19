import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceTaxDetails extends StatelessWidget {
  const InvoiceTaxDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AlertDialog(
      title: Text(localization.taxDetails),
      content: DataTable(
        columns: [
          DataColumn(label: Text('')),
          DataColumn(label: Text(localization.invoice)),
          DataColumn(label: Text(localization.client)),
          DataColumn(label: Text(localization.company)),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(localization.address)),
            DataCell(Text('test')),
            DataCell(Text('test')),
            DataCell(Text('test')),
          ])
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            localization.close.toUpperCase(),
          ),
        )
      ],
    );
  }
}
