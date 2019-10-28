import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/one_value_header.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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
    final viewModel = widget.viewModel;
    final product = viewModel.product;
    final company = viewModel.company;

    String tax = '';
    if (product.taxName1.isNotEmpty) {
      tax += formatNumber(product.taxRate1, context,
              formatNumberType: FormatNumberType.percent) +
          ' ' +
          product.taxName1;
    }
    if (product.taxName2.isNotEmpty) {
      tax += ' ' +
          formatNumber(product.taxRate2, context,
              formatNumberType: FormatNumberType.percent) +
          ' ' +
          product.taxName2;
    }

    final fields = <String, String>{
      localization.tax: tax,
    };

    if (product.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.product1);
      fields[label1] = product.customValue1;
    }

    if (product.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.product2);
      fields[label2] = product.customValue2;
    }

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: _CustomAppBar(
          viewModel: viewModel,
        ),
        body: ListView(
          children: <Widget>[
            OneValueHeader(
              label: localization.price,
              value: formatNumber(product.price, context),
            ),
            FieldGrid(fields),
            Divider(
              height: 1.0,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                product.notes,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
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
    final userCompany = viewModel.state.userCompany;
    final product = viewModel.product;

    return AppBar(
      automaticallyImplyLeading: isMobile(context),
      title: EntityStateTitle(entity: product),
      actions: [
        userCompany.canEditEntity(product)
            ? EditIconButton(
                isVisible: !product.isDeleted,
                onPressed: () => viewModel.onEditPressed(context),
              )
            : Container(),
        ActionMenuButton(
          entityActions: product.getActions(userCompany: userCompany),
          isSaving: viewModel.isSaving,
          entity: product,
          onSelected: viewModel.onEntityAction,
        )
      ],
    );
  }
}
