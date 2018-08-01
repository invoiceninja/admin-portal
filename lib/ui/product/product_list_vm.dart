import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/product/product_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';

class ProductListBuilder extends StatelessWidget {
  const ProductListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductListVM>(
      //rebuildOnChange: true,
      converter: ProductListVM.fromStore,
      builder: (context, vm) {
        return ProductList(
          viewModel: vm,
        );
      },
    );
  }
}

class ProductListVM {
  final List<int> productList;
  final BuiltMap<int, ProductEntity> productMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ProductEntity) onProductTap;
  final Function(BuildContext, ProductEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;

  ProductListVM({
    @required this.productList,
    @required this.productMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onProductTap,
    @required this.onDismissed,
    @required this.onRefreshed,
  });

  static ProductListVM fromStore(Store<AppState> store) {
      Future<Null> _handleRefresh(BuildContext context) {
        final Completer<Null> completer = Completer<Null>();
        store.dispatch(LoadProducts(completer, true));
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
                message: AppLocalization.of(context).refreshComplete,
              )));
        });
      }

    return ProductListVM(
        productList: memoizedFilteredProductList(store.state.productState.map, store.state.productState.list, store.state.productListState),
        productMap: store.state.productState.map,
        isLoading: store.state.isLoading,
        isLoaded: store.state.productState.isLoaded,
        filter: store.state.productUIState.listUIState.filter,
        onProductTap: (context, product) {
          store.dispatch(EditProduct(product: product, context: context));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, ProductEntity product,
            DismissDirection direction) {
          final Completer<Null> completer = Completer<Null>();
          var message = '';
          if (direction == DismissDirection.endToStart) {
            if (product.isDeleted || product.isArchived) {
              store.dispatch(RestoreProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyRestoredProduct;
            } else {
              store.dispatch(ArchiveProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyArchivedProduct;
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (product.isDeleted) {
              store.dispatch(RestoreProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyRestoredProduct;
            } else {
              store.dispatch(DeleteProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyDeletedProduct;
            }
          }
          return completer.future.then((_) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
                  message: message,
                )));
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
  }
}
