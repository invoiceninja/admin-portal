import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/icon_message.dart';
import 'package:invoiceninja/ui/app/two_value_header.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientOverview extends StatelessWidget {
  ClientOverview({this.client, this.state});

  final AppState state;
  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListView(
      children: <Widget>[
        TwoValueHeader(
          label1: localization.paidToDate,
          value1: formatNumber(client.paidToDate, state, clientId: client.id),
          label2: localization.balanceDue,
          value2: formatNumber(client.balance, state, clientId: client.id),
        ),
        client.privateNotes != null && client.privateNotes.isNotEmpty
            ? IconMessage(client.privateNotes)
            : Container(),
        Divider(
          height: 1.0,
        ),
        ListTile(
          title: Text(localization.invoices),
          leading: Icon(FontAwesomeIcons.filePdfO, size: 18.0),
          trailing: Icon(Icons.navigate_next),
          onTap: () {},
        ),
        Divider(
          height: 1.0,
        ),
        ListTile(
          title: Text(localization.payments),
          leading: Icon(FontAwesomeIcons.creditCard, size: 18.0),
          trailing: Icon(Icons.navigate_next),
          onTap: () {},
        ),
        Divider(
          height: 1.0,
        ),
        ListTile(
          title: Text(localization.quotes),
          leading: Icon(FontAwesomeIcons.fileAltO, size: 18.0),
          trailing: Icon(Icons.navigate_next),
          onTap: () {},
        ),
        Divider(
          height: 1.0,
        ),
        ListTile(
          title: Text(localization.projects),
          leading: Icon(FontAwesomeIcons.briefcase, size: 18.0),
          trailing: Icon(Icons.navigate_next),
          onTap: () {},
        ),
        Divider(
          height: 1.0,
        ),
        ListTile(
          title: Text(localization.tasks),
          leading: Icon(FontAwesomeIcons.clockO, size: 18.0),
          trailing: Icon(Icons.navigate_next),
          onTap: () {},
        ),
        Divider(
          height: 1.0,
        ),
        ListTile(
          title: Text(localization.expenses),
          leading: Icon(FontAwesomeIcons.fileImageO, size: 18.0),
          trailing: Icon(Icons.navigate_next),
          onTap: () {},
        ),
        Divider(
          height: 1.0,
        ),
        ListTile(
          title: Text(localization.vendors),
          leading: Icon(FontAwesomeIcons.building, size: 18.0),
          trailing: Icon(Icons.navigate_next),
          onTap: () {},
        ),
        Divider(
          height: 1.0,
        ),
      ],
    );
  }
}
