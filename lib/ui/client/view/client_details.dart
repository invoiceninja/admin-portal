import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientDetails extends StatefulWidget {
  ClientDetails({this.client});

  final ClientEntity client;

  @override
  _ClientDetailsState createState() => new _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {

  Future<Null> _launched;

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    if (snapshot.hasError) {
      return new Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    _buildDetailsList() {
      var listTiles = <Widget>[];

      var contacts = client.contacts;
      contacts.forEach((contact) {
        if (contact.email.isNotEmpty) {
          listTiles.add(AppListTile(
            icon: Icons.email,
            title: contact.fullName() + '\n' + contact.email,
            subtitle: localization.email,
          ));
        }

        if (contact.phone.isNotEmpty) {
          listTiles.add(AppListTile(
            icon: Icons.phone,
            title: contact.fullName() + '\n' + contact.phone,
            subtitle: localization.phone,
          ));
        }
      });

      if (client.website.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.link,
          title: client.website,
          subtitle: localization.website,
          onTap: () => setState(() {
            _launched = _launchInBrowser(client.website);
          }),
        ));

        listTiles.add(FutureBuilder<Null>(future: _launched, builder: _launchStatus));
      }

      if (client.workPhone.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.phone,
          title: client.workPhone,
          subtitle: localization.phone,
        ));
      }

      listTiles.add(Divider());

      if (client.vatNumber.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.location_city,
          title: client.vatNumber,
          subtitle: localization.vatNumber,
        ));
      }

      if (client.idNumber.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.business,
          title: client.idNumber,
          subtitle: localization.idNumber,
        ));
      }

      var billingAddress = formatAddress(client);
      var shippingAddress = formatAddress(client, true);

      if (billingAddress.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.pin_drop,
          title: billingAddress,
          subtitle: localization.billingAddress,
        ));
      }

      if (shippingAddress.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.pin_drop,
          title: shippingAddress,
          subtitle: localization.shippingAddress,
        ));
      }

      return listTiles;
    }

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: ListView(
        children: _buildDetailsList(),
      ),
    );
  }
}


class AppListTile extends StatelessWidget {
  AppListTile({
    this.icon,
    this.title,
    this.subtitle,
    this.dense = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool dense;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? Container() : Text(subtitle),
      dense: dense,
      onTap: onTap,
    );
  }
}
