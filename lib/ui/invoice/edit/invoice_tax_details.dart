import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class InvoiceTaxDetails extends StatelessWidget {
  const InvoiceTaxDetails({
    Key key,
    @required this.invoice,
  }) : super(key: key);

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final client = state.clientState.get(invoice.clientId);
    final taxData = invoice.isNew ? client.taxData : invoice.taxData;

    return AlertDialog(
      title: Text(localization.taxDetails),
      content: SizedBox(
        width: 400,
        child: DataTable(
          columns: [
            DataColumn(label: Text(localization.region)),
            DataColumn(label: Text(localization.name)),
            DataColumn(label: Text(localization.tax)),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text(localization.state)),
              DataCell(Text(taxData.geoState)),
              DataCell(Text('${taxData.stateSalesTax}')),
            ]),
            DataRow(cells: [
              DataCell(Text(localization.county)),
              DataCell(Text(toTitleCase(taxData.geoCounty))),
              DataCell(Text('${taxData.countySalesTax}')),
            ]),
            DataRow(cells: [
              DataCell(Text(localization.city)),
              DataCell(Text(toTitleCase(taxData.geoCity))),
              DataCell(Text('${taxData.citySalesTax}')),
            ]),
            DataRow(cells: [
              DataCell(Text(localization.district)),
              DataCell(Text('')),
              DataCell(Text('${taxData.districtSalesTax}')),
            ]),
            DataRow(cells: [
              DataCell(Text(localization.total)),
              DataCell(Text('')),
              DataCell(Text('${taxData.taxSales}')),
            ]),
          ],
        ),
        /*
        child: Table(
          children: [
            TableRow(children: [
              TableCell(child: Text(localization.state)),
              TableCell(child: Text(taxData.geoState)),
              TableCell(child: Text('')),
            ]),
            TableRow(children: [
              TableCell(child: Text(localization.county)),
              TableCell(child: Text(toTitleCase(taxData.geoCounty))),
              TableCell(child: Text('')),
            ]),
            TableRow(children: [
              TableCell(child: Text(localization.city)),
              TableCell(child: Text(toTitleCase(taxData.geoCity))),
              TableCell(child: Text('')),
            ]),
            TableRow(children: [
              TableCell(child: Text(localization.total)),
              TableCell(child: Text('')),
              TableCell(child: Text('')),
            ]),
          ],
        ),
        */
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
