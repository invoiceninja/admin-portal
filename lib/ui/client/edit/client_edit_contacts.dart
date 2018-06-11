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
  _ClientEditContactsState createState() => new _ClientEditContactsState();
}

class _ClientEditContactsState extends State<ClientEditContacts> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    return KeyboardAwarePadding(
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: client.contacts.map((contact) => ContactSettings(contact)).toList()
          ),
        ),
      ),
    );
  }
}


class ContactSettings extends StatelessWidget {

  static final GlobalKey<FormFieldState<String>> firstNameKey =
  GlobalKey<FormFieldState<String>>();

  ContactSettings(this.contact);
  ContactEntity contact;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return TextFormField(
                autocorrect: false,
                key: ContactSettings.firstNameKey,
                initialValue: contact.firstName,
                decoration: InputDecoration(
                  labelText: localization.website,
                ),
              );

    return Card(
      child: Column(
        children: <Widget>[
               TextFormField(
                autocorrect: false,
                key: ContactSettings.firstNameKey,
                initialValue: contact.firstName,
                decoration: InputDecoration(
                  labelText: localization.website,
                ),
              ),
       ],
      ),
    );
  }
}