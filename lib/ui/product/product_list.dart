import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/app_loading.dart';
import 'package:invoiceninja/ui/product/product_details_vm.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/ui/product/product_item.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/redux/product/product_state.dart';

class ProductList extends StatelessWidget {
  final ProductState productState;
  final Function(ProductEntity, bool) onCheckboxChanged;

  ProductList({
    Key key,
    @required this.productState,
    @required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, isLoading) {
      return isLoading && this.productState.lastUpdated == 0
          ? LoadingIndicator()
          : _buildListView();
    });
  }

  ListView _buildListView() {
    return ListView.builder(
      key: NinjaKeys.productList,
      itemCount: productState.list.length,
      itemBuilder: (BuildContext context, int index) {
        final product = productState.map[productState.list[index]];

        return ProductItem(
          product: product,
          onDismissed: (direction) {
            //_removeProduct(context, product);
          },
          onTap: () => _onProductTap(context, product),
          onCheckboxChanged: (complete) {
            onCheckboxChanged(product, complete);
          },
        );
      },
    );
  }

  void _onProductTap(BuildContext context, ProductEntity product) {
    Navigator
        .of(context)
        .push(MaterialPageRoute(
      builder: (_) => ProductDetails(id: product.id),
    ))
        .then((removedProduct) {
      if (removedProduct != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            key: NinjaKeys.snackbar,
            duration: Duration(seconds: 2),
            backgroundColor: Theme.of(context).backgroundColor,
            content: Text('Text'),
            action: SnackBarAction(
              label: 'Label',
              onPressed: () {
                print('Client pressed..');
              },
            )));
      }
    });
  }
}
