import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/email_invoice_dialog.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class EmailInvoiceDialog extends StatelessWidget {
  //static const String route = '/invoice/email';

  const EmailInvoiceDialog({Key key, this.invoice}) : super(key: key);

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailInvoiceDialogVM>(
      converter: (Store<AppState> store) {
        return EmailInvoiceDialogVM.fromStore(store, invoice);
      },
      builder: (context, vm) {
        return EmailInvoiceView(
          viewModel: vm,
        );
      },
    );
  }
}

class EmailInvoiceDialogVM {
  final InvoiceEntity invoice;
  final ClientEntity client;

  EmailInvoiceDialogVM({
    @required this.invoice,
    @required this.client,
  });

  factory EmailInvoiceDialogVM.fromStore(
      Store<AppState> store, InvoiceEntity invoice) {
    final state = store.state;

    return EmailInvoiceDialogVM(
      invoice: invoice,
      client: state.clientState.map[invoice.clientId],
    );
  }
}
