// Flutter imports:
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      PaymentFields.status,
      PaymentFields.number,
      PaymentFields.client,
      PaymentFields.amount,
      PaymentFields.invoiceNumber,
      PaymentFields.date,
      PaymentFields.type,
      PaymentFields.transactionReference,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      PaymentFields.refunded,
      PaymentFields.privateNotes,
      PaymentFields.exchangeRate,
      PaymentFields.convertedAmount,
      PaymentFields.creditNumber,
      PaymentFields.customValue1,
      PaymentFields.customValue2,
      PaymentFields.customValue3,
      PaymentFields.customValue4,
      PaymentFields.gateway,
      PaymentFields.gatewayType,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final payment = entity as PaymentEntity?;

    switch (field) {
      case PaymentFields.number:
        return Text(payment!.number);
      case PaymentFields.type:
        return Text(
            state.staticState.paymentTypeMap[payment!.typeId]?.name ?? '');
      case PaymentFields.invoiceNumber:
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kTableColumnWidthMax),
          child: Wrap(
            clipBehavior: Clip.antiAlias,
            children: payment!.invoicePaymentables
                .map((paymentable) =>
                    state.invoiceState.map[paymentable.invoiceId])
                .whereNotNull()
                .map((invoice) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: LinkTextRelatedEntity(
                          entity: invoice, relation: payment),
                    ))
                .toList(),
          ),
        );
      case PaymentFields.creditNumber:
        final numbers = payment!.creditPaymentables
            .map((paymentable) =>
                state.creditState.map[paymentable.creditId]?.number ?? '')
            .toList()
            .join(', ');
        return Text(numbers);
      case PaymentFields.client:
        final client = state.clientState.get(payment!.clientId);
        return LinkTextRelatedEntity(entity: client, relation: payment);
      case PaymentFields.transactionReference:
        return Text(payment!.transactionReference);
      case PaymentFields.date:
        return Text(formatDate(payment!.date, context));
      case PaymentFields.amount:
        return Align(
            alignment: Alignment.centerRight,
            child: Text(formatNumber(
                payment!.amount - payment.refunded, context,
                clientId: payment.clientId)!));
      case PaymentFields.convertedAmount:
        return Align(
            alignment: Alignment.centerRight,
            child: Text(formatNumber(
                payment!.amount * payment.exchangeRate, context,
                currencyId: payment.exchangeCurrencyId)!));
      case PaymentFields.status:
        return EntityStatusChip(entity: payment, showState: true);
      case PaymentFields.customValue1:
        return Text(presentCustomField(context, payment!.customValue1)!);
      case PaymentFields.customValue2:
        return Text(presentCustomField(context, payment!.customValue2)!);
      case PaymentFields.customValue3:
        return Text(presentCustomField(context, payment!.customValue3)!);
      case PaymentFields.customValue4:
        return Text(presentCustomField(context, payment!.customValue4)!);
      case PaymentFields.refunded:
        return Text(formatNumber(payment!.refunded, context,
            clientId: payment.clientId)!);
      case PaymentFields.privateNotes:
        return Text(payment!.privateNotes);
      case PaymentFields.exchangeRate:
        return Text(formatNumber(payment!.exchangeRate, context,
            formatNumberType: FormatNumberType.percent)!);
      case PaymentFields.gateway:
        final companyGateway =
            state.companyGatewayState.get(payment!.companyGatewayId);
        return Text(companyGateway.label);
      case PaymentFields.gatewayType:
        return Text(
            localization!.lookup(kGatewayTypes[payment!.gatewayTypeId]));
    }

    return super.getField(field: field, context: context);
  }
}
