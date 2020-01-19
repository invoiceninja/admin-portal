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
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/product_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_item.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.product,
        editingId: viewModel.state.productUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.productList,
        entityMap: viewModel.productMap,
        entityPresenter: ProductPresenter(),
        onTap: (BaseEntity product) =>
            viewModel.onProductTap(context, product));
  }

  @override
  void didUpdateWidget(ProductList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.productUIState.editing.id;
    dataTableSource.entityList = viewModel.productList;
    dataTableSource.entityMap = viewModel.productMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final listUIState = state.uiState.productUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final productList = viewModel.productList;

    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.productMap.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    if (state.shouldSelectEntity(
        entityType: EntityType.product, hasRecords: productList.isNotEmpty)) {
      viewEntityById(
          context: context,
          entityType: EntityType.product,
          entityId: productList.isEmpty ? null : productList.first);
    }

    final listOrTable = () {
      if (state.prefState.moduleLayout == ModuleLayout.list) {
        return ListView.separated(
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: viewModel.productList.length,
            itemBuilder: (BuildContext context, index) {
              final productId = viewModel.productList[index];
              final product = viewModel.productMap[productId];

              return ProductListItem(
                userCompany: viewModel.state.userCompany,
                filter: viewModel.filter,
                product: product,
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showEntityActionsDialog(
                      entities: [product],
                      context: context,
                    );
                  } else {
                    handleProductAction(context, [product], action);
                  }
                },
                onTap: () => viewModel.onProductTap(context, product),
                onLongPress: () async {
                  final longPressIsSelection =
                      state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handleProductAction(
                        context, [product], EntityAction.toggleMultiselect);
                  } else {
                    showEntityActionsDialog(
                      entities: [product],
                      context: context,
                    );
                  }
                },
                isChecked:
                    isInMultiselect && listUIState.isSelected(product.id),
              );
            });
      } else {
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: PaginatedDataTable(
            onSelectAll: (value) {
              final products = viewModel.productList
                  .map<ProductEntity>(
                      (productId) => viewModel.productMap[productId])
                  .where(
                      (product) => value != listUIState.isSelected(product.id))
                  .toList();
              handleProductAction(
                  context, products, EntityAction.toggleMultiselect);
            },
            columns: [
              if (!listUIState.isInMultiselect()) DataColumn(label: SizedBox()),
              ...viewModel.tableColumns.map((field) => DataColumn(
                  label: Text(AppLocalization.of(context).lookup(field)),
                  numeric: EntityPresenter.isFieldNumeric(field),
                  onSort: (int columnIndex, bool ascending) =>
                      store.dispatch(SortProducts(field)))),
            ],
            source: dataTableSource,
            header: DatatableHeader(
              entityType: EntityType.product,
              onClearPressed: null,
            ),
          ),
        ));
      }
    };

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: listOrTable(),
    );
  }
}
