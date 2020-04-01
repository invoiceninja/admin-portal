import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:invoiceninja_flutter/ui/product/product_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/product';

  final ProductScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.productUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.productList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartProductMultiselect()),
      onCheckboxChanged: (value) {
        final products = viewModel.productList
            .map<ProductEntity>((productId) => viewModel.productMap[productId])
            .where((product) => value != listUIState.isSelected(product.id))
            .toList();
        handleProductAction(context, products, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.products,
        key: ValueKey(store.state.productListState.filterClearedAt),
        filter: state.productListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterProducts(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.productListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterProducts(value));
            },
          ),
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final products = listUIState.selectedIds
                        .map<ProductEntity>(
                            (productId) => viewModel.productMap[productId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: products,
                        context: context,
                        multiselect: true,
                        completer: Completer<Null>()
                          ..future.then<dynamic>((_) =>
                              store.dispatch(ClearProductMultiselect())));
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearProductMultiselect()),
          ),
      ],
      body: ProductListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.product,
        onSelectedSortField: (value) => store.dispatch(SortProducts(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.product1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.product2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.product3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.product4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterProductsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterProductsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterProductsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterProductsByCustom4(value)),
        sortFields: [
          ProductFields.productKey,
          ProductFields.cost,
          ProductFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProductsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.productListState.isInMultiselect()) {
            store.dispatch(ClearProductMultiselect());
          } else {
            store.dispatch(StartProductMultiselect());
          }
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.product)
          ? FloatingActionButton(
              heroTag: 'product_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.product);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newProduct,
            )
          : null,
    );
  }
}
