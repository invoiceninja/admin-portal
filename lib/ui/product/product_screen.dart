import 'package:invoiceninja/ui/app/app_search.dart';
import 'package:invoiceninja/ui/app/app_search_button.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/product/product_list_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/app/app_bottom_bar.dart';

class ProductScreen extends StatelessWidget {
  static final String route = '/products';

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: AppSearch(
          entityType: EntityType.product,
          onSearchChanged: (value) {
            store.dispatch(SearchProducts(value));
          },
        ),
        actions: [
          AppSearchButton(
            entityType: EntityType.product,
            onSearchPressed: (value) {
              store.dispatch(SearchProducts(value));
            },
          ),
        ],
      ),
      drawer: AppDrawerBuilder(),
      body: ProductListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.product,
        onSelectedSortField: (value) {
          store.dispatch(SortProducts(value));
        },
        sortFields: [
          ProductFields.productKey,
          ProductFields.cost,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProductsByState(state));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}

