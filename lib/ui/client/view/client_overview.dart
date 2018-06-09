import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientOverview extends StatelessWidget {

  ClientOverview({this.client});

  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    _headerRow() {
      return Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(localization.paidToDate,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,)
                  ),
                  SizedBox(height: 6.0,),
                  Text(
                    client.paidToDate.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(localization.balanceDue,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,)
                  ),
                  SizedBox(height: 6.0,),
                  Text(
                    client.balance.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
          client.privateNotes != null && client.privateNotes.isNotEmpty
              ? Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Row(
              children: <Widget>[
                Text(
                  client.privateNotes,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                )
              ],
            ),
          )
              : null
        ],
      );
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: _headerRow(),
            ),
          ),
        ),
        Divider(
          height: 1.0,
        ),
        Container(
          color: Colors.white,
          child: Material(
            type: MaterialType.transparency,
            child: ListTile(
              title: Text(localization.invoices),
              leading: Icon(FontAwesomeIcons.filePdfO, size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () {},
            ),
          ),
        ),
        Divider(
          height: 1.0,
        ),
        Container(
          color: Colors.white,
          child: Material(
            type: MaterialType.transparency,
            child: ListTile(
              title: Text(localization.payments),
              leading: Icon(FontAwesomeIcons.creditCard, size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () {},
            ),
          ),
        ),
        Divider(
          height: 1.0,
        ),
      ],
    );
  }
}
