import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/product/edit/product_edit.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class ProductEditBuilder extends StatelessWidget {
  ProductEditBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductEditVM>(
      //ignoreChange: (state) => productSelector(state.product().list, id).isNotPresent,
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
  final ProductEntity product;
  final Function onDelete;
  final Function(BuildContext, ProductEntity) onSaveClicked;
  final Function(BuildContext, EntityAction) onActionSelected;
  final bool isLoading;
  final bool isDirty;

  ProductEditVM({
    @required this.product,
    @required this.onDelete,
    @required this.onSaveClicked,
    @required this.onActionSelected,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ProductEditVM.fromStore(Store<AppState> store) {
    final product = store.state.productState().editing;

    return ProductEditVM(
      isLoading: store.state.isLoading,
      isDirty: product.id == null,
      product: product,
      onDelete: () => false,
      onSaveClicked: (BuildContext context, ProductEntity product) {
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
              ),
              duration: Duration(seconds: 3)));
        });
      }
    );
  }
}
