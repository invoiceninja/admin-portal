import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/keyboard_aware_padding.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditContacts extends StatefulWidget {
  ClientEditContacts({
    Key key,
    @required this.client,
  }) : super(key: key);

  final ClientEntity client;

  @override
  ClientEditContactsState createState() => new ClientEditContactsState();
}

class ClientEditContactsState extends State<ClientEditContacts>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    return KeyboardAwarePadding(
      child: ListView(
          children: client.contacts
              .map((contact) => ContactSettings(contact))
              .toList()),
    );

    return KeyboardAwarePadding(
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
              children: client.contacts
                  .map((contact) => ContactSettings(contact))
                  .toList()),
        ),
      ),
    );
  }
}

class ContactSettings extends StatelessWidget {
  ContactSettings(this.contact);
  ContactEntity contact;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              initialValue: contact.firstName,
              decoration: InputDecoration(
                labelText: localization.website,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
