import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

import '../../app/form_card.dart';

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
  }

  List<ContactEntity> getContacts() {
    List<ContactEntity> contacts = [];
    contactKeys.forEach((contactKey) {
      if (contactKey.currentState != null) {
        contacts.add(contactKey.currentState.getContact());
      }
    });
    return contacts;
  }

  _onAddPressed() {
    setState(() {
      contacts.add(ContactEntity());
      contactKeys.add(GlobalKey<ContactEditDetailsState>());
    });
  }

  _onRemovePressed(GlobalKey<ContactEditDetailsState> key) {
    setState(() {
      var index = contactKeys.indexOf(key);
      contactKeys.removeAt(index);
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    List<Widget> items = [];

    for (var i = 0; i < contacts.length; i++) {
      var contact = contacts[i];
      var contactKey = contactKeys[i];
      items.add(ContactEditDetails(
        contact: contact,
        key: contactKey,
        onRemovePressed: (key) => _onRemovePressed(key),
      ));
    }

    items.add(Padding(
      padding: const EdgeInsets.all(16.0),
      child: RaisedButton(
        elevation: 4.0,
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).secondaryHeaderColor,
        child: Text(localization.addContact.toUpperCase()),
        onPressed: _onAddPressed,
      ),
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
    @required this.onRemovePressed,
  }) : super(key: key);

  final ContactEntity contact;
  final Function(GlobalKey<ContactEditDetailsState>) onRemovePressed;

  @override
  ContactEditDetailsState createState() => ContactEditDetailsState();
}

class ContactEditDetailsState extends State<ContactEditDetails> {
  String _firstName;
  String _lastName;
  String _email;
  String _phone;

  ContactEntity getContact() {
    return widget.contact.rebuild((b) => b
      ..firstName = _firstName
      ..lastName = _lastName
      ..email = _email
      ..phone = _phone);
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    _confirmDelete() {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              semanticLabel: localization.areYouSure,
              title: Text(localization.areYouSure),
              actions: <Widget>[
                new FlatButton(
                    child: Text(localization.cancel.toUpperCase()),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new FlatButton(
                    child: Text(localization.ok.toUpperCase()),
                    onPressed: () {
                      widget.onRemovePressed(widget.key);
                      Navigator.pop(context);
                    })
              ],
            ),
      );
    }

    return FormCard(
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              initialValue: widget.contact.firstName,
              onSaved: (value) => _firstName = value.trim(),
              decoration: InputDecoration(
                labelText: localization.firstName,
              ),
            ),
            TextFormField(
              autocorrect: false,
              initialValue: widget.contact.lastName,
              onSaved: (value) => _lastName = value.trim(),
              decoration: InputDecoration(
                labelText: localization.lastName,
              ),
            ),
            TextFormField(
              autocorrect: false,
              initialValue: widget.contact.email,
              onSaved: (value) => _email = value.trim(),
              decoration: InputDecoration(
                labelText: localization.email,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              autocorrect: false,
              initialValue: widget.contact.phone,
              onSaved: (value) => _phone = value.trim(),
              decoration: InputDecoration(
                labelText: localization.phone,
              ),
              keyboardType: TextInputType.phone,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: FlatButton(
                    child: Text(
                      localization.remove,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    onPressed: _confirmDelete,
                  ),
                )
              ],
            ),
          ],
        );
  }
}
