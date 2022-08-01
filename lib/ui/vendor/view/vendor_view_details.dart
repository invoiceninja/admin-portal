// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:direct_dialer/direct_dialer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/lists/app_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class VendorViewDetails extends StatefulWidget {
  const VendorViewDetails({this.vendor});

  final VendorEntity vendor;

  @override
  _VendorViewDetailsState createState() => _VendorViewDetailsState();
}

class _VendorViewDetailsState extends State<VendorViewDetails> {
  Future<Null> _launched;

  Future<Null> _launchURL(BuildContext context, String url) async {
    await launchUrl(Uri.parse(url));
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
            onLongPress: () => setState(() {
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
            trailing: isApple() || isAndroid()
                ? IconButton(
                    onPressed: () async {
                      final dialer = await DirectDialer.instance;
                      if (isAndroid()) {
                        await dialer.dial(contact.phone);
                      } else {
                        await dialer.dialFaceTime(contact.phone, false);
                      }
                    },
                    icon: Icon(MdiIcons.dialpad))
                : null,
            onLongPress: () => setState(() {
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
          onLongPress: () => setState(() {
            _launched = _launchURL(context, formatURL(vendor.website));
          }),
        ));
      }

      if ((vendor.phone ?? '').isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.phone,
          title: vendor.phone,
          subtitle: localization.phone,
          trailing: isApple() || isAndroid()
              ? IconButton(
                  onPressed: () async {
                    final dialer = await DirectDialer.instance;
                    if (isAndroid()) {
                      await dialer.dial(vendor.phone);
                    } else {
                      await dialer.dialFaceTime(vendor.phone, false);
                    }
                  },
                  icon: Icon(MdiIcons.dialpad))
              : null,
          onLongPress: () => setState(() {
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

      final store = StoreProvider.of<AppState>(context);
      final state = store.state;
      final address = formatAddress(state, object: vendor);

      if (address.isNotEmpty) {
        listTiles.add(AppListTile(
            icon: Icons.pin_drop,
            title: address,
            subtitle: localization.billingAddress,
            onLongPress: () {
              _launched = _launchURL(
                  context,
                  getMapURL(context) +
                      Uri.encodeFull(formatAddress(state,
                          object: vendor, delimiter: ',')));
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
