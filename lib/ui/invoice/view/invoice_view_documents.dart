import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';

class InvoiceViewDocuments extends StatelessWidget {
  const InvoiceViewDocuments(
      {@required this.invoice, @required this.viewModel});

  final EntityViewVM viewModel;
  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final documentState = state.documentState;
    final documents = memoizedDocumentsSelector(
        documentState.map, documentState.list, invoice);

    return DocumentGrid(
      documents: documents,
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document) =>
          viewModel.onDeleteDocument(context, document),
    );
  }
}
