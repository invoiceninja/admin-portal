import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ActivityListTile extends StatelessWidget {
  const ActivityListTile({
    Key key,
    @required this.activity,
  }) : super(key: key);

  final ActivityEntity activity;

  IconData getIconData(EntityType entityType) {
    switch (entityType) {
      case EntityType.client:
        return FontAwesomeIcons.users;
      case EntityType.invoice:
        return FontAwesomeIcons.filePdfO;
      case EntityType.payment:
        return FontAwesomeIcons.creditCard;
      case EntityType.credit:
        return FontAwesomeIcons.creditCard;
      case EntityType.quote:
        return FontAwesomeIcons.fileAltO;
      case EntityType.vendor:
        return FontAwesomeIcons.building;
      case EntityType.expense:
        return FontAwesomeIcons.fileImageO;
      case EntityType.task:
        return FontAwesomeIcons.clockO;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    String title = localization.lookup('activity_${activity.activityTypeId}');
    title = activity.getDescription(
      title,
      user: state.selectedCompany.userMap[activity.userId],
      client: state.clientState.map[activity.clientId],
      invoice: state.invoiceState.map[activity.invoiceId],
    );

    return ListTile(
      leading: Icon(getIconData(activity.entityType)),
      title: Text(title),
      onTap: () {
        switch (activity.entityType) {
          case EntityType.client:
            store.dispatch(
                ViewClient(clientId: activity.clientId, context: context));
            break;
          case EntityType.invoice:
            store.dispatch(
                ViewInvoice(invoiceId: activity.invoiceId, context: context));
            break;
        }
      },
      trailing: Icon(Icons.navigate_next),
      subtitle: Row(
        children: <Widget>[
          Text(formatDate(
              convertTimestampToSqlDate(activity.updatedAt), context,
              showTime: true)),
          SizedBox(width: 10.0),
          (activity.isSystem ?? false) ? Icon(FontAwesomeIcons.server) : Container(),
        ],
      ),
    );
  }
}
