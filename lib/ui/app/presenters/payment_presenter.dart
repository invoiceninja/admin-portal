import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class PaymentPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      PaymentFields.amount,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final payment = entity as PaymentEntity;

    switch (field) {
      case PaymentFields.amount:
        return formatNumber(payment.amount, context);
    }

    return super.getField(field: field, context: context);
  }
}
