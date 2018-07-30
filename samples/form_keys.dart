// https://hillelcoren.com/2018/06/12/flutter-complex-forms-with-multiple-tabs-and-relationships/

import 'package:flutter/material.dart';

// Sample entity classes
class ClientEntity {
  ClientEntity({this.name, this.contacts});
  String name;
  List<ContactEntity> contacts;
}

class ContactEntity {
  ContactEntity({this.email});
  String email;
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<ClientPageState> _clientKey =
      GlobalKey<ClientPageState>();
  static final GlobalKey<ContactsPageState> _contactsKey =
      GlobalKey<ContactsPageState>();

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create a test client to show initially
    final ClientEntity _client = ClientEntity(
        name: 'Acme Client',
        contacts: [ContactEntity(email: 'test@example.com')]);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Client Form'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }

                _formKey.currentState.save();

                final clientState = _clientKey.currentState;
                final contactsState = _contactsKey.currentState;

                // If the user never views a tab the state can be null
                // in which case we'll use the current value
                final ClientEntity client = ClientEntity(
                  name: clientState?.name ?? _client.name,
                  contacts: contactsState?.getContacts() ?? _client.contacts,
                );

                // Do something with the client...
                print('Client name: ${client.name}');
              },
            )
          ],
          bottom: TabBar(
            controller: _controller,
            tabs: [
              Tab(
                text: 'Details',
              ),
              Tab(
                text: 'Contacts',
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              ClientPage(client: _client, key: _clientKey),
              ContactsPage(client: _client, key: _contactsKey),
            ],
          ),
        ),
      ),
    );
  }
}

// Display the client's details, currently just their name
class ClientPage extends StatefulWidget {
  const ClientPage({
    Key key,
    @required this.client,
  }) : super(key: key);

  final ClientEntity client;

  @override
  ClientPageState createState() => ClientPageState();
}

class ClientPageState extends State<ClientPage>
    with AutomaticKeepAliveClientMixin {
  ClientPageState({this.client});
  final ClientEntity client;

  @override
  bool get wantKeepAlive => true;

  String name;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      children: <Widget>[
        TextFormField(
          initialValue: widget.client.name,
          onSaved: (value) => name = value.trim(),
          decoration: InputDecoration(
            labelText: 'Name',
          ),
        ),
      ],
    );
  }
}

// Displays the list of contacts with a button to add more
class ContactsPage extends StatefulWidget {
  const ContactsPage({
    Key key,
    @required this.client,
  }) : super(key: key);

  final ClientEntity client;

  @override
  ContactsPageState createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<ContactEntity> _contacts;
  List<GlobalKey<ContactFormState>> _contactKeys;

  @override
  void initState() {
    super.initState();
    final client = widget.client;
    _contacts = client.contacts.toList();
    _contactKeys = client.contacts
        .map((contact) => GlobalKey<ContactFormState>())
        .toList();
  }

  List<ContactEntity> getContacts() {
    final List<ContactEntity> contacts = [];
    _contactKeys.forEach((contactKey) {
      contacts.add(contactKey.currentState.getContact());
    });
    return contacts;
  }

  void _onAddPressed() {
    setState(() {
      _contacts.add(ContactEntity());
      _contactKeys.add(GlobalKey<ContactFormState>());
    });
  }

  void _onRemovePressed(GlobalKey<ContactFormState> key) {
    setState(() {
      final index = _contactKeys.indexOf(key);
      _contactKeys.removeAt(index);
      _contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];

    for (var i = 0; i < _contacts.length; i++) {
      final contact = _contacts[i];
      final contactKey = _contactKeys[i];
      items.add(ContactForm(
        contact: contact,
        key: contactKey,
        onRemovePressed: (key) => _onRemovePressed(key),
      ));
    }

    items.add(Padding(
      padding: const EdgeInsets.all(14.0),
      child: RaisedButton(
        elevation: 4.0,
        textColor: Theme.of(context).secondaryHeaderColor,
        child: Text('ADD CONTACT'),
        onPressed: _onAddPressed,
      ),
    ));

    return ListView(
      children: items,
    );
  }
}

// Displays an individual contact 
class ContactForm extends StatefulWidget {
  const ContactForm({
    Key key,
    @required this.contact,
    @required this.onRemovePressed,
  }) : super(key: key);

  final ContactEntity contact;
  final Function(GlobalKey<ContactFormState>) onRemovePressed;

  @override
  ContactFormState createState() => ContactFormState();
}

class ContactFormState extends State<ContactForm> {
  String _email;

  ContactEntity getContact() {
    return ContactEntity(email: _email);
  }

  @override
  Widget build(BuildContext context) {
    return FormCard(
      children: <Widget>[
        TextFormField(
          initialValue: widget.contact.email,
          onSaved: (value) => _email = value.trim(),
          decoration: InputDecoration(
            labelText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: FlatButton(
                onPressed: () => widget.onRemovePressed(widget.key),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

// Helper widget to make the form look a bit nicer
class FormCard extends StatelessWidget {
  const FormCard({this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 12.0, bottom: 18.0),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
