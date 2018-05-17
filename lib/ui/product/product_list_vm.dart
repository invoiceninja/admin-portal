import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../redux/product/product_actions.dart';
import '../../data/models/models.dart';
import '../../ui/product/product_list.dart';
import '../../redux/product/product_selectors.dart';
import '../../redux/app/app_state.dart';

class FilteredProducts extends StatelessWidget {
  FilteredProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ProductList(
          products: vm.products,
          onCheckboxChanged: vm.onCheckboxChanged,
        );
      },
    );
  }
}

class _ViewModel {
  final List<ProductEntity> products;
  final bool loading;
  final Function(ProductEntity, bool) onCheckboxChanged;

  _ViewModel({
    @required this.products,
    @required this.loading,
    @required this.onCheckboxChanged,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      products: filteredProductsSelector(
        productsSelector(store.state),
        //activeFilterSelector(store.state),
      ),
      loading: store.state.isLoading,
      onCheckboxChanged: (product, complete) {
        /*
        store.dispatch(UpdateProductAction(
          product.id,
          product.copyWith(complete: !product.complete),
        ));
        */
      },
    );
  }
}
