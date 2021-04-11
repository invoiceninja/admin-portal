import 'package:flutter/cupertino.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ProductPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    final company = userCompany.company;

    return [
      ProductFields.productKey,
      ProductFields.notes,
      if (company.enableProductCost) ProductFields.cost,
      ProductFields.price,
      if (company.enableProductQuantity) ProductFields.quantity,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
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
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final product = entity as ProductEntity;

    switch (field) {
      case ProductFields.productKey:
        return Text(product.productKey);
      case ProductFields.notes:
        return Text(product.notes);
      case ProductFields.cost:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(product.cost, context,
              formatNumberType: FormatNumberType.money,
              roundToPrecision: false)),
        );
      case ProductFields.price:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(product.price, context,
              formatNumberType: FormatNumberType.money,
              roundToPrecision: false)),
        );
      case ProductFields.quantity:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(product.quantity, context,
              formatNumberType: FormatNumberType.double)),
        );
      case ProductFields.customValue1:
        return Text(presentCustomField(product.customValue1));
      case ProductFields.customValue2:
        return Text(presentCustomField(product.customValue2));
      case ProductFields.customValue3:
        return Text(presentCustomField(product.customValue3));
      case ProductFields.customValue4:
        return Text(presentCustomField(product.customValue4));
      case ProductFields.documents:
        return Text('${product.documents.length}');
      case ProductFields.taxName1:
        return Text(product.taxName1);
      case ProductFields.taxName2:
        return Text(product.taxName2);
      case ProductFields.taxName3:
        return Text(product.taxName3);
      case ProductFields.taxRate1:
        return Text(formatNumber(product.taxRate1, context,
            formatNumberType: FormatNumberType.percent));
      case ProductFields.taxRate2:
        return Text(formatNumber(product.taxRate2, context,
            formatNumberType: FormatNumberType.percent));
      case ProductFields.taxRate3:
        return Text(formatNumber(product.taxRate3, context,
            formatNumberType: FormatNumberType.percent));
    }

    return super.getField(field: field, context: context);
  }
}
