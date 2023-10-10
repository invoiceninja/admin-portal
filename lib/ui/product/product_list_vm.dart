// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_item.dart';
import 'package:invoiceninja_flutter/ui/product/product_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductListBuilder extends StatelessWidget {
  const ProductListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductListVM>(
      converter: ProductListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.product,
            presenter: ProductPresenter(),
            state: viewModel.state,
            entityList: viewModel.productList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final productId = viewModel.productList[index];
              final product = viewModel.productMap[productId];
              final listState = state.getListState(EntityType.product);
              final isInMultiselect = listState.isInMultiselect();

              return ProductListItem(
                filter: viewModel.filter,
                product: product as ProductEntity,
                isChecked: isInMultiselect && listState.isSelected(product.id),
              );
            });
      },
    );
  }
}

class ProductListVM {
  ProductListVM({
    required this.state,
    required this.productList,
    required this.productMap,
    required this.filter,
    required this.isLoading,
    required this.onRefreshed,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static ProductListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return ProductListVM(
      state: state,
      productList: memoizedFilteredProductList(
          state.getUISelection(EntityType.product),
          state.productState.map,
          state.productState.list,
          state.productListState,
          state.userState.map),
      productMap: state.productState.map,
      isLoading: state.isLoading,
      filter: state.productUIState.listUIState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.product) ??
              ProductPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortProducts(field)),
      onClearMultielsect: () => store.dispatch(ClearProductMultiselect()),
    );
  }

  final AppState state;
  final List<String> productList;
  final BuiltMap<String?, BaseEntity?> productMap;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
