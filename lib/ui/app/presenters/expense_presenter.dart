import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ExpensePresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      ExpenseFields.amount,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final expense = entity as ExpenseEntity;

    switch (field) {
      case ExpenseFields.amount:
        return formatNumber(expense.amount, context);
    }

    return super.getField(field: field, context: context);
  }
}
