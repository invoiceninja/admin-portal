import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class QuotePresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      QuoteFields.quoteNumber,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final quote = entity as QuoteEntity;

    switch (field) {
      case QuoteFields.quoteNumber:
        return quote.invoiceNumber;
    }

    return super.getField(field: field, context: context);
  }
}
