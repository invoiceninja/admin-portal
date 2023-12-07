// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ActivityListTile extends StatelessWidget {
  const ActivityListTile({
    Key? key,
    this.enableNavigation = true,
    required this.activity,
  }) : super(key: key);

  final ActivityEntity activity;
  final bool enableNavigation;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final user = state.userState.map[activity.userId];
    final client = state.clientState.map[activity.clientId];
    final vendor = state.vendorState.map[activity.vendorId];
    final invoice = state.invoiceState.map[activity.invoiceId];
    final quote = state.quoteState.map[activity.quoteId];
    final credit = state.creditState.map[activity.creditId];
    final recurringInvoice =
        state.recurringInvoiceState.map[activity.recurringInvoiceId];
    final payment = state.paymentState.map[activity.paymentId];
    final task = state.taskState.map[activity.taskId];
    final expense = state.expenseState.map[activity.expenseId];
    final recurringExpense =
        state.recurringExpenseState.map[activity.recurringExpenseId];
    final purchaseOrder =
        state.purchaseOrderState.map[activity.purchaseOrderId];

    String key = 'activity_${activity.activityTypeId}';
    if (activity.activityTypeId == kActivityCreatePayment) {
      key += payment!.isOnline ? '_online' : '_manual';
    }
    String? title = localization.lookup(key);
    title = activity.getDescription(
      title,
      localization.system,
      localization.recurring,
      user: user,
      client: client,
      invoice: invoice,
      quote: quote,
      payment: payment,
      task: task,
      expense: expense,
      credit: credit,
      recurringInvoice: recurringInvoice,
      recurringExpense: recurringExpense,
      vendor: vendor,
      purchaseOrder: purchaseOrder,
    );

    return ListTile(
      leading: Icon(getEntityIcon(activity.entityType)),
      title: Text(title),
      onTap: !enableNavigation
          ? null
          : () {
              switch (activity.entityType) {
                case EntityType.task:
                  viewEntityById(
                    entityId: activity.taskId,
                    entityType: EntityType.task,
                    filterEntity: client,
                  );
                  break;
                case EntityType.client:
                  viewEntityById(
                      entityId: activity.clientId,
                      entityType: EntityType.client);
                  break;
                case EntityType.invoice:
                  viewEntityById(
                    entityId: activity.invoiceId,
                    entityType: EntityType.invoice,
                    filterEntity: client,
                  );
                  break;
                case EntityType.quote:
                  viewEntityById(
                    entityId: activity.quoteId,
                    entityType: EntityType.quote,
                    filterEntity: client,
                  );
                  break;
                case EntityType.credit:
                  viewEntityById(
                    entityId: activity.creditId,
                    entityType: EntityType.credit,
                    filterEntity: client,
                  );
                  break;
                case EntityType.payment:
                  viewEntityById(
                    entityId: activity.paymentId,
                    entityType: EntityType.payment,
                    filterEntity: client,
                  );
                  break;
                case EntityType.expense:
                  viewEntityById(
                    entityId: activity.expenseId,
                    entityType: EntityType.expense,
                    filterEntity: client,
                  );
                  break;
                case EntityType.purchaseOrder:
                  viewEntityById(
                    entityId: activity.purchaseOrderId,
                    entityType: EntityType.purchaseOrder,
                    filterEntity: vendor,
                  );
                  break;
                default:
                  print(
                      'Error: entity type ${activity.entityType} not handled in activity_list_tile');
              }
            },
      trailing: enableNavigation ? Icon(Icons.navigate_next) : null,
      subtitle: Row(
        children: <Widget>[
          Flexible(
            child: Text((activity.notes.isNotEmpty
                    ? localization.lookup(activity.notes).trim() + '\n'
                    : '') +
                formatDate(
                    convertTimestampToDateString(activity.createdAt), context,
                    showTime: true, showSeconds: false) +
                ((activity.ip ?? '').isNotEmpty ? ' • ' + activity.ip! : '')),
          ),
        ],
      ),
    );
  }
}
