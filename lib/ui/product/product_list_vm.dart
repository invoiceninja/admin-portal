import 'dart:async';
import 'package:invoiceninja/ui/app/snackbar_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/product/product_list.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/ui/product/product_details_vm.dart';

class ProductListBuilder extends StatelessWidget {
  ProductListBuilder({Key key}) : super(key: key);

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
  final ProductState productState;
  final bool isLoading;
  final Function(BuildContext, ProductEntity) onProductTap;
  final Function(BuildContext, ProductEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;

  ProductListVM({
    @required this.productState,
    @required this.isLoading,
    @required this.onProductTap,
    @required this.onDismissed,
    @required this.onRefreshed,
  });

  static ProductListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      final Completer<Null> completer = new Completer<Null>();
      store.dispatch(LoadProductsAction(completer));
      return completer.future.then((_) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: SnackBarRow(
              message: AppLocalization.of(context).refreshComplete,
            ),
            duration: Duration(seconds: 3)));
      });
    }

    return ProductListVM(
        productState: store.state.productState(),
        /*
      products: filteredProductsSelector(
        productsSelector(store.state),
        //activeFilterSelector(store.state),
      ),
      */
        isLoading: store.state.productState().lastUpdated == 0,
        onProductTap: (context, product) {
          store.dispatch(SelectProductAction(product));
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => ProductDetailsBuilder()));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, ProductEntity product,
            DismissDirection direction) {
          final Completer<Null> completer = new Completer<Null>();
          if (direction == DismissDirection.endToStart) {
            store.dispatch(ArchiveProductRequest(completer, product.id));
          } else if (direction == DismissDirection.startToEnd) {
            store.dispatch(DeleteProductRequest(completer, product.id));
          }
        });
  }
}
