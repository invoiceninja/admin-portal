// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';

class VendorViewDocuments extends StatelessWidget {
  const VendorViewDocuments({Key? key, required this.viewModel})
      : super(key: key);

  final VendorViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final vendor = viewModel.vendor;

    return DocumentGrid(
      documents: vendor.documents.toList(),
      onUploadDocument: (path, isPrivate) =>
          viewModel.onUploadDocuments(context, path, isPrivate),
      onRenamedDocument: () => store.dispatch(LoadVendor(vendorId: vendor.id)),
    );
  }
}
