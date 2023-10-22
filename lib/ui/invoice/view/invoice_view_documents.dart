// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';

class InvoiceViewDocuments extends StatelessWidget {
  const InvoiceViewDocuments(
      {Key? key, required this.invoice, required this.viewModel})
      : super(key: key);

  final AbstractInvoiceViewVM viewModel;
  final InvoiceEntity? invoice;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return DocumentGrid(
      documents: invoice!.documents.toList(),
      onUploadDocument: (path, isPrivate) =>
          viewModel.onUploadDocuments!(context, path, isPrivate),
      onViewExpense: (document) => viewModel.onViewExpense!(context, document),
      onRenamedDocument: () =>
          store.dispatch(LoadInvoice(invoiceId: invoice!.id)),
    );
  }
}
