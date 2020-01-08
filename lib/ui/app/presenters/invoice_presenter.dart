import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class InvoicePresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      InvoiceFields.invoiceNumber,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final invoice = entity as InvoiceEntity;

    switch (field) {
      case InvoiceFields.invoiceNumber:
        return invoice.number;
    }

    return super.getField(field: field, context: context);
  }
}
