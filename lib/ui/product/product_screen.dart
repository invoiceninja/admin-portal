import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:invoiceninja/ui/app/app_search.dart';
import 'package:invoiceninja/ui/app/app_search_button.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/ui/product/product_list_vm.dart';
import 'package:invoiceninja/ui/product/product_details_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/app/app_bottom_bar.dart';
import 'package:redux/redux.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen() : super(key: NinjaKeys.productHome);

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
          AppSearchButton(),
        ],
      ),
      drawer: AppDrawerBuilder(),
      body: ProductListBuilder(),
      bottomNavigationBar: AppBottomBar(
        selectedSortField: store.state.productListState().sortField,
        selectedSortAscending: store.state.productListState().sortAscending,
        onSelectedSortField: (value) {
          store.dispatch(SortProducts(value));
        },
        sortFields: [
          ProductFields.productKey,
          ProductFields.cost,
        ],
        selectedStates: store.state.productListState().stateFilters,
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProductsByState(state));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        //key: ArchSampleKeys.addProductFab,
        onPressed: () {
          store.dispatch(SelectProductAction(ProductEntity()));
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => ProductDetailsBuilder()));
        },
        child: Icon(Icons.add),
        tooltip: localization.newProduct,
      ),
    );
  }
}
