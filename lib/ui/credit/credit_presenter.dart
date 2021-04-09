import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
      CreditFields.balance,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      CreditFields.discount,
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
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final credit = entity as InvoiceEntity;

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
      case CreditFields.amount:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
              formatNumber(credit.amount, context, clientId: credit.clientId)),
        );
      case CreditFields.balance:
        return Align(
            alignment: Alignment.centerRight,
            child: Text(formatNumber(credit.balance, context)));
      case CreditFields.customValue1:
        return Text(presentCustomField(credit.customValue1));
      case CreditFields.customValue2:
        return Text(presentCustomField(credit.customValue2));
      case CreditFields.customValue3:
        return Text(presentCustomField(credit.customValue3));
      case CreditFields.customValue4:
        return Text(presentCustomField(credit.customValue4));
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
    }

    return super.getField(field: field, context: context);
  }
}
