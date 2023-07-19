import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceTaxDetails extends StatelessWidget {
  const InvoiceTaxDetails({
    Key key,
    @required this.invoice,
  }) : super(key: key);

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final localization = AppLocalization.of(context);
    final client = state.clientState.get(invoice.id);
    final company = state.company;

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
