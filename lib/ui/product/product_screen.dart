import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
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
    final company = state.selectedCompany;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.productUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return AppScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedEntities.length == viewModel.productList.length,
      showCheckbox: isInMultiselect,
      onCheckboxChanged: (value) {
        final products = viewModel.productList
            .map<ProductEntity>((productId) => viewModel.productMap[productId])
            .where((product) => value != listUIState.isSelected(product))
            .toList();

        viewModel.onEntityAction(
            context, products, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        key: ValueKey(store.state.productListState.filterClearedAt),
        entityType: EntityType.product,
        onFilterChanged: (value) {
          store.dispatch(FilterProducts(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            entityType: EntityType.product,
            onFilterPressed: (String value) {
              store.dispatch(FilterProducts(value));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearProductMultiselect(context: context));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.productListState.selectedEntities.isEmpty
                ? null
                : () async {
                    await showEntityActionsDialog(
                        entities: state.productListState.selectedEntities,
                        userCompany: userCompany,
                        context: context,
                        onEntityAction: viewModel.onEntityAction,
                        multiselect: true);
                    store.dispatch(ClearProductMultiselect(context: context));
                  },
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
        onSelectedCustom1: (value) =>
            store.dispatch(FilterProductsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterProductsByCustom2(value)),
        sortFields: [
          ProductFields.productKey,
          ProductFields.cost,
          ProductFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProductsByState(state));
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.product)
          ? FloatingActionButton(
              heroTag: 'product_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(
                    EditProduct(product: ProductEntity(), context: context));
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
