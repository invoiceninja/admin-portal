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
    final localization = AppLocalization.of(context);
    //final state = StoreProvider.of<AppState>(context).state;
    //final client = state.clientState.get(invoice.id);
    //final company = state.company;

    return AlertDialog(
      title: Text(localization.taxDetails),
      content: Table(
        children: [
          TableRow(children: [
            TableCell(child: Text(localization.state)),
            TableCell(child: Text('')),
          ]),
          TableRow(children: [
            TableCell(child: Text(localization.county)),
            TableCell(child: Text('')),
          ]),
          TableRow(children: [
            TableCell(child: Text(localization.city)),
            TableCell(child: Text('')),
          ]),
          TableRow(children: [
            TableCell(child: Text(localization.total)),
            TableCell(child: Text('')),
          ]),
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
