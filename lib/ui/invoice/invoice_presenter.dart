// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoicePresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      InvoiceFields.status,
      InvoiceFields.number,
      InvoiceFields.client,
      InvoiceFields.amount,
      InvoiceFields.balance,
      InvoiceFields.date,
      InvoiceFields.dueDate,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      InvoiceFields.discount,
      InvoiceFields.poNumber,
      InvoiceFields.publicNotes,
      InvoiceFields.privateNotes,
      InvoiceFields.documents,
      InvoiceFields.customValue1,
      InvoiceFields.customValue2,
      InvoiceFields.customValue3,
      InvoiceFields.customValue4,
      InvoiceFields.taxAmount,
      InvoiceFields.reminder1Sent,
      InvoiceFields.reminder2Sent,
      InvoiceFields.reminder3Sent,
      InvoiceFields.reminderLastSent,
      InvoiceFields.exchangeRate,
      InvoiceFields.isViewed,
      InvoiceFields.autoBillEnabled,
      InvoiceFields.lastSentDate,
      InvoiceFields.nextSendDate,
      InvoiceFields.project,
      InvoiceFields.vendor,
      InvoiceFields.contactName,
      InvoiceFields.contactEmail,
      InvoiceFields.clientState,
      InvoiceFields.clientCity,
      InvoiceFields.clientPostalCode,
      InvoiceFields.clientCountry,
      InvoiceFields.partial,
      InvoiceFields.partialDueDate,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final invoice = entity as InvoiceEntity;
    final client = state.clientState.get(invoice.clientId);

    switch (field) {
      case InvoiceFields.status:
        return EntityStatusChip(entity: invoice, showState: true);
      case InvoiceFields.number:
        return Text((invoice.number ?? '').isEmpty
            ? localization.pending
            : invoice.number);
      case InvoiceFields.client:
        return Text((state.clientState.map[invoice.clientId] ??
                ClientEntity(id: invoice.clientId))
            .listDisplayName);
      case InvoiceFields.project:
        return Text(state.projectState.get(invoice.projectId).listDisplayName);
      case InvoiceFields.vendor:
        return Text(state.vendorState.get(invoice.vendorId).name);
      case InvoiceFields.date:
        return Text(formatDate(invoice.date, context));
      case InvoiceFields.lastSentDate:
        return Text(formatDate(invoice.lastSentDate, context));
      case InvoiceFields.nextSendDate:
        return Text(formatDate(invoice.nextSendDate, context));
      case InvoiceFields.reminder1Sent:
        return Text(formatDate(invoice.reminder1Sent, context));
      case InvoiceFields.reminder2Sent:
        return Text(formatDate(invoice.reminder2Sent, context));
      case InvoiceFields.reminder3Sent:
        return Text(formatDate(invoice.reminder3Sent, context));
      case InvoiceFields.reminderLastSent:
        return Text(formatDate(invoice.reminderLastSent, context));
      case InvoiceFields.amount:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(invoice.amount, context,
              clientId: invoice.clientId)),
        );
      case InvoiceFields.balance:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(invoice.balanceOrAmount, context,
              clientId: invoice.clientId)),
        );
      case InvoiceFields.dueDate:
        return Text(formatDate(invoice.dueDate, context));
      case InvoiceFields.customValue1:
        return Text(presentCustomField(context, invoice.customValue1));
      case InvoiceFields.customValue2:
        return Text(presentCustomField(context, invoice.customValue2));
      case InvoiceFields.customValue3:
        return Text(presentCustomField(context, invoice.customValue3));
      case InvoiceFields.customValue4:
        return Text(presentCustomField(context, invoice.customValue4));
      case InvoiceFields.publicNotes:
        return Text(invoice.publicNotes);
      case InvoiceFields.privateNotes:
        return Text(invoice.privateNotes);
      case InvoiceFields.discount:
        return Text(invoice.isAmountDiscount
            ? formatNumber(invoice.discount, context,
                formatNumberType: FormatNumberType.money,
                clientId: invoice.clientId)
            : formatNumber(invoice.discount, context,
                formatNumberType: FormatNumberType.percent));
      case InvoiceFields.poNumber:
        return Text(invoice.poNumber);
      case InvoiceFields.documents:
        return Text('${invoice.documents.length}');
      case InvoiceFields.taxAmount:
        return Text(formatNumber(invoice.taxAmount, context,
            clientId: invoice.clientId));
      case InvoiceFields.exchangeRate:
        return Text(formatNumber(invoice.exchangeRate, context,
            formatNumberType: FormatNumberType.double));
      case InvoiceFields.isViewed:
        return Text(invoice.isViewed ? localization.yes : localization.no);
      case InvoiceFields.autoBillEnabled:
        return Text(localization.lookup(
            invoice.autoBillEnabled ? localization.yes : localization.no));
      case InvoiceFields.clientState:
        return Text(client.state);
      case InvoiceFields.clientCity:
        return Text(client.city);
      case InvoiceFields.clientPostalCode:
        return Text(client.postalCode);
      case InvoiceFields.clientCountry:
        return Text(state.staticState.countryMap[client.countryId]?.name ?? '');
      case InvoiceFields.contactName:
      case InvoiceFields.contactEmail:
        final contact = invoiceContactSelector(
            invoice, state.clientState.get(invoice.clientId));
        if (field == InvoiceFields.contactName) {
          return Text(contact?.fullName ?? '');
        }
        return CopyToClipboard(
          value: contact?.email ?? '',
          showBorder: true,
        );
      case InvoiceFields.partial:
        return Text(formatNumber(invoice.partial, context));
      case InvoiceFields.partialDueDate:
        return Text(formatDate(invoice.partialDueDate, context));
    }

    return super.getField(field: field, context: context);
  }
}
