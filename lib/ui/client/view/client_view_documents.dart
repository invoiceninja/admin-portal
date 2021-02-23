import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';

class ClientViewDocuments extends StatelessWidget {
  const ClientViewDocuments({Key key, @required this.viewModel})
      : super(key: key);

  final ClientViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final client = viewModel.client;

    return DocumentGrid(
      documents: client.documents.toList(),
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document, password, idToken) =>
          viewModel.onDeleteDocument(context, document, password, idToken),
    );
  }
}
