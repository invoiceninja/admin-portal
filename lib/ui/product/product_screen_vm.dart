// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'product_screen.dart';

class ProductScreenBuilder extends StatelessWidget {
  const ProductScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductScreenVM>(
      converter: ProductScreenVM.fromStore,
      builder: (context, vm) {
        return ProductScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ProductScreenVM {
  ProductScreenVM({
    required this.isInMultiselect,
    required this.productList,
    required this.userCompany,
    required this.productMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> productList;
  final BuiltMap<String, ProductEntity> productMap;

  static ProductScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ProductScreenVM(
      productMap: state.productState.map,
      productList: memoizedFilteredProductList(
          state.getUISelection(EntityType.product),
          state.productState.map,
          state.productState.list,
          state.productListState,
          state.userState.map),
      userCompany: state.userCompany,
      isInMultiselect: state.productListState.isInMultiselect(),
    );
  }
}
