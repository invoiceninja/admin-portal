// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Package imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/portal_links.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/lists/app_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ClientViewDetails extends StatefulWidget {
  const ClientViewDetails({this.client});

  final ClientEntity? client;

  @override
  _ClientViewDetailsState createState() => _ClientViewDetailsState();
}

class _ClientViewDetailsState extends State<ClientViewDetails> {
  Future<Null>? _launched;

  Future<Null> _launchURL(BuildContext context, String url) async {
    await launchUrl(Uri.parse(url));
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    final localization = AppLocalization.of(context);
    if (snapshot.hasError) {
      return Text('${localization!.error}: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.company;
    final client = widget.client;

    List<Widget> _buildDetailsList() {
      final listTiles = <Widget>[];
      final contacts = client!.contacts;

      contacts.forEach((contact) {
        final subtitleParts = <String>[];
        if (contact.email.isNotEmpty) {
          subtitleParts.add(contact.email);
        }
        if (company.hasCustomField(CustomFieldType.contact1) &&
            contact.customValue1.isNotEmpty) {
          subtitleParts.add(company.formatCustomFieldValue(
              CustomFieldType.contact1, contact.customValue1));
        }
        if (company.hasCustomField(CustomFieldType.contact2) &&
            contact.customValue2.isNotEmpty) {
          subtitleParts.add(company.formatCustomFieldValue(
              CustomFieldType.contact2, contact.customValue2));
        }
        if (company.hasCustomField(CustomFieldType.contact3) &&
            contact.customValue3.isNotEmpty) {
          subtitleParts.add(company.formatCustomFieldValue(
              CustomFieldType.contact3, contact.customValue3));
        }
        if (company.hasCustomField(CustomFieldType.contact4) &&
            contact.customValue4.isNotEmpty) {
          subtitleParts.add(company.formatCustomFieldValue(
              CustomFieldType.contact4, contact.customValue4));
        }

        listTiles.add(AppListTile(
          buttonRow: PortalLinks(
            viewLink: contact.silentLink,
            copyLink: contact.link,
            client: client,
          ),
          icon: Icons.email,
          title: contact.fullName.isEmpty
              ? localization!.blankContact
              : contact.fullName,
          subtitle: subtitleParts.join('\n'),
          copyValue: contact.email,
          onLongPress: () => setState(() {
            if (contact.email.isEmpty) {
              return;
            }

            _launched = _launchURL(context, 'mailto:' + contact.email);
          }),
        ));

        if (contact.phone.isNotEmpty) {
          listTiles.add(AppListTile(
            icon: Icons.phone,
            title: (contact.fullName.isEmpty
                    ? localization!.blankContact
                    : contact.fullName) +
                '\n' +
                contact.phone,
            copyValue: contact.phone,
            subtitle: localization!.phone,
            /*
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
                */
            onLongPress: () => setState(() {
              _launched =
                  _launchURL(context, 'sms:' + cleanPhoneNumber(contact.phone));
              //_launched = _launchURL('tel:' + cleanPhoneNumber(contact.phone));
            }),
          ));
        }
      });

      if (client.website.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.link,
          title: client.website,
          subtitle: localization!.website,
          onLongPress: () => setState(() {
            _launched = _launchURL(context, formatURL(client.website));
          }),
        ));
      }

      if (client.phone.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.phone,
          title: client.phone,
          subtitle: localization!.phone,
          /*
          trailing: isApple() || isAndroid()
              ? IconButton(
                  onPressed: () async {
                    final dialer = await DirectDialer.instance;
                    if (isAndroid()) {
                      await dialer.dial(client.phone);
                    } else {
                      await dialer.dialFaceTime(client.phone, false);
                    }
                  },
                  icon: Icon(MdiIcons.dialpad))
              : null,
              */
          onLongPress: () => setState(() {
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

      if (client.vatNumber.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.location_city,
          title: client.vatNumber,
          subtitle: localization!.vatNumber,
        ));
      }

      if (client.idNumber.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.business,
          title: client.idNumber,
          subtitle: localization!.idNumber,
        ));
      }

      final store = StoreProvider.of<AppState>(context);
      final state = store.state;
      final billingAddress = formatAddress(state, object: client);
      final shippingAddress =
          formatAddress(state, object: client, isShipping: true);

      if (billingAddress.isNotEmpty) {
        listTiles.add(AppListTile(
            icon: Icons.pin_drop,
            title: billingAddress,
            subtitle: localization!.billingAddress,
            onLongPress: () {
              _launched = _launchURL(
                  context,
                  getMapURL(context) +
                      Uri.encodeFull(formatAddress(state,
                          object: client, delimiter: ',')));
            }));
      }

      if (shippingAddress.isNotEmpty) {
        listTiles.add(AppListTile(
            icon: Icons.pin_drop,
            title: shippingAddress,
            subtitle: localization!.shippingAddress,
            onLongPress: () {
              _launched = _launchURL(
                  context,
                  getMapURL(context) +
                      Uri.encodeFull(formatAddress(state,
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
