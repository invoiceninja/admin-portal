// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductOverview extends StatefulWidget {
  const ProductOverview({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ProductViewVM viewModel;

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final product = viewModel.product;
    final company = viewModel.company!;

    String tax = '';
    if (product.taxName1.isNotEmpty) {
      tax += formatNumber(product.taxRate1, context,
              formatNumberType: FormatNumberType.percent)! +
          ' ' +
          product.taxName1;
    }
    if (product.taxName2.isNotEmpty) {
      tax += ' ' +
          formatNumber(product.taxRate2, context,
              formatNumberType: FormatNumberType.percent)! +
          ' ' +
          product.taxName2;
    }

    final fields = <String?, String?>{
      localization.tax: tax,
    };

    if (company.calculateTaxes) {
      fields[localization.taxCategory] =
          localization.lookup(kTaxCategories[product.taxCategoryId]);
    }

    if (company.hasCustomField(CustomFieldType.product1) &&
        product.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.product1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.product1,
          value: product.customValue1);
    }

    if (company.hasCustomField(CustomFieldType.product2) &&
        product.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.product2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.product2,
          value: product.customValue2);
    }

    if (company.hasCustomField(CustomFieldType.product3) &&
        product.customValue3.isNotEmpty) {
      final label3 = company.getCustomFieldLabel(CustomFieldType.product3);
      fields[label3] = formatCustomValue(
          context: context,
          field: CustomFieldType.product3,
          value: product.customValue3);
    }

    if (company.hasCustomField(CustomFieldType.product4) &&
        product.customValue4.isNotEmpty) {
      final label4 = company.getCustomFieldLabel(CustomFieldType.product4);
      fields[label4] = formatCustomValue(
          context: context,
          field: CustomFieldType.product4,
          value: product.customValue4);
    }

    if (company.trackInventory) {
      fields[localization.stockQuantity] = formatNumber(
          product.stockQuantity.toDouble(), context,
          formatNumberType: FormatNumberType.int);

      if (product.stockNotificationThreshold != 0) {
        fields[localization.notificationThreshold] = formatNumber(
            product.stockNotificationThreshold.toDouble(), context,
            formatNumberType: FormatNumberType.int);
      }
    }

    if (product.maxQuantity > 0) {
      fields[localization.maxQuantity] = formatNumber(
          product.maxQuantity.toDouble(), context,
          formatNumberType: FormatNumberType.int);
    }

    if (product.imageUrl.isNotEmpty) {
      fields[localization.imageUrl] = product.imageUrl;
    }

    return ScrollableListView(
      children: <Widget>[
        EntityHeader(
          entity: product,
          label: localization.price,
          value: formatNumber(product.price, context, roundToPrecision: false),
          secondLabel: localization.cost,
          secondValue: company.enableProductCost
              ? formatNumber(product.cost, context, roundToPrecision: false)
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
    );
  }
}
