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

class ProductScreen extends StatelessWidget {
  ProductScreen() : super(key: NinjaKeys.productHome);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
          ActionMenuButton(
            scaffoldKey: _scaffoldKey,
            onSelectedSort: (value) {
              print('sort by: ' + value);
            },
            sortFields: [
              SortField(ProductFields.productKey, AppLocalization.of((context)).product),
              SortField(ProductFields.cost, AppLocalization.of((context)).cost),
            ],
            actions: [
              ActionMenuChoice(ActionMenuButtonType.sort),
              ActionMenuChoice(ActionMenuButtonType.filter),
            ],
            onSelected: (ActionMenuChoice choice) {

            },
          )
          //FilterSelector(visible: activeTab == AppTab.products),
          //ExtraActionsContainer(),
        ],
      ),
      drawer: AppDrawerBuilder(),
      body: ProductListBuilder(),
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
            //tooltip: ArchSampleLocalizations.of(context).addProduct,
          );
        },
      ),
    );
  }
}
