import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProductViewVM viewModel;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final product = viewModel.product;
    final company = viewModel.company;
    final user = company.user;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: _CustomAppBar(
          viewModel: viewModel,
        ),
        body: Text('test'),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    @required this.viewModel,
  });

  final ProductViewVM viewModel;

  @override
  final Size preferredSize = const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final user = viewModel.company.user;
    final product = viewModel.product;

    return AppBar(
      title: Text(product.productKey),
      actions: [
        user.canEditEntity(product)
            ? EditIconButton(
                isVisible: !product.isDeleted,
                onPressed: () => viewModel.onEditPressed(context),
              )
            : Container(),
        ActionMenuButton(
          user: user,
          entityActions: product.getActions(user: user),
          isSaving: viewModel.isSaving,
          entity: product,
          onSelected: viewModel.onEntityAction,
        )
      ],
    );
  }
}
