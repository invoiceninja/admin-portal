import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_item.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
    } else if (viewModel.productList.isEmpty) {
      return Opacity(
        opacity: 0.5,
        child: Center(
            child: Text(
                AppLocalization.of(context).noRecordsFound,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
        ),
      );
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          itemCount: viewModel.productList.length,
          itemBuilder: (BuildContext context, index) {
            final productId = viewModel.productList[index];
            final product = viewModel.productMap[productId];
            return Column(children: <Widget>[
              ProductListItem(
                filter: viewModel.filter,
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
