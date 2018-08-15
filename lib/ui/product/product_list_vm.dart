import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
  final Function(BuildContext, ProductEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, ProductEntity, EntityAction) onEntityAction;

  ProductListVM({
    @required this.productList,
    @required this.productMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onProductTap,
    @required this.onDismissed,
    @required this.onRefreshed,
    @required this.onEntityAction,
  });

  static ProductListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadProducts(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return ProductListVM(
        productList: memoizedFilteredProductList(state.productState.map,
            state.productState.list, state.productListState),
        productMap: state.productState.map,
        isLoading: state.isLoading,
        isLoaded: state.productState.isLoaded,
        filter: state.productUIState.listUIState.filter,
        onProductTap: (context, product) {
          store.dispatch(EditProduct(product: product, context: context));
        },
        onEntityAction: (context, product, action) {
          switch (action) {
            case EntityAction.clone:
              Navigator.of(context).pop();
              store.dispatch(
                  EditProduct(context: context, product: product.clone));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreProductRequest(
                  popCompleter(context,
                      AppLocalization.of(context).restoredProduct),
                  product.id));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveProductRequest(
                  popCompleter(context,
                      AppLocalization.of(context).archivedProduct),
                  product.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteProductRequest(
                  popCompleter(context,
                      AppLocalization.of(context).deletedProduct),
                  product.id));
              break;
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
                      context, localization.restoredProduct),
                  product.id));
            } else {
              store.dispatch(ArchiveProductRequest(
                  snackBarCompleter(
                      context, localization.archivedProduct),
                  product.id));
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (product.isDeleted) {
              store.dispatch(RestoreProductRequest(
                  snackBarCompleter(
                      context, localization.restoredProduct),
                  product.id));
            } else {
              store.dispatch(DeleteProductRequest(
                  snackBarCompleter(
                      context, localization.deletedProduct),
                  product.id));
            }
          }
        });
  }
}
