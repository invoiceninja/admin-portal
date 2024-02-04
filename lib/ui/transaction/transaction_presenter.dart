import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class TransactionPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      TransactionFields.status,
      TransactionFields.deposit,
      TransactionFields.withdrawal,
      TransactionFields.date,
      TransactionFields.description,
      TransactionFields.invoices,
      TransactionFields.expense,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      TransactionFields.accountType,
      TransactionFields.bankAccount,
      TransactionFields.currency,
      TransactionFields.amount,
      TransactionFields.vendor,
      TransactionFields.category,
      TransactionFields.payment,
      TransactionFields.defaultCategory,
      TransactionFields.participant,
      TransactionFields.participantName,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final transaction = entity as TransactionEntity;

    switch (field) {
      case TransactionFields.status:
        return EntityStatusChip(entity: transaction, showState: true);
      case TransactionFields.date:
        return Text(formatDate(transaction.date, context));
      case TransactionFields.defaultCategory:
        return Text(transaction.category);
      case TransactionFields.amount:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(transaction.amount, context,
              currencyId: transaction.currencyId)!),
        );
      case TransactionFields.deposit:
        if (!transaction.isDeposit) {
          return SizedBox();
        }
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(transaction.amount, context,
              currencyId: transaction.currencyId)!),
        );
      case TransactionFields.withdrawal:
        if (!transaction.isWithdrawal) {
          return SizedBox();
        }
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(transaction.amount, context,
              currencyId: transaction.currencyId)!),
        );
      case TransactionFields.description:
        return Text(transaction.formattedDescription);
      case TransactionFields.participantName:
        return Text(transaction.participantName);
      case TransactionFields.participant:
        return Text(transaction.participant);
      case TransactionFields.accountType:
        final bankAccount =
            state.bankAccountState.get(transaction.bankAccountId);
        return Text(toTitleCase(bankAccount.type));
      case TransactionFields.bankAccount:
        final bankAccount =
            state.bankAccountState.get(transaction.bankAccountId);
        return LinkTextRelatedEntity(
            entity: bankAccount, relation: transaction);
      case TransactionFields.payment:
        final payment = state.paymentState.get(transaction.paymentId);
        return LinkTextRelatedEntity(entity: payment, relation: transaction);
      case TransactionFields.invoices:
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kTableColumnWidthMax),
          child: Wrap(
            clipBehavior: Clip.antiAlias,
            children: transaction.invoiceIds
                .split(',')
                .map((invoiceId) => state.invoiceState.map[invoiceId])
                .whereNotNull()
                .map((invoice) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: LinkTextRelatedEntity(
                          entity: invoice, relation: transaction),
                    ))
                .toList(),
          ),
        );
      case TransactionFields.expense:
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kTableColumnWidthMax),
          child: Wrap(
            clipBehavior: Clip.antiAlias,
            children: transaction.expenseId
                .split(',')
                .map((expenseId) => state.expenseState.map[expenseId])
                .whereNotNull()
                .map((expense) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: LinkTextRelatedEntity(
                          entity: expense, relation: transaction),
                    ))
                .toList(),
          ),
        );
      case TransactionFields.vendor:
        final vendor = state.vendorState.get(transaction.vendorId);
        return LinkTextRelatedEntity(entity: vendor, relation: transaction);
      case TransactionFields.category:
        final category = state.expenseCategoryState.get(transaction.categoryId);
        return LinkTextRelatedEntity(entity: category, relation: transaction);
    }

    return super.getField(field: field, context: context);
  }
}
