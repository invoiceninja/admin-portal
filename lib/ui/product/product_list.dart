import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_item.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProductListVM viewModel;

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.productList.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final listUIState = store.state.uiState.productUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final isList = store.state.prefState.moduleLayout == ModuleLayout.list;
    final localization = AppLocalization.of(context);
    final state = store.state;
    final productList = viewModel.productList;

    if (isNotMobile(context) &&
        productList.isNotEmpty &&
        !productList.contains(state.productUIState.selectedId)) {
      viewEntityById(
          context: context,
          entityType: EntityType.product,
          entityId: productList.first);
    }

    final listOrTable = () {
      if (isList) {
        return ListView.separated(
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: viewModel.productList.length,
            itemBuilder: (BuildContext context, index) {
              final productId = viewModel.productList[index];
              final product = viewModel.productMap[productId];

              void showDialog() => showEntityActionsDialog(
                    entities: [product],
                    context: context,
                  );

              return ProductListItem(
                userCompany: viewModel.state.userCompany,
                filter: viewModel.filter,
                product: product,
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleProductAction(context, [product], action);
                  }
                },
                onTap: () => viewModel.onProductTap(context, product),
                onLongPress: () async {
                  final longPressIsSelection =
                      store.state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handleProductAction(
                        context, [product], EntityAction.toggleMultiselect);
                  } else {
                    showDialog();
                  }
                },
                isChecked:
                    isInMultiselect && listUIState.isSelected(product.id),
              );
            });
      } else {
        final sortFn = (String field) => store.dispatch(SortProducts(field));

        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text(localization.name),
                        onSort: (int columnIndex, bool ascending) =>
                            sortFn(ProductFields.productKey)),
                    DataColumn(
                        label: Text(localization.price),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) =>
                            sortFn(ProductFields.price)),
                    DataColumn(
                        label: Text(localization.cost),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) =>
                            sortFn(ProductFields.cost)),
                    DataColumn(
                        label: Text(localization.quantity),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) =>
                            sortFn(ProductFields.quantity)),
                  ],
                  rows: getDataTableRows(context, viewModel),
                )));
      }
    };

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: listOrTable(),
    );
  }

  List<DataRow> getDataTableRows(
      BuildContext context, ProductListVM viewModel) {
    final products = viewModel.productList
        .map((productId) => viewModel.productMap[productId])
        .toList();

    return products.map((product) {
      // TODO: Re-implement
      final onTap = () => viewModel.onProductTap(context, product);

      return DataRow(cells: [
        DataCell(Text(product.productKey), onTap: onTap),
        DataCell(Text(product.price.toString()), onTap: onTap),
        DataCell(Text(product.cost.toString()), onTap: onTap),
        DataCell(Text(product.quantity.toString()), onTap: onTap),
      ]);
    }).toList();
  }
}
