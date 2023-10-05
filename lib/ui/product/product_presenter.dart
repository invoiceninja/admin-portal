// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    final company = userCompany.company;

    return [
      ProductFields.productKey,
      ProductFields.description,
      if (company.enableProductCost) ProductFields.cost,
      ProductFields.price,
      if (company.enableProductQuantity) ProductFields.quantity,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    final company = userCompany.company;

    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      ProductFields.customValue1,
      ProductFields.customValue2,
      ProductFields.customValue3,
      ProductFields.customValue4,
      ProductFields.documents,
      ProductFields.taxRate1,
      ProductFields.taxRate2,
      ProductFields.taxRate3,
      ProductFields.taxName1,
      ProductFields.taxName2,
      ProductFields.taxName3,
      ProductFields.stockQuantity,
      ProductFields.notificationThreshold,
      if (company.calculateTaxes) ProductFields.taxCategory,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final product = entity as ProductEntity?;
    final localization = AppLocalization.of(context);

    switch (field) {
      case ProductFields.productKey:
        return Text(product!.productKey);
      case ProductFields.description:
        return TableTooltip(message: product!.notes);
      case ProductFields.cost:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(product!.cost, context,
              formatNumberType: FormatNumberType.money,
              roundToPrecision: false)!),
        );
      case ProductFields.price:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(product!.price, context,
              formatNumberType: FormatNumberType.money,
              roundToPrecision: false)!),
        );
      case ProductFields.quantity:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(product!.quantity, context,
              formatNumberType: FormatNumberType.double)!),
        );
      case ProductFields.customValue1:
        return Text(presentCustomField(context, product!.customValue1)!);
      case ProductFields.customValue2:
        return Text(presentCustomField(context, product!.customValue2)!);
      case ProductFields.customValue3:
        return Text(presentCustomField(context, product!.customValue3)!);
      case ProductFields.customValue4:
        return Text(presentCustomField(context, product!.customValue4)!);
      case ProductFields.documents:
        return Text('${product!.documents.length}');
      case ProductFields.taxName1:
        return Text(product!.taxName1);
      case ProductFields.taxName2:
        return Text(product!.taxName2);
      case ProductFields.taxName3:
        return Text(product!.taxName3);
      case ProductFields.taxRate1:
        return Text(formatNumber(product!.taxRate1, context,
            formatNumberType: FormatNumberType.percent)!);
      case ProductFields.taxRate2:
        return Text(formatNumber(product!.taxRate2, context,
            formatNumberType: FormatNumberType.percent)!);
      case ProductFields.taxRate3:
        return Text(formatNumber(product!.taxRate3, context,
            formatNumberType: FormatNumberType.percent)!);
      case ProductFields.stockQuantity:
        return Text(formatNumber(product!.stockQuantity.toDouble(), context,
            formatNumberType: FormatNumberType.int)!);
      case ProductFields.taxCategory:
        return Text(
            localization!.lookup(kTaxCategories[product!.taxCategoryId]));
      case ProductFields.notificationThreshold:
        final store = StoreProvider.of<AppState>(context);
        return Text(formatNumber(
            productNotificationThreshold(
                    product: product!, company: store.state.company)
                .toDouble(),
            context,
            formatNumberType: FormatNumberType.int)!);
    }

    return super.getField(field: field, context: context);
  }
}
