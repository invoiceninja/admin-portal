// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CreditPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      CreditFields.status,
      CreditFields.number,
      CreditFields.client,
      CreditFields.amount,
      CreditFields.date,
      CreditFields.remaining,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      CreditFields.discount,
      CreditFields.validUntil,
      CreditFields.poNumber,
      CreditFields.publicNotes,
      CreditFields.privateNotes,
      CreditFields.documents,
      CreditFields.customValue1,
      CreditFields.customValue2,
      CreditFields.customValue3,
      CreditFields.customValue4,
      CreditFields.taxAmount,
      CreditFields.exchangeRate,
      CreditFields.isViewed,
      CreditFields.lastSentDate,
      CreditFields.project,
      CreditFields.vendor,
      CreditFields.contactName,
      CreditFields.contactEmail,
      CreditFields.clientState,
      CreditFields.clientCity,
      CreditFields.clientPostalCode,
      CreditFields.clientCountry,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final credit = entity as InvoiceEntity;
    final client = state.clientState.get(credit.clientId);

    switch (field) {
      case CreditFields.status:
        return EntityStatusChip(entity: credit);
      case CreditFields.number:
        return Text((credit.number ?? '').isEmpty
            ? localization.pending
            : credit.number);
      case CreditFields.client:
        return Text((state.clientState.map[credit.clientId] ??
                ClientEntity(id: credit.clientId))
            .listDisplayName);
      case CreditFields.date:
        return Text(formatDate(credit.date, context));
      case CreditFields.lastSentDate:
        return Text(formatDate(credit.lastSentDate, context));
      case CreditFields.validUntil:
        return Text(formatDate(credit.dueDate, context));
      case CreditFields.amount:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
              formatNumber(credit.amount, context, clientId: credit.clientId)),
        );
      case CreditFields.remaining:
      case CreditFields.balance:
        return Align(
            alignment: Alignment.centerRight,
            child: Text(formatNumber(credit.balanceOrAmount, context,
                clientId: credit.clientId)));
      case CreditFields.customValue1:
        return Text(presentCustomField(context, credit.customValue1));
      case CreditFields.customValue2:
        return Text(presentCustomField(context, credit.customValue2));
      case CreditFields.customValue3:
        return Text(presentCustomField(context, credit.customValue3));
      case CreditFields.customValue4:
        return Text(presentCustomField(context, credit.customValue4));
      case CreditFields.publicNotes:
        return Text(credit.publicNotes);
      case CreditFields.privateNotes:
        return Text(credit.privateNotes);
      case CreditFields.discount:
        return Text(credit.isAmountDiscount
            ? formatNumber(credit.discount, context,
                formatNumberType: FormatNumberType.money,
                clientId: credit.clientId)
            : formatNumber(credit.discount, context,
                formatNumberType: FormatNumberType.percent));
      case CreditFields.poNumber:
        return Text(credit.poNumber);
      case CreditFields.documents:
        return Text('${credit.documents.length}');
      case CreditFields.taxAmount:
        return Text(
            formatNumber(credit.taxAmount, context, clientId: credit.clientId));
      case CreditFields.exchangeRate:
        return Text(formatNumber(credit.exchangeRate, context,
            formatNumberType: FormatNumberType.double));
      case CreditFields.isViewed:
        return Text(credit.isViewed ? localization.yes : localization.no);
      case CreditFields.project:
        return Text(state.projectState.get(credit.projectId).listDisplayName);
      case CreditFields.vendor:
        return Text(state.vendorState.get(credit.vendorId).name);
      case CreditFields.clientState:
        return Text(client.state);
      case CreditFields.clientCity:
        return Text(client.city);
      case CreditFields.clientPostalCode:
        return Text(client.postalCode);
      case CreditFields.clientCountry:
        return Text(state.staticState.countryMap[client.countryId]?.name ?? '');
      case CreditFields.contactName:
      case CreditFields.contactEmail:
        final contact = creditContactSelector(
            credit, state.clientState.get(credit.clientId));
        if (field == CreditFields.contactName) {
          return Text(contact?.fullName ?? '');
        } else {
          return Text(contact?.email ?? '');
        }
    }

    return super.getField(field: field, context: context);
  }
}
