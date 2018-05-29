import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/product/product_details.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class ProductDetailsBuilder extends StatelessWidget {
  ProductDetailsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductDetailsVM>(
      //ignoreChange: (state) => productSelector(state.product().list, id).isNotPresent,
      converter: (Store<AppState> store) {
        return ProductDetailsVM.from(store);
      },
      builder: (context, vm) {
        return ProductDetails(
          viewModel: vm,
        );
      },
    );
  }
}

class ProductDetailsVM {
  final ProductEntity product;
  final Function onDelete;
  final Function(ProductEntity, BuildContext) onSaveClicked;
  final bool isLoading;
  final bool isDirty;

  ProductDetailsVM({
    @required this.product,
    @required this.onDelete,
    @required this.onSaveClicked,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ProductDetailsVM.from(Store<AppState> store) {
    final product = store.state.productState().editing;

    return ProductDetailsVM(
      isLoading: store.state.isLoading,
      isDirty: product.id == null,
      product: product,
      onDelete: () => false,
      onSaveClicked: (ProductEntity product, BuildContext context) {
        final Completer<Null> completer = new Completer<Null>();
        store.dispatch(SaveProductRequest(completer, product));
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
                message: product.id == null
                    ? AppLocalization.of(context).successfullyCreatedProduct
                    : AppLocalization.of(context).successfullyUpdatedProduct,
              ),
              duration: Duration(seconds: 3)));
        });
      },
    );
  }
}
