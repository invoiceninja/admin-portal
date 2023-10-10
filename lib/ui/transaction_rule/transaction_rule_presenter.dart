import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class TransactionRulePresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    //final state = StoreProvider.of<AppState>(context).state;
    //final transactionRule = entity as TransactionRuleEntity;

    switch (field) {}

    return super.getField(field: field, context: context);
  }
}
