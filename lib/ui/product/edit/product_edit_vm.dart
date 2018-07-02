import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/product/product_screen.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/product/edit/product_edit.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class ProductEditScreen extends StatelessWidget {
  static final String route = '/product/edit';
  ProductEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductEditVM>(
      converter: (Store<AppState> store) {
        return ProductEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return ProductEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class ProductEditVM {
  final AppState state;
  final ProductEntity product;
  final ProductEntity origProduct;
  final Function(ProductEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function onBackPressed;
  final bool isLoading;
  final bool isDirty;

  ProductEditVM({
    @required this.state,
    @required this.product,
    @required this.origProduct,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.onActionSelected,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ProductEditVM.fromStore(Store<AppState> store) {
    final product = store.state.productUIState.editing;

    return ProductEditVM(
        state: store.state,
        isLoading: store.state.isLoading,
        isDirty: product.isNew(),
        product: product,
        origProduct: store.state.productState.map[product.id],
        onChanged: (ProductEntity product) {
          store.dispatch(UpdateProduct(product));
        },
        onBackPressed: () {
          store.dispatch(UpdateCurrentRoute(ProductScreen.route));
        },
        onSavePressed: (BuildContext context) {
          final Completer<Null> completer = new Completer<Null>();
          store.dispatch(
              SaveProductRequest(completer: completer, product: product));
          return completer.future.then((_) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
                  message: product.isNew()
                      ? AppLocalization.of(context).successfullyCreatedProduct
                      : AppLocalization.of(context).successfullyUpdatedProduct,
                )));
          });
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final Completer<Null> completer = new Completer<Null>();
          var message = '';
          switch (action) {
            case EntityAction.archive:
              store.dispatch(ArchiveProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyArchivedProduct;
              break;
            case EntityAction.delete:
              store.dispatch(DeleteProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyDeletedProduct;
              break;
            case EntityAction.restore:
              store.dispatch(RestoreProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyRestoredProduct;
              break;
          }
          return completer.future.then((_) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
                  message: message,
                )));
          });
        });
  }
}
