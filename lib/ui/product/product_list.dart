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
import 'package:invoiceninja_flutter/ui/app/presenters/product_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable_source.dart';
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

    dataTableSource.entityList = widget.viewModel.productList;
    dataTableSource.entityMap = widget.viewModel.productMap;

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
              ...widget.viewModel.columnFields.map((field) => DataColumn(
                  label: Text(localization.lookup(field)),
                  numeric: ['cost', 'price', 'amount', 'total', 'balance']
                      .contains(field),
                  onSort: (int columnIndex, bool ascending) => sortFn(field))),
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

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  void initState() {
    super.initState();
    dataTableSource = EntityDataTableSource(
        context: context,
        columnFields: widget.viewModel.columnFields,
        entityList: widget.viewModel.productList,
        entityMap: widget.viewModel.productMap,
        entityPresenter: ProductPresenter(),
        onTap: (ProductEntity product) =>
            widget.viewModel.onProductTap(context, product));
  }

  EntityDataTableSource dataTableSource;
}
