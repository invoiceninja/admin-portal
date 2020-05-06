import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.product1,
          value: product.customValue1);
    }

    if (product.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.product2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.product2,
          value: product.customValue2);
    }

    return ViewScaffold(
      entity: product,
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                EntityHeader(
                  label: localization.price,
                  value: formatNumber(product.price, context),
                  secondLabel: localization.cost,
                  secondValue: company.enableProductCost
                      ? formatNumber(product.cost, context)
                      : null,
                ),
                ListDivider(),
                FieldGrid(fields),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    product.notes,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          BottomButtons(
            entity: product,
            action1: EntityAction.clone,
            action2: EntityAction.newInvoice,
          ),
        ],
      ),
    );
  }
}
