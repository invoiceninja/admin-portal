import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class DesignPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    //final state = StoreProvider.of<AppState>(context).state;
    //final design = entity as InvoiceEntity;

    switch (field) {
      //
    }

    return super.getField(field: field, context: context);
  }
}
