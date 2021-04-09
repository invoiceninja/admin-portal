import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class PaymentPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      PaymentFields.status,
      PaymentFields.number,
      PaymentFields.client,
      PaymentFields.amount,
      PaymentFields.invoiceNumber,
      PaymentFields.date,
      PaymentFields.transactionReference,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      PaymentFields.refunded,
      PaymentFields.privateNotes,
      PaymentFields.exchangeRate,
      PaymentFields.customValue1,
      PaymentFields.customValue2,
      PaymentFields.customValue3,
      PaymentFields.customValue4,
      PaymentFields.gateway,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    //final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final payment = entity as PaymentEntity;

    switch (field) {
      case PaymentFields.number:
        return Text(payment.number);
      case PaymentFields.invoiceNumber:
        final numbers = payment.paymentables
            .map((paymentable) =>
                state.invoiceState.map[paymentable.invoiceId]?.number ?? '')
            .toList()
            .join(', ');
        return Text(numbers);
      case PaymentFields.client:
        return Text(
            state.clientState.map[payment.clientId]?.listDisplayName ?? '');
      case PaymentFields.transactionReference:
        return Text(payment.transactionReference);
      case PaymentFields.date:
        return Text(formatDate(payment.date, context));
      case PaymentFields.amount:
        return Align(
            alignment: Alignment.centerRight,
            child: Text(formatNumber(payment.amount, context,
                clientId: payment.clientId)));
      case PaymentFields.status:
        return EntityStatusChip(entity: payment);
      case PaymentFields.customValue1:
        return Text(presentCustomField(payment.customValue1));
      case PaymentFields.customValue2:
        return Text(presentCustomField(payment.customValue2));
      case PaymentFields.customValue3:
        return Text(presentCustomField(payment.customValue3));
      case PaymentFields.customValue4:
        return Text(presentCustomField(payment.customValue4));
      case PaymentFields.refunded:
        return Text(formatNumber(payment.refunded, context,
            clientId: payment.clientId));
      case PaymentFields.privateNotes:
        return Text(payment.privateNotes);
      case PaymentFields.exchangeRate:
        return Text(formatNumber(payment.exchangeRate, context,
            formatNumberType: FormatNumberType.percent));
      case PaymentFields.gateway:
        final companyGateway =
            state.companyGatewayState.get(payment.companyGatewayId);
        return Text(companyGateway.label);
    }

    return super.getField(field: field, context: context);
  }
}
