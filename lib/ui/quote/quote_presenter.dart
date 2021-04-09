import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class QuotePresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      QuoteFields.status,
      QuoteFields.number,
      QuoteFields.client,
      QuoteFields.amount,
      QuoteFields.date,
      QuoteFields.validUntil,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      QuoteFields.discount,
      QuoteFields.poNumber,
      QuoteFields.publicNotes,
      QuoteFields.privateNotes,
      QuoteFields.documents,
      QuoteFields.customValue1,
      QuoteFields.customValue2,
      QuoteFields.customValue3,
      QuoteFields.customValue4,
      QuoteFields.taxAmount,
      QuoteFields.exchangeRate,
      QuoteFields.isViewed,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final quote = entity as InvoiceEntity;

    switch (field) {
      case QuoteFields.status:
        return EntityStatusChip(entity: quote);
      case QuoteFields.number:
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
      case QuoteFields.customValue1:
        return Text(presentCustomField(quote.customValue1));
      case QuoteFields.customValue2:
        return Text(presentCustomField(quote.customValue2));
      case QuoteFields.customValue3:
        return Text(presentCustomField(quote.customValue3));
      case QuoteFields.customValue4:
        return Text(presentCustomField(quote.customValue4));
      case QuoteFields.publicNotes:
        return Text(quote.publicNotes);
      case QuoteFields.privateNotes:
        return Text(quote.privateNotes);
      case QuoteFields.discount:
        return Text(quote.isAmountDiscount
            ? formatNumber(quote.discount, context,
                formatNumberType: FormatNumberType.money,
                clientId: quote.clientId)
            : formatNumber(quote.discount, context,
                formatNumberType: FormatNumberType.percent));
      case QuoteFields.poNumber:
        return Text(quote.poNumber);
      case QuoteFields.documents:
        return Text('${quote.documents.length}');
      case QuoteFields.taxAmount:
        return Text(
            formatNumber(quote.taxAmount, context, clientId: quote.clientId));
      case QuoteFields.exchangeRate:
        return Text(formatNumber(quote.exchangeRate, context,
            formatNumberType: FormatNumberType.double));
      case QuoteFields.isViewed:
        return Text(quote.isViewed ? localization.yes : localization.no);
    }

    return super.getField(field: field, context: context);
  }
}
