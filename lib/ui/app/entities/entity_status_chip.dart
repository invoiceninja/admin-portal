import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityStatusChip extends StatelessWidget {
  const EntityStatusChip({
    @required this.entity,
    this.addGap = false,
    this.width = 105,
  });

  final BaseEntity entity;
  final bool addGap;
  final double width;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);
    String label = '';
    Color color;

    switch (entity.entityType) {
      case EntityType.payment:
        final payment = entity as PaymentEntity;
        label = kPaymentStatuses[payment.calculatedStatusId];
        color = PaymentStatusColors(state.prefState.colorThemeModel)
            .colors[payment.calculatedStatusId];
        break;
      case EntityType.invoice:
        final invoice = entity as InvoiceEntity;
        final statusId = invoice.calculatedStatusId;
        label = kInvoiceStatuses[statusId];
        color = InvoiceStatusColors(state.prefState.colorThemeModel)
            .colors[statusId];
        break;
      case EntityType.recurringInvoice:
        final invoice = entity as InvoiceEntity;
        final statusId = invoice.calculatedStatusId;
        label = kRecurringInvoiceStatuses[statusId];
        color = RecurringInvoiceStatusColors(state.prefState.colorThemeModel)
            .colors[statusId];
        break;
      case EntityType.quote:
        final quote = entity as InvoiceEntity;
        final statusId = quote.calculatedStatusId;
        label = kQuoteStatuses[statusId];
        color =
            QuoteStatusColors(state.prefState.colorThemeModel).colors[statusId];
        break;
      case EntityType.credit:
        final credit = entity as InvoiceEntity;
        label = kCreditStatuses[credit.statusId];
        color = CreditStatusColors(state.prefState.colorThemeModel)
            .colors[credit.statusId];
        break;
      case EntityType.expense:
        final expense = entity as ExpenseEntity;
        final category = state.expenseCategoryState.get(expense.categoryId);
        label = kExpenseStatuses[expense.statusId];
        color = category.color.isNotEmpty
            ? convertHexStringToColor(category.color)
            : ExpenseStatusColors(state.prefState.colorThemeModel)
                .colors[expense.statusId];
        break;
      case EntityType.task:
        final task = entity as TaskEntity;
        final status = state.taskStatusState.get(task.statusId);
        label = task.isInvoiced
            ? localization.invoiced
            : task.isRunning
                ? localization.running
                : status.name.isNotEmpty
                    ? status.name
                    : localization.logged;
        color = task.isInvoiced
            ? state.prefState.colorThemeModel.colorSuccess
            : task.isRunning
                ? state.prefState.colorThemeModel.colorInfo
                : status.color.isNotEmpty && status.color != '#fff'
                    ? convertHexStringToColor(status.color)
                    : TaskStatusColors(state.prefState.colorThemeModel)
                        .colors[task.calculateStatusId];
        break;
      default:
        print(
            'ERROR: unhandled entityType ${entity.entityType} in entity_status_chip.dart');
        return SizedBox();
        break;
    }

    label = localization.lookup(label) ?? '';

    if (label.isEmpty) {
      label = localization.logged;
    }

    return Padding(
      padding: EdgeInsets.only(left: addGap ? 16 : 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: width ?? 100,
            maxWidth: width ?? 200,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Text(
              label.toUpperCase(),
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
