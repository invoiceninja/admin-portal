import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/lists/app_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientViewDetails extends StatefulWidget {
  const ClientViewDetails({this.client});

  final ClientEntity client;

  @override
  _ClientViewDetailsState createState() => _ClientViewDetailsState();
}

class _ClientViewDetailsState extends State<ClientViewDetails> {
  Future<Null> _launched;

  Future<Null> _launchURL(BuildContext context, String url) async {
    final localization = AppLocalization.of(context);
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw '${localization.couldNotLaunch}';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    final localization = AppLocalization.of(context);
    if (snapshot.hasError) {
      return Text('${localization.error}: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final client = widget.client;

    List<Widget> _buildDetailsList() {
      final listTiles = <Widget>[];
      final contacts = client.contacts;

      contacts.forEach((contact) {
        listTiles.add(AppListTile(
          buttons: [
            Expanded(
                child: OutlineButton(
              child: Text(localization.viewPortal.toUpperCase()),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () {
                launch('${contact.silentLink}&client_hash=${client.clientHash}',
                    forceWebView: false, forceSafariVC: false);
              },
            )),
            SizedBox(width: kTableColumnGap),
            Expanded(
                child: OutlineButton(
              child: Text(localization.copyLink.toUpperCase()),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: contact.link));
                showToast(
                    localization.copiedToClipboard.replaceFirst(':value ', ''));
              },
            )),
          ],
          icon: Icons.email,
          title: contact.fullName.isEmpty
              ? localization.blankContact
              : contact.fullName,
          subtitle: contact.email,
          copyValue: contact.email,
          onTap: () => setState(() {
            if ((contact.email ?? '').isEmpty) {
              return;
            }

            _launched = _launchURL(context, 'mailto:' + contact.email);
          }),
        ));

        if ((contact.phone ?? '').isNotEmpty) {
          listTiles.add(AppListTile(
            icon: Icons.phone,
            title: (contact.fullName.isEmpty
                    ? localization.blankContact
                    : contact.fullName) +
                '\n' +
                contact.phone,
            copyValue: contact.phone,
            subtitle: localization.phone,
            onTap: () => setState(() {
              _launched =
                  _launchURL(context, 'sms:' + cleanPhoneNumber(contact.phone));
              //_launched = _launchURL('tel:' + cleanPhoneNumber(contact.phone));
            }),
          ));
        }
      });

      if ((client.website ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.link,
          title: client.website,
          subtitle: localization.website,
          onTap: () => setState(() {
            _launched = _launchURL(context, formatURL(client.website));
          }),
        ));
      }

      if ((client.phone ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.phone,
          title: client.phone,
          subtitle: localization.phone,
          onTap: () => setState(() {
            _launched =
                _launchURL(context, 'sms:' + cleanPhoneNumber(client.phone));
            //_launched = _launchURL('tel:' + cleanPhoneNumber(client.workPhone));
          }),
        ));
      }

      /*
      if (listTiles.isNotEmpty) {
        listTiles.add(
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        );
      }
      */

      if ((client.vatNumber ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.location_city,
          title: client.vatNumber,
          subtitle: localization.vatNumber,
        ));
      }

      if ((client.idNumber ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.business,
          title: client.idNumber,
          subtitle: localization.idNumber,
        ));
      }

      final billingAddress = formatAddress(object: client);
      final shippingAddress = formatAddress(object: client, isShipping: true);

      if (billingAddress.isNotEmpty) {
        listTiles.add(AppListTile(
            icon: Icons.pin_drop,
            title: billingAddress,
            subtitle: localization.billingAddress,
            onTap: () {
              _launched = _launchURL(
                  context,
                  getMapURL(context) +
                      Uri.encodeFull(
                          formatAddress(object: client, delimiter: ',')));
            }));
      }

      if (shippingAddress.isNotEmpty) {
        listTiles.add(AppListTile(
            icon: Icons.pin_drop,
            title: shippingAddress,
            subtitle: localization.shippingAddress,
            onTap: () {
              _launched = _launchURL(
                  context,
                  getMapURL(context) +
                      Uri.encodeFull(formatAddress(
                          object: client, delimiter: ',', isShipping: true)));
            }));
      }

      listTiles.add(Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<Null>(future: _launched, builder: _launchStatus),
      ));

      return listTiles;
    }

    return ScrollableListView(
      children: _buildDetailsList(),
    );
  }
}
