// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/recurring_expense_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class RecurringExpensePresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      RecurringExpenseFields.status,
      RecurringExpenseFields.number,
      RecurringExpenseFields.vendor,
      RecurringExpenseFields.client,
      RecurringExpenseFields.frequency,
      RecurringExpenseFields.nextSendDate,
      RecurringExpenseFields.amount,
      RecurringExpenseFields.publicNotes,
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      RecurringExpenseFields.number,
      RecurringExpenseFields.netAmount,
      RecurringExpenseFields.taxAmount,
      RecurringExpenseFields.privateNotes,
      RecurringExpenseFields.shouldBeInvoiced,
      RecurringExpenseFields.currencyId,
      RecurringExpenseFields.category,
      RecurringExpenseFields.exchangeRate,
      RecurringExpenseFields.invoiceCurrencyId,
      RecurringExpenseFields.taxName1,
      RecurringExpenseFields.taxName2,
      RecurringExpenseFields.taxName3,
      RecurringExpenseFields.taxRate1,
      RecurringExpenseFields.taxRate2,
      RecurringExpenseFields.taxRate3,
      RecurringExpenseFields.clientId,
      RecurringExpenseFields.invoiceId,
      RecurringExpenseFields.vendorId,
      RecurringExpenseFields.customValue1,
      RecurringExpenseFields.customValue2,
      RecurringExpenseFields.customValue3,
      RecurringExpenseFields.customValue4,
      RecurringExpenseFields.documents,
      RecurringExpenseFields.remainingCycles,
      RecurringExpenseFields.lastSentDate,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final expense = entity as ExpenseEntity?;

    switch (field) {
      case RecurringExpenseFields.status:
        return EntityStatusChip(entity: expense, showState: true);
      case RecurringExpenseFields.vendor:
      case RecurringExpenseFields.vendorId:
        final vendor = state.vendorState.get(expense!.vendorId!);
        return LinkTextRelatedEntity(entity: vendor, relation: expense);
      case RecurringExpenseFields.clientId:
      case RecurringExpenseFields.client:
        final client = state.clientState.get(expense!.clientId!);
        return LinkTextRelatedEntity(entity: client, relation: expense);
      case RecurringExpenseFields.nextSendDate:
        return Text(formatDate(expense!.nextSendDate, context));
      case RecurringExpenseFields.lastSentDate:
        return Text(formatDate(expense!.lastSentDate, context));
      case RecurringExpenseFields.netAmount:
        return Text(formatNumber(expense!.netAmount, context,
            currencyId: expense.currencyId)!);
      case RecurringExpenseFields.amount:
        return Text(formatNumber(expense!.grossAmount, context,
            currencyId: expense.currencyId)!);
      case RecurringExpenseFields.convertedAmount:
        return Text(formatNumber(expense!.convertedAmount, context,
            currencyId: expense.invoiceCurrencyId)!);
      case RecurringExpenseFields.taxAmount:
        return Text(formatNumber(expense!.taxAmount, context,
            currencyId: expense.currencyId)!);
      case RecurringExpenseFields.publicNotes:
        return TableTooltip(message: expense!.publicNotes);
      case RecurringExpenseFields.number:
        return Text(expense!.number);
      case RecurringExpenseFields.privateNotes:
        return TableTooltip(message: expense!.privateNotes);
      case RecurringExpenseFields.shouldBeInvoiced:
        return Text(expense!.shouldBeInvoiced.toString());
      case RecurringExpenseFields.currencyId:
        return Text(state.staticState.currencyMap[expense!.currencyId]
                ?.listDisplayName ??
            '');
      case RecurringExpenseFields.category:
        return Text(state.expenseCategoryState.map[expense!.categoryId]
                ?.listDisplayName ??
            '');
      case RecurringExpenseFields.paymentDate:
        return Text(formatDate(expense!.paymentDate, context));
      case RecurringExpenseFields.exchangeRate:
        return Text(formatNumber(expense!.exchangeRate, context,
            formatNumberType: FormatNumberType.double)!);
      case RecurringExpenseFields.invoiceCurrencyId:
        return Text(state.staticState.currencyMap[expense!.invoiceCurrencyId]
                ?.listDisplayName ??
            '');
      case RecurringExpenseFields.taxName1:
        return Text(expense!.taxName1);
      case RecurringExpenseFields.taxName2:
        return Text(expense!.taxName2);
      case RecurringExpenseFields.taxName3:
        return Text(expense!.taxName3);
      case RecurringExpenseFields.taxRate1:
        return Text(formatNumber(expense!.taxRate1, context,
            formatNumberType: FormatNumberType.percent)!);
      case RecurringExpenseFields.taxRate2:
        return Text(formatNumber(expense!.taxRate2, context,
            formatNumberType: FormatNumberType.percent)!);
      case RecurringExpenseFields.taxRate3:
        return Text(formatNumber(expense!.taxRate3, context,
            formatNumberType: FormatNumberType.percent)!);
      case RecurringExpenseFields.invoiceId:
        return Text(
            state.invoiceState.map[expense!.invoiceId]?.listDisplayName ?? '');
      case RecurringExpenseFields.customValue1:
        return Text(presentCustomField(context, expense!.customValue1)!);
      case RecurringExpenseFields.customValue2:
        return Text(presentCustomField(context, expense!.customValue2)!);
      case RecurringExpenseFields.customValue3:
        return Text(presentCustomField(context, expense!.customValue3)!);
      case RecurringExpenseFields.customValue4:
        return Text(presentCustomField(context, expense!.customValue4)!);
      case RecurringExpenseFields.documents:
        return Text('${expense!.documents.length}');
      case RecurringExpenseFields.remainingCycles:
        return Text('${expense!.remainingCycles}');
      case RecurringExpenseFields.frequency:
        return Text(localization!.lookup(kFrequencies[expense!.frequencyId]));
    }

    return super.getField(field: field, context: context);
  }
}
