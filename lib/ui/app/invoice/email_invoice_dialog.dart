import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/email_invoice_dialog_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmailInvoiceView extends StatefulWidget {
  final EmailInvoiceDialogVM viewModel;

  const EmailInvoiceView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _EmailInvoiceViewState createState() => new _EmailInvoiceViewState();
}

class _EmailInvoiceViewState extends State<EmailInvoiceView> {
  @override
  Widget build(BuildContext context) {
    //final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final client = viewModel.client;
    //final company = viewModel.company;

    if (client.areActivitiesStale) {
      return SimpleDialog(children: <Widget>[
          LoadingDialog()
      ]);
    }

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Material(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                ],
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
