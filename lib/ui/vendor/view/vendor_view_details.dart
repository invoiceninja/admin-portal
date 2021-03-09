import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/lists/app_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorViewDetails extends StatefulWidget {
  const VendorViewDetails({this.vendor});

  final VendorEntity vendor;

  @override
  _VendorViewDetailsState createState() => _VendorViewDetailsState();
}

class _VendorViewDetailsState extends State<VendorViewDetails> {
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
    final vendor = widget.vendor;

    List<Widget> _buildDetailsList() {
      final listTiles = <Widget>[];
      final contacts = vendor.contacts;

      contacts.forEach((contact) {
        if ((contact.email ?? '').isNotEmpty) {
          listTiles.add(AppListTile(
            icon: Icons.email,
            title: contact.fullName + '\n' + contact.email,
            copyValue: contact.email,
            subtitle: localization.email,
            onTap: () => setState(() {
              _launched = _launchURL(context, 'mailto:' + contact.email);
            }),
          ));
        }

        if ((contact.phone ?? '').isNotEmpty) {
          listTiles.add(AppListTile(
            icon: Icons.phone,
            title: contact.fullName + '\n' + contact.phone,
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

      if ((vendor.website ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.link,
          title: vendor.website,
          subtitle: localization.website,
          onTap: () => setState(() {
            _launched = _launchURL(context, formatURL(vendor.website));
          }),
        ));
      }

      if ((vendor.phone ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.phone,
          title: vendor.phone,
          subtitle: localization.phone,
          onTap: () => setState(() {
            _launched =
                _launchURL(context, 'sms:' + cleanPhoneNumber(vendor.phone));
            //_launched = _launchURL('tel:' + cleanPhoneNumber(vendor.workPhone));
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

      if ((vendor.vatNumber ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.location_city,
          title: vendor.vatNumber,
          subtitle: localization.vatNumber,
        ));
      }

      if ((vendor.idNumber ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.business,
          title: vendor.idNumber,
          subtitle: localization.idNumber,
        ));
      }

      final address = formatAddress(object: vendor);

      if (address.isNotEmpty) {
        listTiles.add(AppListTile(
            icon: Icons.pin_drop,
            title: address,
            subtitle: localization.billingAddress,
            onTap: () {
              _launched = _launchURL(
                  context,
                  getMapURL(context) +
                      Uri.encodeFull(
                          formatAddress(object: vendor, delimiter: ',')));
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
