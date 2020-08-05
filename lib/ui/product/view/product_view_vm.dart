import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view.dart';
import 'package:redux/redux.dart';

class ProductViewScreen extends StatelessWidget {
  const ProductViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/product/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductViewVM>(
      //distinct: true,
      converter: (Store<AppState> store) {
        return ProductViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ProductView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class ProductViewVM {
  ProductViewVM({
    @required this.state,
    @required this.product,
    @required this.company,
    @required this.onEntityAction,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onRefreshed,
  });

  factory ProductViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final product = state.productState.map[state.productUIState.selectedId] ??
        ProductEntity(id: state.productUIState.selectedId);

    /*
    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadProduct(
          completer: completer,
          productId: product.id,));
      return completer.future;
    }
    */

    return ProductViewVM(
      state: state,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: product.isNew,
      product: product,
      company: state.company,
      onRefreshed: null,
      /*
      onRefreshed: (context) =>
          _handleRefresh(context),
          */
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context, [product], action, autoPop: true),
    );
  }

  final AppState state;
  final ProductEntity product;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;

  @override
  bool operator ==(dynamic other) =>
      product == other.product && company == other.company;

  @override
  int get hashCode => product.hashCode ^ company.hashCode;
}
