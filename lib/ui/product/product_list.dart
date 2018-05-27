import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/app_loading.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/ui/product/product_item.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/redux/product/product_state.dart';

class ProductList extends StatelessWidget {
  final ProductState productState;
  final Function(BuildContext, ProductEntity) onProductTap;

  ProductList({
    Key key,
    @required this.productState,
    @required this.onProductTap,
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
          onTap: () => onProductTap(context, product),
        );
      },
    );
  }
}