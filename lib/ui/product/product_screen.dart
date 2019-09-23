import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class ProductScreen extends StatelessWidget {
  static const String route = '/product';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(store.state.productListState.filterClearedAt),
        entityType: EntityType.product,
        onFilterChanged: (value) {
          store.dispatch(FilterProducts(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.product,
          onFilterPressed: (String value) {
            store.dispatch(FilterProducts(value));
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
