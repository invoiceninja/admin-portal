import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
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
  List<ContactEntity> contacts;
  List<GlobalKey<ContactEditDetailsState>> contactKeys;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    var client = widget.client;
    contacts = client.contacts.toList();
    contactKeys = client.contacts
        .map((contact) => GlobalKey<ContactEditDetailsState>())
        .toList();

    // Add initial blank contact
    _onAddPressed();
  }

  List<ContactEntity> getContacts() {
    List<ContactEntity> contacts = [];
    contactKeys.forEach((contactKey) {
      contacts.add(contactKey.currentState.getContact());
    });
    return contacts;
  }

  _onAddPressed() {
    print('onAddPressed..');
    setState(() {
      contacts.add(ContactEntity());
      contactKeys.add(GlobalKey<ContactEditDetailsState>());
    });
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    List<Widget> items = [];

    for (var i=0; i<contacts.length; i++) {
      var contact = contacts[i];
      var contactKey = contactKeys[i];
      items.add(ContactEditDetails(
         contact: contact,         
         key: contactKey,
      ));
    }

    items.add(RaisedButton(
        elevation: 4.0,
        child: Text(localization.add),
        onPressed: _onAddPressed,
      ));

    return ListView(
      children: items,
    );
  }
}

class ContactEditDetails extends StatefulWidget {
  ContactEditDetails({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final ContactEntity contact;

  @override
  ContactEditDetailsState createState() => ContactEditDetailsState();
}

class ContactEditDetailsState extends State<ContactEditDetails> {
  String _firstName;

  ContactEntity getContact() {
    return ContactEntity((b) => b..firstName = _firstName);
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 12.0, bottom: 18.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                initialValue: widget.contact.firstName,
                onSaved: (value) => _firstName = value.trim(),
                decoration: InputDecoration(
                  labelText: localization.firstName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
