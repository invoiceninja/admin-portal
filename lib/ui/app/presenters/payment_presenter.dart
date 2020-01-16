import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
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
  String getField({String field, BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final payment = entity as PaymentEntity;

    switch (field) {
      case PaymentFields.invoiceNumber:
        return payment.paymentables
            .map((paymentable) =>
                state.invoiceState.map[paymentable.invoiceId]?.number ?? '')
            .toList()
            .join(', ');
      case PaymentFields.client:
        return state.clientState.map[payment.clientId]?.listDisplayName ?? '';
      case PaymentFields.transactionReference:
        return payment.transactionReference;
      case PaymentFields.paymentDate:
        return formatDate(payment.date, context);
      case PaymentFields.amount:
        return formatNumber(payment.amount, context);
      case PaymentFields.paymentStatus:
        return AppLocalization.of(context)
            .lookup('payment_status_${payment.statusId}');
    }

    return super.getField(field: field, context: context);
  }
}
