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
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
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
              formatNumberType: FormatNumberType.money)),
        );
      case ProductFields.price:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(product.price, context,
              formatNumberType: FormatNumberType.money)),
        );
      case ProductFields.quantity:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(product.quantity, context,
              formatNumberType: FormatNumberType.double)),
        );
    }

    return super.getField(field: field, context: context);
  }
}
