import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/ui/product/product_item.dart';
import 'package:invoiceninja/ui/product/product_list_vm.dart';

class ProductList extends StatelessWidget {
  final ProductListVM viewModel;

  const ProductList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (! viewModel.isLoaded) {
      return LoadingIndicator();
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.productList.length,
          itemBuilder: (BuildContext context, index) {
            final productId = viewModel.productList[index];
            final product = viewModel.productMap[productId];
            return Column(children: <Widget>[
              ProductItem(
                filter: viewModel.filter,
                state: viewModel.state,
                product: product,
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, product, direction),
                onTap: () => viewModel.onProductTap(context, product),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
