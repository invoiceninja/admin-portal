import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ExpensePresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      ExpenseFields.status,
      ExpenseFields.vendor,
      ExpenseFields.client,
      ExpenseFields.expenseDate,
      ExpenseFields.amount,
      ExpenseFields.publicNotes,
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      ExpenseFields.number,
      ExpenseFields.netAmount,
      ExpenseFields.taxAmount,
      ExpenseFields.privateNotes,
      ExpenseFields.shouldBeInvoiced,
      ExpenseFields.transactionId,
      ExpenseFields.transactionReference,
      ExpenseFields.bankId,
      ExpenseFields.currencyId,
      ExpenseFields.categoryId,
      ExpenseFields.category,
      ExpenseFields.paymentDate,
      ExpenseFields.exchangeRate,
      ExpenseFields.invoiceCurrencyId,
      ExpenseFields.taxName1,
      ExpenseFields.taxName2,
      ExpenseFields.taxName3,
      ExpenseFields.taxRate1,
      ExpenseFields.taxRate2,
      ExpenseFields.taxRate3,
      ExpenseFields.clientId,
      ExpenseFields.invoiceId,
      ExpenseFields.vendorId,
      ExpenseFields.customValue1,
      ExpenseFields.customValue2,
      ExpenseFields.customValue3,
      ExpenseFields.customValue4,
      ExpenseFields.documents,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final expense = entity as ExpenseEntity;

    switch (field) {
      case ExpenseFields.status:
        return EntityStatusChip(entity: expense);
      case ExpenseFields.vendor:
      case ExpenseFields.vendorId:
        return Text((state.vendorState.map[expense.vendorId] ?? VendorEntity())
            .listDisplayName);
      case ExpenseFields.clientId:
      case ExpenseFields.client:
        return Text((state.clientState.map[expense.clientId] ?? ClientEntity())
            .listDisplayName);
      case ExpenseFields.expenseDate:
        return Text(formatDate(expense.date, context));
      case ExpenseFields.netAmount:
        return Text(formatNumber(expense.netAmount, context,
            currencyId: expense.currencyId));
      case ExpenseFields.amount:
        return Text(formatNumber(expense.grossAmount, context,
            currencyId: expense.currencyId));
      case ExpenseFields.taxAmount:
        return Text(formatNumber(expense.taxAmount, context,
            currencyId: expense.currencyId));
      case ExpenseFields.publicNotes:
        return Text(expense.publicNotes);
      case ExpenseFields.number:
        return Text(expense.number);
      case ExpenseFields.privateNotes:
        return Text(expense.privateNotes);
      case ExpenseFields.shouldBeInvoiced:
        return Text(expense.shouldBeInvoiced.toString());
      case ExpenseFields.transactionId:
        return Text(expense.transactionId);
      case ExpenseFields.transactionReference:
        return Text(expense.transactionReference);
      case ExpenseFields.bankId:
        return Text(expense.bankId);
      case ExpenseFields.currencyId:
        return Text(state
                .staticState.currencyMap[expense.currencyId]?.listDisplayName ??
            '');
      case ExpenseFields.category:
      case ExpenseFields.categoryId:
        return Text(state.expenseCategoryState.map[expense.categoryId]
                ?.listDisplayName ??
            '');
      case ExpenseFields.paymentDate:
        return Text(formatDate(expense.paymentDate, context));
      case ExpenseFields.exchangeRate:
        return Text(formatNumber(expense.exchangeRate, context,
            formatNumberType: FormatNumberType.double));
      case ExpenseFields.invoiceCurrencyId:
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
            formatNumberType: FormatNumberType.percent));
      case ExpenseFields.taxRate2:
        return Text(formatNumber(expense.taxRate2, context,
            formatNumberType: FormatNumberType.percent));
      case ExpenseFields.taxRate3:
        return Text(formatNumber(expense.taxRate3, context,
            formatNumberType: FormatNumberType.percent));
      case ExpenseFields.invoiceId:
        return Text(
            state.invoiceState.map[expense.invoiceId]?.listDisplayName ?? '');
      case ExpenseFields.customValue1:
        return Text(presentCustomField(expense.customValue1));
      case ExpenseFields.customValue2:
        return Text(presentCustomField(expense.customValue2));
      case ExpenseFields.customValue3:
        return Text(presentCustomField(expense.customValue3));
      case ExpenseFields.customValue4:
        return Text(presentCustomField(expense.customValue4));
      case ExpenseFields.documents:
        return Text('${expense.documents.length}');
    }

    return super.getField(field: field, context: context);
  }
}
