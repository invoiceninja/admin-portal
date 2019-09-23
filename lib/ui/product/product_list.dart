import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_item.dart';
import 'package:invoiceninja_flutter/ui/product/product_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProductListVM viewModel;

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isLoaded) {
      return LoadingIndicator();
    } else if (viewModel.productList.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.separated(
          separatorBuilder: (context, index) => ListDivider(),
          itemCount: viewModel.productList.length,
          itemBuilder: (BuildContext context, index) {
            final productId = viewModel.productList[index];
            final product = viewModel.productMap[productId];

            void showDialog() => showEntityActionsDialog(
                entity: product,
                context: context,
                userCompany: viewModel.state.userCompany,
                onEntityAction: viewModel.onEntityAction);

            return ProductListItem(
              userCompany: viewModel.state.userCompany,
              filter: viewModel.filter,
              product: product,
              onEntityAction: (EntityAction action) {
                if (action == EntityAction.more) {
                  showDialog();
                } else {
                  viewModel.onEntityAction(context, product, action);
                }
              },
              onTap: () => viewModel.onProductTap(context, product),
              onLongPress: () => showDialog(),
            );
          }),
    );
  }
}
