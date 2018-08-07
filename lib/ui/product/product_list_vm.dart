import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
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
  final Function(BuildContext, ProductEntity) onProductLongPress;
  final Function(BuildContext, ProductEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;

  ProductListVM({
    @required this.productList,
    @required this.productMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onProductTap,
    @required this.onProductLongPress,
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
        productList: memoizedFilteredProductList(store.state.productState.map,
            store.state.productState.list, store.state.productListState),
        productMap: store.state.productState.map,
        isLoading: store.state.isLoading,
        isLoaded: store.state.productState.isLoaded,
        filter: store.state.productUIState.listUIState.filter,
        onProductTap: (context, product) {
          store.dispatch(EditProduct(product: product, context: context));
        },
        onProductLongPress: (context, product) async {
          final message = await showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  SimpleDialog(children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.control_point_duplicate),
                      title: Text(AppLocalization.of(context).clone),
                      onTap: () {
                        Navigator.of(context).pop();
                        store.dispatch(EditProduct(
                            context: context, product: product.clone));
                      },
                    ),
                    Divider(),
                    ListTile(
                        leading: Icon(Icons.archive),
                        title: Text(AppLocalization.of(context).archive),
                        onTap: () => store.dispatch(ArchiveProductRequest(
                            popCompleter(
                                context,
                                AppLocalization
                                    .of(context)
                                    .successfullyArchivedProduct),
                            product.id))),
                    ListTile(
                      leading: Icon(Icons.delete),
                      title: Text(AppLocalization.of(context).delete),
                      onTap: () => store.dispatch(DeleteProductRequest(
                          popCompleter(
                              context,
                              AppLocalization
                                  .of(context)
                                  .successfullyDeletedProduct),
                          product.id)),
                    ),
                  ]));
          if (message != null) {
            Scaffold.of(context).showSnackBar(SnackBar(
                    content: SnackBarRow(
                  message: message,
                )));
          }
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, ProductEntity product,
            DismissDirection direction) {
          final localization = AppLocalization.of(context);
          if (direction == DismissDirection.endToStart) {
            if (product.isDeleted || product.isArchived) {
              store.dispatch(RestoreProductRequest(
                  snackBarCompleter(
                      context, localization.successfullyRestoredProduct),
                  product.id));
            } else {
              store.dispatch(ArchiveProductRequest(
                  snackBarCompleter(
                      context, localization.successfullyArchivedProduct),
                  product.id));
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (product.isDeleted) {
              store.dispatch(RestoreProductRequest(
                  snackBarCompleter(
                      context, localization.successfullyRestoredProduct),
                  product.id));
            } else {
              store.dispatch(DeleteProductRequest(
                  snackBarCompleter(
                      context, localization.successfullyDeletedProduct),
                  product.id));
            }
          }
        });
  }
}
