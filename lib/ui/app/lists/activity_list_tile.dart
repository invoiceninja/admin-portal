import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

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

    final user = state.userState.map[activity.userId];
    final client = state.clientState.map[activity.clientId];
    final invoice = state.invoiceState.map[activity.invoiceId];
    final quote = state.quoteState.map[activity.quoteId];
    final payment = state.paymentState.map[activity.paymentId];
    final task = state.taskState.map[activity.taskId];
    final expense = state.expenseState.map[activity.expenseId];

    String title = localization.lookup('activity_${activity.activityTypeId}');
    title = activity.getDescription(
      title,
      user: user,
      client: client,
      invoice: invoice,
      quote: quote,
      payment: payment,
      task: task,
      expense: expense,
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
                    appContext: context.getAppContext(),
                    entityId: activity.taskId,
                    entityType: EntityType.task,
                    filterEntity: client,
                  );
                  break;
                case EntityType.client:
                  viewEntityById(
                      appContext: context.getAppContext(),
                      entityId: activity.clientId,
                      entityType: EntityType.client);
                  break;
                case EntityType.invoice:
                  viewEntityById(
                    appContext: context.getAppContext(),
                    entityId: activity.invoiceId,
                    entityType: EntityType.invoice,
                    filterEntity: client,
                  );
                  break;
                case EntityType.quote:
                  viewEntityById(
                    appContext: context.getAppContext(),
                    entityId: activity.quoteId,
                    entityType: EntityType.quote,
                    filterEntity: client,
                  );
                  break;
                case EntityType.credit:
                  viewEntityById(
                    appContext: context.getAppContext(),
                    entityId: activity.creditId,
                    entityType: EntityType.credit,
                    filterEntity: client,
                  );
                  break;
                case EntityType.payment:
                  viewEntityById(
                    appContext: context.getAppContext(),
                    entityId: activity.paymentId,
                    entityType: EntityType.payment,
                    filterEntity: client,
                  );
                  break;
                case EntityType.expense:
                  viewEntityById(
                    appContext: context.getAppContext(),
                    entityId: activity.expenseId,
                    entityType: EntityType.expense,
                    filterEntity: client,
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
