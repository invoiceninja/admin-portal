// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ExpensePresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      ExpenseFields.status,
      ExpenseFields.number,
      ExpenseFields.vendor,
      ExpenseFields.client,
      ExpenseFields.expenseDate,
      ExpenseFields.amount,
      ExpenseFields.publicNotes,
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      ExpenseFields.number,
      ExpenseFields.netAmount,
      ExpenseFields.taxAmount,
      ExpenseFields.privateNotes,
      ExpenseFields.shouldBeInvoiced,
      ExpenseFields.transactionReference,
      ExpenseFields.category,
      ExpenseFields.project,
      ExpenseFields.paymentDate,
      ExpenseFields.paymentType,
      ExpenseFields.exchangeRate,
      ExpenseFields.taxName1,
      ExpenseFields.taxName2,
      ExpenseFields.taxName3,
      ExpenseFields.taxRate1,
      ExpenseFields.taxRate2,
      ExpenseFields.taxRate3,
      ExpenseFields.customValue1,
      ExpenseFields.customValue2,
      ExpenseFields.customValue3,
      ExpenseFields.customValue4,
      ExpenseFields.documents,
      ExpenseFields.recurringExpense,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final expense = entity as ExpenseEntity;

    switch (field) {
      case ExpenseFields.status:
        return EntityStatusChip(entity: expense, showState: true);
      case ExpenseFields.vendor:
        final vendor = state.vendorState.get(expense.vendorId!);
        return LinkTextRelatedEntity(entity: vendor, relation: expense);
      case ExpenseFields.client:
        final client = state.clientState.get(expense.clientId!);
        return LinkTextRelatedEntity(entity: client, relation: expense);
      case ExpenseFields.expenseDate:
        return Text(formatDate(expense.date, context));
      case ExpenseFields.netAmount:
        return Text(formatNumber(expense.netAmount, context,
            currencyId: expense.currencyId)!);
      case ExpenseFields.amount:
        return Text(formatNumber(expense.grossAmount, context,
            currencyId: expense.currencyId)!);
      case ExpenseFields.convertedAmount:
        return Text(formatNumber(expense.convertedAmount, context,
            currencyId: expense.invoiceCurrencyId)!);
      case ExpenseFields.taxAmount:
        return Text(formatNumber(expense.taxAmount, context,
            currencyId: expense.currencyId)!);
      case ExpenseFields.publicNotes:
        return TableTooltip(message: expense.publicNotes);
      case ExpenseFields.number:
        return Text(expense.number);
      case ExpenseFields.privateNotes:
        return TableTooltip(message: expense.privateNotes);
      case ExpenseFields.shouldBeInvoiced:
        return Text(expense.shouldBeInvoiced.toString());
      case ExpenseFields.transactionId:
        return Text(expense.transactionId);
      case ExpenseFields.transactionReference:
        return Text(expense.transactionReference);
      case ExpenseFields.currency:
        return Text(state
                .staticState.currencyMap[expense.currencyId]?.listDisplayName ??
            '');
      case ExpenseFields.category:
        final category = state.expenseCategoryState.map[expense.categoryId];
        return LinkTextRelatedEntity(entity: category, relation: expense);
      case ExpenseFields.project:
        final project = state.projectState.map[expense.projectId];
        return LinkTextRelatedEntity(entity: project, relation: expense);
      case ExpenseFields.paymentType:
        return Text(state.staticState.paymentTypeMap[expense.paymentTypeId]
                ?.listDisplayName ??
            '');
      case ExpenseFields.paymentDate:
        return Text(formatDate(expense.paymentDate, context));
      case ExpenseFields.exchangeRate:
        return Text(formatNumber(expense.exchangeRate, context,
            formatNumberType: FormatNumberType.double)!);
      case ExpenseFields.invoiceCurrency:
        return Text(state.staticState.currencyMap[expense.invoiceCurrencyId]
                ?.listDisplayName ??
            '');
      case ExpenseFields.taxName1:
        return Text(expense.taxName1);
      case ExpenseFields.taxName2:
        return Text(expense.taxName2);
      case ExpenseFields.taxName3:
        return Text(expense.taxName3);
      case ExpenseFields.taxRate1:
        return Text(formatNumber(expense.taxRate1, context,
            formatNumberType: FormatNumberType.percent)!);
      case ExpenseFields.taxRate2:
        return Text(formatNumber(expense.taxRate2, context,
            formatNumberType: FormatNumberType.percent)!);
      case ExpenseFields.taxRate3:
        return Text(formatNumber(expense.taxRate3, context,
            formatNumberType: FormatNumberType.percent)!);
      case ExpenseFields.invoiceId:
        return Text(
            state.invoiceState.map[expense.invoiceId]?.listDisplayName ?? '');
      case ExpenseFields.customValue1:
        return Text(presentCustomField(context, expense.customValue1)!);
      case ExpenseFields.customValue2:
        return Text(presentCustomField(context, expense.customValue2)!);
      case ExpenseFields.customValue3:
        return Text(presentCustomField(context, expense.customValue3)!);
      case ExpenseFields.customValue4:
        return Text(presentCustomField(context, expense.customValue4)!);
      case ExpenseFields.documents:
        return Text('${expense.documents.length}');
      case ExpenseFields.recurringExpense:
        final recurringExpense =
            state.recurringExpenseState.get(expense.recurringExpenseId);
        return LinkTextRelatedEntity(
            entity: recurringExpense, relation: expense);
    }

    return super.getField(field: field, context: context);
  }
}
