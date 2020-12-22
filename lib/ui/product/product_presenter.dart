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
        return Text(product.customValue1);
      case ProductFields.customValue2:
        return Text(product.customValue2);
      case ProductFields.customValue3:
        return Text(product.customValue3);
      case ProductFields.customValue4:
        return Text(product.customValue4);
      case ProductFields.documents:
        return Text('${product.documents.length}');
    }

    return super.getField(field: field, context: context);
  }
}
