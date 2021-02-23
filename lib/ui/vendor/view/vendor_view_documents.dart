import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';

class VendorViewDocuments extends StatelessWidget {
  const VendorViewDocuments({Key key, @required this.viewModel})
      : super(key: key);

  final VendorViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final vendor = viewModel.vendor;

    return DocumentGrid(
      documents: vendor.documents.toList(),
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document, password, idToken) =>
          viewModel.onDeleteDocument(context, document, password, idToken),
    );
  }
}
