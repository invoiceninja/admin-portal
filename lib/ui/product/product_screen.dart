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
import 'package:invoiceninja/ui/app/custom_drawer_vm.dart';


class ProductScreen extends StatelessWidget {
  ProductScreen() : super(key: NinjaKeys.productHome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).products),
        actions: [
          //FilterSelector(visible: activeTab == AppTab.products),
          //ExtraActionsContainer(),
        ],
      ),
      drawer: CustomDrawerVM(),
      body: ProductListBuilder(),
      floatingActionButton: StoreConnector(
        converter: (Store<AppState> store) => store,
        builder: (context, store) {
          return FloatingActionButton(
            //key: ArchSampleKeys.addProductFab,
            onPressed: () {
              store.dispatch(SelectProductAction(ProductEntity()));
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailsBuilder(id: 0)));
            },
            child: Icon(Icons.add),
            //tooltip: ArchSampleLocalizations.of(context).addProduct,
          );
        },
      ),
    );
  }
}
