import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ExpensePresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      ExpenseFields.vendor,
      ExpenseFields.client,
      ExpenseFields.expenseDate,
      ExpenseFields.amount,
      ExpenseFields.publicNotes,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final expense = entity as ExpenseEntity;

    switch (field) {
      case ExpenseFields.vendor:
        return Text((state.vendorState.map[expense.vendorId] ?? VendorEntity())
            .listDisplayName);
      case ExpenseFields.client:
        return Text((state.clientState.map[expense.clientId] ?? ClientEntity())
            .listDisplayName);
      case ExpenseFields.expenseDate:
        return Text(formatDate(expense.paymentDate, context));
      case ExpenseFields.amount:
        return Text(formatNumber(expense.amount, context));
      case ExpenseFields.publicNotes:
        return Text(expense.publicNotes);
    }

    return super.getField(field: field, context: context);
  }
}
