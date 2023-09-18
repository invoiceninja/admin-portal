// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';

class ProductViewDocuments extends StatelessWidget {
  const ProductViewDocuments({Key? key, required this.viewModel})
      : super(key: key);

  final ProductViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final product = viewModel.product;

    return DocumentGrid(
      documents: product.documents.toList(),
      onUploadDocument: (path, isPrivate) =>
          viewModel.onUploadDocuments(context, path, isPrivate),
      onRenamedDocument: () =>
          store.dispatch(LoadProduct(productId: product.id)),
    );
  }
}
