import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';

class ProductViewDocuments extends StatelessWidget {
  const ProductViewDocuments({@required this.viewModel});

  final ProductViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final product = viewModel.product;

    return DocumentGrid(
      documents: product.documents.toList(),
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document) => viewModel.onDeleteDocument(context, document),
    );
  }
}
