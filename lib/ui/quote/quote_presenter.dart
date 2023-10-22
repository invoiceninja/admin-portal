// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class QuotePresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      QuoteFields.status,
      QuoteFields.number,
      QuoteFields.client,
      QuoteFields.amount,
      QuoteFields.date,
      QuoteFields.validUntil,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
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
      QuoteFields.lastSentDate,
      QuoteFields.project,
      QuoteFields.vendor,
      QuoteFields.contactName,
      QuoteFields.contactEmail,
      QuoteFields.clientState,
      QuoteFields.clientCity,
      QuoteFields.clientPostalCode,
      QuoteFields.clientCountry,
      QuoteFields.partial,
      QuoteFields.partialDueDate,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final quote = entity as InvoiceEntity;
    final client = state.clientState.get(quote.clientId);

    switch (field) {
      case QuoteFields.status:
        return EntityStatusChip(entity: quote, showState: true);
      case QuoteFields.number:
        return Text(
            quote.number.isEmpty ? localization!.pending : quote.number);
      case QuoteFields.client:
        return LinkTextRelatedEntity(entity: client, relation: quote);
      case QuoteFields.date:
        return Text(formatDate(quote.date, context));
      case QuoteFields.lastSentDate:
        return Text(formatDate(quote.lastSentDate, context));
      case QuoteFields.amount:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
              formatNumber(quote.amount, context, clientId: quote.clientId)!),
        );
      case QuoteFields.validUntil:
        return Text(formatDate(quote.dueDate, context));
      case QuoteFields.customValue1:
        return Text(presentCustomField(context, quote.customValue1)!);
      case QuoteFields.customValue2:
        return Text(presentCustomField(context, quote.customValue2)!);
      case QuoteFields.customValue3:
        return Text(presentCustomField(context, quote.customValue3)!);
      case QuoteFields.customValue4:
        return Text(presentCustomField(context, quote.customValue4)!);
      case QuoteFields.publicNotes:
        return TableTooltip(message: quote.publicNotes);
      case QuoteFields.privateNotes:
        return TableTooltip(message: quote.privateNotes);
      case QuoteFields.discount:
        return Text(quote.isAmountDiscount
            ? formatNumber(quote.discount, context,
                formatNumberType: FormatNumberType.money,
                clientId: quote.clientId)!
            : formatNumber(quote.discount, context,
                formatNumberType: FormatNumberType.percent)!);
      case QuoteFields.poNumber:
        return Text(quote.poNumber);
      case QuoteFields.documents:
        return Text('${quote.documents.length}');
      case QuoteFields.taxAmount:
        return Text(
            formatNumber(quote.taxAmount, context, clientId: quote.clientId)!);
      case QuoteFields.exchangeRate:
        return Text(formatNumber(quote.exchangeRate, context,
            formatNumberType: FormatNumberType.double)!);
      case QuoteFields.isViewed:
        return Text(quote.isViewed ? localization!.yes : localization!.no);
      case QuoteFields.project:
        final project = state.projectState.get(quote.projectId);
        return LinkTextRelatedEntity(entity: project, relation: quote);
      case QuoteFields.vendor:
        final vendor = state.vendorState.get(quote.vendorId);
        return LinkTextRelatedEntity(entity: vendor, relation: quote);
      case QuoteFields.clientState:
        return Text(client.state);
      case QuoteFields.clientCity:
        return Text(client.city);
      case QuoteFields.clientPostalCode:
        return Text(client.postalCode);
      case QuoteFields.clientCountry:
        return Text(state.staticState.countryMap[client.countryId]?.name ?? '');
      case QuoteFields.contactName:
      case QuoteFields.contactEmail:
        final contact =
            quoteContactSelector(quote, state.clientState.get(quote.clientId));
        if (contact == null) {
          return SizedBox();
        }
        if (field == QuoteFields.contactName) {
          return Text(contact.fullName);
        }
        return CopyToClipboard(
          value: contact.email,
          showBorder: true,
          onLongPress: () => launchUrl(Uri.parse('mailto:${contact.email}')),
        );
      case QuoteFields.partial:
        return Text(formatNumber(quote.partial, context)!);
      case QuoteFields.partialDueDate:
        return Text(formatDate(quote.partialDueDate, context));
    }

    return super.getField(field: field, context: context);
  }
}
