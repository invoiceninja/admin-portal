import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class QuotePresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      QuoteFields.quoteNumber,
      QuoteFields.client,
      QuoteFields.date,
      QuoteFields.amount,
      QuoteFields.balance,
      QuoteFields.validUntil,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final quote = entity as InvoiceEntity;

    switch (field) {
      case QuoteFields.quoteNumber:
        return Text(quote.number);
      case QuoteFields.client:
        return Text((state.clientState.map[quote.clientId] ??
                ClientEntity(id: quote.clientId))
            .listDisplayName);
      case QuoteFields.date:
        return Text(formatDate(quote.date, context));
      case QuoteFields.amount:
        return Text(formatNumber(quote.amount, context));
      case QuoteFields.balance:
        return Text(formatNumber(quote.balance, context));
      case QuoteFields.validUntil:
        return Text(formatDate(quote.dueDate, context));
    }

    return super.getField(field: field, context: context);
  }
}
