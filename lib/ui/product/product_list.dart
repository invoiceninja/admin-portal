import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/ui/product/product_item.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/ui/product/product_list_vm.dart';

class ProductList extends StatelessWidget {
  final ProductListVM viewModel;

  ProductList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return viewModel.isLoading ? LoadingIndicator() : _buildListView();
  }

  ListView _buildListView() {
    return ListView.builder(
        key: NinjaKeys.productList,
        itemCount: viewModel.productState.list.length,
        itemBuilder: (BuildContext context, int index) {
          final product = viewModel.productState.map[viewModel.productState.list[index]];

          return Column(children: <Widget>[
            ProductItem(
              product: product,
              onDismissed: (DismissDirection direction) => viewModel.onDismissed(context, product, direction),
              onTap: () => viewModel.onProductTap(context, product),
            ),
            Divider(
              height: 1.0,
            ),
          ]);
        });
  }
}
