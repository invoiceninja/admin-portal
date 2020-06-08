import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ActivityListTile extends StatelessWidget {
  const ActivityListTile({
    Key key,
    this.enableNavigation = true,
    @required this.activity,
  }) : super(key: key);

  final ActivityEntity activity;
  final bool enableNavigation;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    String title = localization.lookup('activity_${activity.activityTypeId}');
    title = activity.getDescription(
      title,
      user: state.userState.map[activity.userId],
      client: state.clientState.map[activity.clientId],
      invoice: state.invoiceState.map[activity.invoiceId],
      quote: state.quoteState.map[activity.invoiceId],
      payment: state.paymentState.map[activity.paymentId],
      task: state.taskState.map[activity.taskId],
      expense: state.expenseState.map[activity.expenseId],
    );

    return ListTile(
      leading: Icon(getEntityIcon(activity.entityType)),
      title: Text(title),
      onTap: !enableNavigation
          ? null
          : () {
              print('## ON TAP: ${activity.entityType} - ${activity.invoiceId}');
              switch (activity.entityType) {
                case EntityType.task:
                  viewEntityById(
                      context: context,
                      entityId: activity.taskId,
                      entityType: EntityType.task);
                  break;
                case EntityType.client:
                  viewEntityById(
                      context: context,
                      entityId: activity.clientId,
                      entityType: EntityType.client);
                  break;
                case EntityType.invoice:
                  viewEntityById(
                      context: context,
                      entityId: activity.invoiceId,
                      entityType: EntityType.invoice);
                  break;
                case EntityType.quote:
                  viewEntityById(
                      context: context,
                      entityId: activity.invoiceId,
                      entityType: EntityType.quote);
                  break;
                case EntityType.credit:
                  viewEntityById(
                      context: context,
                      entityId: activity.creditId,
                      entityType: EntityType.credit);
                  break;
                case EntityType.payment:
                  viewEntityById(
                      context: context,
                      entityId: activity.paymentId,
                      entityType: EntityType.payment);
                  break;
                case EntityType.expense:
                  viewEntityById(
                      context: context,
                      entityId: activity.expenseId,
                      entityType: EntityType.expense);
                  break;
              }
            },
      trailing: enableNavigation ? Icon(Icons.navigate_next) : null,
      subtitle: Row(
        children: <Widget>[
          Text(formatDate(
              convertTimestampToDateString(activity.updatedAt), context,
              showTime: true)),
          (activity.notes ?? '').isNotEmpty
              ? Text(' • ${localization.lookup(activity.notes)}')
              : Container(),
        ],
      ),
    );
  }
}
