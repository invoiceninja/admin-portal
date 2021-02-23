import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';

class InvoiceViewDocuments extends StatelessWidget {
  const InvoiceViewDocuments(
      {Key key, @required this.invoice, @required this.viewModel})
      : super(key: key);

  final EntityViewVM viewModel;
  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    return DocumentGrid(
      documents: invoice.documents.toList(),
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document, password, idToken) =>
          viewModel.onDeleteDocument(context, document, password, idToken),
      onViewExpense: (document) => viewModel.onViewExpense(context, document),
    );
  }
}
