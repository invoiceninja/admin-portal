import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
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
    if (!viewModel.isLoaded) {
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

  void _showMenu(BuildContext context, ProductEntity product) async {
    if (product == null) {
      return;
    }
    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(children: <Widget>[
              user.canCreate(EntityType.product)
                  ? ListTile(
                      leading: Icon(Icons.control_point_duplicate),
                      title: Text(AppLocalization.of(context).clone),
                      onTap: () => viewModel.onEntityAction(
                          context, product, EntityAction.clone),
                    )
                  : Container(),
              Divider(),
              user.canEditEntity(product) && !product.isActive
                  ? ListTile(
                      leading: Icon(Icons.restore),
                      title: Text(AppLocalization.of(context).restore),
                      onTap: () => viewModel.onEntityAction(
                          context, product, EntityAction.restore),
                    )
                  : Container(),
              user.canEditEntity(product) && product.isActive
                  ? ListTile(
                      leading: Icon(Icons.archive),
                      title: Text(AppLocalization.of(context).archive),
                      onTap: () => viewModel.onEntityAction(
                          context, product, EntityAction.archive),
                    )
                  : Container(),
              user.canEditEntity(product) && !product.isDeleted
                  ? ListTile(
                      leading: Icon(Icons.delete),
                      title: Text(AppLocalization.of(context).delete),
                      onTap: () => viewModel.onEntityAction(
                          context, product, EntityAction.delete),
                    )
                  : Container(),
            ]));
    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: SnackBarRow(
        message: message,
      )));
    }
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
                user: viewModel.user,
                filter: viewModel.filter,
                product: product,
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, product, direction),
                onTap: () => viewModel.onProductTap(context, product),
                onLongPress: () => _showMenu(context, product),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
