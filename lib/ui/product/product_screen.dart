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

class ProductScreen extends StatelessWidget {
  ProductScreen() : super(key: NinjaKeys.productHome);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //static ActionMenuButtonType _activeSheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalization.of(context).products),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          /*
          ActionMenuButton(
            onSelectedSort: (value, callback) {
              StoreProvider.of<AppState>(context).dispatch(SortProducts(value));
              //callback();
            },
            actions: [
              ActionMenuChoice(ActionMenuButtonType.sort),
              ActionMenuChoice(ActionMenuButtonType.filter),
            ],
            onSelected: (ActionMenuChoice choice) {},
          )
          */
        ],
      ),
      drawer: AppDrawerBuilder(),
      /*
      body: StoreBuilder<AppState>(
        rebuildOnChange: true,
        //onInit: (store) => store.dispatch(LoadDashboardAction()),
        builder: (context, store) {
          return ProductListBuilder();
        },
      ),
      */
      body: ProductListBuilder(),
      bottomNavigationBar: AppBottomBar(
        scaffoldKey: _scaffoldKey,
        selectedSortField: StoreProvider
            .of<AppState>(context)
            .state
            .productListState()
            .sortField,
        selectedSortAscending: StoreProvider
            .of<AppState>(context)
            .state
            .productListState()
            .sortAscending,
        onSelectedSortField: (value) {
          StoreProvider.of<AppState>(context).dispatch(SortProducts(value));
        },
        sortFields: [
          ProductFields.productKey,
          ProductFields.cost,
        ],
        selectedStates: StoreProvider
            .of<AppState>(context)
            .state
            .productListState()
            .stateFilters,
        onSelectedState: (EntityState state, value) {
          StoreProvider
              .of<AppState>(context)
              .dispatch(FilterProductsByState(state));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        //key: ArchSampleKeys.addProductFab,
        onPressed: () {
          StoreProvider
              .of<AppState>(context)
              .dispatch(SelectProductAction(ProductEntity()));
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => ProductDetailsBuilder()));
        },
        child: Icon(Icons.add),
        tooltip: AppLocalization.of(context).newProduct,
      ),
    );
  }
}
