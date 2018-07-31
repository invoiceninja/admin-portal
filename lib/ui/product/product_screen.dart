import 'package:invoiceninja_flutter/ui/app/app_search.dart';
import 'package:invoiceninja_flutter/ui/app/app_search_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

class ProductScreen extends StatelessWidget {
  static const String route = '/product';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);

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
            onSearchPressed: (String value) {
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
          ProductFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProductsByState(state));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        key: Key(ProductKeys.productScreenFABKeyString),
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

