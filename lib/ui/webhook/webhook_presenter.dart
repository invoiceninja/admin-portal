// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class WebhookPresenter extends EntityPresenter {
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
    //final webhook = entity as InvoiceEntity;

    switch (field) {}

    return super.getField(field: field, context: context);
  }
}
