import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
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
  ProductListVM({
    @required this.user,
    @required this.productList,
    @required this.productMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onProductTap,
    @required this.onRefreshed,
    @required this.onEntityAction,
  });

  static ProductListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadProducts(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return ProductListVM(
      user: state.user,
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
        final localization = AppLocalization.of(context);
        switch (action) {
          case EntityAction.newInvoice:
            final item =
                convertProductToInvoiceItem(context: context, product: product);
            store.dispatch(EditInvoice(
                context: context,
                invoice: InvoiceEntity(company: state.selectedCompany)
                    .rebuild((b) => b..invoiceItems.add(item))));
            break;
          case EntityAction.edit:
            store.dispatch(EditProduct(context: context, product: product));
            break;
          case EntityAction.clone:
            store.dispatch(
                EditProduct(context: context, product: product.clone));
            break;
          case EntityAction.restore:
            store.dispatch(RestoreProductRequest(
                snackBarCompleter(context, localization.restoredProduct),
                product.id));
            break;
          case EntityAction.archive:
            store.dispatch(ArchiveProductRequest(
                snackBarCompleter(context, localization.archivedProduct),
                product.id));
            break;
          case EntityAction.delete:
            store.dispatch(DeleteProductRequest(
                snackBarCompleter(context, localization.deletedProduct),
                product.id));
            break;
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final UserEntity user;
  final List<int> productList;
  final BuiltMap<int, ProductEntity> productMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ProductEntity) onProductTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, ProductEntity, EntityAction) onEntityAction;
}
