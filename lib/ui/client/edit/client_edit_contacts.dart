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
  
  Map<ContactEntity, GlobalKey<ContactEditDetailsState>> contactKeys;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    contactKeys = Map.fromIterable(widget.client.contacts,
     key: (contact) => contact,
     value: (contact) => GlobalKey<ContactEditDetailsState>(),
    );
  }

  List<ContactEntity> getContacts() {
    List<ContactEntity> contacts = [];
    contactKeys.forEach((contact, contactKey) {
      contacts.add(contactKey.currentState.getContact());
    });
    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    return ListView(
        children: client.contacts.map((contact) {
      return ContactEditDetails(
        contact: contact,
        key: contactKeys[contact],
      );
    }).toList());
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
    return ContactEntity((b) => b
      ..firstName = _firstName);
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
