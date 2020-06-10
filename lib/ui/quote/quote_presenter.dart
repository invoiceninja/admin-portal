import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/constants.dart';

class QuotePresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      QuoteFields.quoteNumber,
      QuoteFields.client,
      QuoteFields.amount,
      QuoteFields.status,
      QuoteFields.date,
      QuoteFields.validUntil,
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final quote = entity as InvoiceEntity;

    switch (field) {
      case QuoteFields.status:
        return Text(
          quote.isPastDue
              ? localization.expired
              : localization.lookup(kQuoteStatuses[quote.statusId]),
        );
      case QuoteFields.quoteNumber:
        return Text(
            (quote.number ?? '').isEmpty ? localization.pending : quote.number);
      case QuoteFields.client:
        return Text((state.clientState.map[quote.clientId] ??
                ClientEntity(id: quote.clientId))
            .listDisplayName);
      case QuoteFields.date:
        return Text(formatDate(quote.date, context));
      case QuoteFields.amount:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
              formatNumber(quote.amount, context, clientId: quote.clientId)),
        );
      case QuoteFields.validUntil:
        return Text(formatDate(quote.dueDate, context));
    }

    return super.getField(field: field, context: context);
  }
}
