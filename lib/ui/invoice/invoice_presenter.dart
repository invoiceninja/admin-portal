import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final invoice = entity as InvoiceEntity;

    switch (field) {
      case InvoiceFields.status:
        return EntityStatusChip(entity: invoice);
      case InvoiceFields.number:
        return Text((invoice.number ?? '').isEmpty
            ? localization.pending
            : invoice.number);
      case InvoiceFields.client:
        return Text((state.clientState.map[invoice.clientId] ??
                ClientEntity(id: invoice.clientId))
            .listDisplayName);
      case InvoiceFields.date:
        return Text(formatDate(invoice.date, context));
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
        return Text(presentCustomField(invoice.customValue1));
      case InvoiceFields.customValue2:
        return Text(presentCustomField(invoice.customValue2));
      case InvoiceFields.customValue3:
        return Text(presentCustomField(invoice.customValue3));
      case InvoiceFields.customValue4:
        return Text(presentCustomField(invoice.customValue4));
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
    }

    return super.getField(field: field, context: context);
  }
}
