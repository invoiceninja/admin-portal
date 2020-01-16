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
      QuoteFields.quoteDate,
      QuoteFields.amount,
      QuoteFields.balance,
      QuoteFields.dueDate,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final quote = entity as InvoiceEntity;

    switch (field) {
      case InvoiceFields.invoiceNumber:
        return quote.number;
      case InvoiceFields.client:
        return (state.clientState.map[quote.clientId] ??
                ClientEntity(id: quote.clientId))
            .listDisplayName;
      case InvoiceFields.invoiceDate:
        return formatDate(quote.date, context);
      case InvoiceFields.amount:
        return formatNumber(quote.amount, context);
      case InvoiceFields.balance:
        return formatNumber(quote.balance, context);
      case InvoiceFields.dueDate:
        return formatDate(quote.dueDate, context);
    }

    return super.getField(field: field, context: context);
  }
}
