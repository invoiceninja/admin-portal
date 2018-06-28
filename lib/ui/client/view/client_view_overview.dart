import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/icon_message.dart';
import 'package:invoiceninja/ui/app/two_value_header.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientOverview extends StatelessWidget {
  ClientOverview({this.client});

  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return ListView(
      children: <Widget>[
        TwoValueHeader(
          label1: localization.paidToDate,
          //value1: client.paidToDate,
          label2: localization.balanceDue,
          //value2: client.balance,
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
