import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      PaymentFields.paymentNumber,
      PaymentFields.paymentStatus,
      PaymentFields.invoiceNumber,
      PaymentFields.client,
      PaymentFields.transactionReference,
      PaymentFields.amount,
      PaymentFields.paymentDate,
      PaymentFields.paymentStatus,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final payment = entity as PaymentEntity;

    switch (field) {
      case PaymentFields.paymentNumber:
        return Text(payment.number);
      case PaymentFields.paymentStatus:
        return Text(localization.lookup('payment_status_${payment.statusId}'),
            style: TextStyle(
              color: PaymentStatusColors.colors[payment.statusId],
            ));
      case PaymentFields.invoiceNumber:
        return Text(payment.paymentables
            .map((paymentable) =>
                state.invoiceState.map[paymentable.invoiceId]?.number ?? '')
            .toList()
            .join(', '));
      case PaymentFields.client:
        return Text(
            state.clientState.map[payment.clientId]?.listDisplayName ?? '');
      case PaymentFields.transactionReference:
        return Text(payment.transactionReference);
      case PaymentFields.paymentDate:
        return Text(formatDate(payment.date, context));
      case PaymentFields.amount:
        return Text(formatNumber(payment.amount, context));
      case PaymentFields.paymentStatus:
        return Text(AppLocalization.of(context)
            .lookup('payment_status_${payment.statusId}'));
    }

    return super.getField(field: field, context: context);
  }
}
