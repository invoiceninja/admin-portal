import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_item.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProductListVM viewModel;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    if (!widget.viewModel.isLoaded) {
      return widget.viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (widget.viewModel.productList.isEmpty) {
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
    final productList = widget.viewModel.productList;

    dataTableSource.productList = widget.viewModel.productList;
    dataTableSource.productMap = widget.viewModel.productMap;

    if (isNotMobile(context) &&
        productList.isNotEmpty &&
        !state.uiState.isEditing &&
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
            itemCount: widget.viewModel.productList.length,
            itemBuilder: (BuildContext context, index) {
              final productId = widget.viewModel.productList[index];
              final product = widget.viewModel.productMap[productId];

              void showDialog() => showEntityActionsDialog(
                    entities: [product],
                    context: context,
                  );

              return ProductListItem(
                userCompany: widget.viewModel.state.userCompany,
                filter: widget.viewModel.filter,
                product: product,
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleProductAction(context, [product], action);
                  }
                },
                onTap: () => widget.viewModel.onProductTap(context, product),
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
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: PaginatedDataTable(
            columns: [
              DataColumn(label: SizedBox()),
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
            source: dataTableSource,
            header: SizedBox(),
          ),
        ));
      }
    };

    return RefreshIndicator(
      onRefresh: () => widget.viewModel.onRefreshed(context),
      child: listOrTable(),
    );
  }

  @override
  void didUpdateWidget(ProductList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // The PaginatedDataTable does not update dynamically without this
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  void initState() {
    super.initState();
    dataTableSource = ProductDataTableSource(
        context: context,
        productList: widget.viewModel.productList,
        productMap: widget.viewModel.productMap,
        onTap: (ProductEntity product) =>
            widget.viewModel.onProductTap(context, product));
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
        DataCell(FlatButton(
          child: Text(
            AppLocalization.of(context).edit,
          ),
          onPressed: () {
            editEntity(context: context, entity: product);
          },
        )),
        DataCell(Text(product.productKey), onTap: onTap),
        DataCell(Text(product.price.toString()), onTap: onTap),
        DataCell(Text(product.cost.toString()), onTap: onTap),
        DataCell(Text(product.quantity.toString()), onTap: onTap),
      ]);
    }).toList();
  }

  ProductDataTableSource dataTableSource;
}

class ProductDataTableSource extends DataTableSource {
  ProductDataTableSource(
      {@required this.context,
      @required this.productList,
      @required this.productMap,
      @required this.onTap});

  @override
  DataRow getRow(int index) {
    final state = StoreProvider.of<AppState>(context).state;
    final product = productMap[productList[index]];
    return DataRow(cells: [
      DataCell(ActionMenuButton(
        entityActions: product.getActions(
            userCompany: state.userCompany, includeEdit: true),
        isSaving: false,
        entity: product,
        onSelected: (context, action) =>
            handleProductAction(context, [product], action),
      )),
      DataCell(Text(product.productKey), onTap: () => onTap(product)),
      DataCell(Text(product.price.toString()), onTap: () => onTap(product)),
      DataCell(Text(product.cost.toString()), onTap: () => onTap(product)),
      DataCell(Text(product.quantity.toString()), onTap: () => onTap(product)),
    ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => productList.length;

  BuildContext context;
  List<String> productList;
  BuiltMap<String, ProductEntity> productMap;
  final Function(ProductEntity product) onTap;
}
