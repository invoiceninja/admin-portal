import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class TransactionPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      TransactionFields.status,
      TransactionFields.deposit,
      TransactionFields.withdrawal,
      TransactionFields.date,
      TransactionFields.description,
      TransactionFields.category,
      TransactionFields.invoices,
      TransactionFields.expense,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      TransactionFields.bankAccount,
      TransactionFields.currency,
      TransactionFields.amount,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final transaction = entity as TransactionEntity;

    switch (field) {
      case TransactionFields.status:
        return EntityStatusChip(entity: transaction, showState: true);
      case TransactionFields.date:
        return Text(formatDate(transaction.date, context));
      case TransactionFields.amount:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(transaction.amount, context,
              currencyId: transaction.currencyId)),
        );
      case TransactionFields.deposit:
        if (!transaction.isDeposit) {
          return SizedBox();
        }
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(transaction.amount, context,
              currencyId: transaction.currencyId)),
        );
      case TransactionFields.withdrawal:
        if (!transaction.isWithdrawal) {
          return SizedBox();
        }
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(transaction.amount, context,
              currencyId: transaction.currencyId)),
        );
      case TransactionFields.category:
        return Text(toTitleCase(transaction.category.toLowerCase()));
      case TransactionFields.description:
        return Text(transaction.description);
      case TransactionFields.bankAccount:
        final bankAccount =
            state.bankAccountState.get(transaction.bankAccountId);
        return LinkTextRelatedEntity(
            entity: bankAccount, relation: transaction);
      case TransactionFields.invoices:
        final invoice = state.invoiceState.get(transaction.invoiceIds);
        return LinkTextRelatedEntity(entity: invoice, relation: transaction);
      case TransactionFields.expense:
        final expense = state.expenseState.get(transaction.expenseId);
        return LinkTextRelatedEntity(entity: expense, relation: transaction);
      case TransactionFields.currency:
        return Text(state.bankAccountState.get(transaction.bankAccountId).name);
    }

    return super.getField(field: field, context: context);
  }
}
