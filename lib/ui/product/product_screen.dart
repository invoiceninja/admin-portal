import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/ui/product/product_list_vm.dart';
import 'package:invoiceninja/ui/product/product_details_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/app/action_popup_menu.dart';
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
      body: ProductListBuilder(),
      bottomNavigationBar: AppBottomBar(
        scaffoldKey: _scaffoldKey,
        selectedSort: StoreProvider.of<AppState>(context).state.productUIState().sortField,
        onSelectedSort: (value) {
          StoreProvider.of<AppState>(context).dispatch(SortProducts(value));
        },
        sortFields: [
          ProductFields.productKey,
          ProductFields.cost,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: StoreConnector(
        converter: (Store<AppState> store) => store,
        builder: (context, store) {
          return FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            //key: ArchSampleKeys.addProductFab,
            onPressed: () {
              store.dispatch(SelectProductAction(ProductEntity()));
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ProductDetailsBuilder()));
            },
            child: Icon(Icons.add),
            tooltip: AppLocalization.of(context).newProduct,
          );
        },
      ),
    );
  }
}
