import 'package:flutter/material.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/ui/product/product_list_vm.dart';
import 'package:invoiceninja/ui/product/product_details_vm.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen() : super(key: NinjaKeys.productHome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          //FilterSelector(visible: activeTab == AppTab.products),
          //ExtraActionsContainer(),
        ],
      ),
      body: ProductListVM(),
      floatingActionButton: FloatingActionButton(
        //key: ArchSampleKeys.addProductFab,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailsVM(id: 0)));
        },
        child: Icon(Icons.add),
        //tooltip: ArchSampleLocalizations.of(context).addProduct,
      ),
    );
  }
}
