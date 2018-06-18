import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

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

// Redux classes
class AppState {
  ClientEntity client;
  AppState(this.client);

  AppState.init()
      : client = ClientEntity(
            name: 'Acme Client',
            contacts: [ContactEntity(email: 'test@example.com')]);
}

class UpdateClient {
  final String name;
  UpdateClient(this.name);
}

class AddContact {}

class UpdateContact {
  final ContactEntity oldContact;
  final ContactEntity newContact;
  UpdateContact({this.oldContact, this.newContact});
}

class DeleteContact {
  final String email;
  DeleteContact(this.email);
}

AppState reducer(AppState state, action) {
  // In an app you'd most like want to
  // use built_value to rebuild the state
  if (action is UpdateClient) {
    return AppState(ClientEntity(
      name: action.name,
      contacts: state.client.contacts,
    ));
  } else if (action is AddContact) {
    return AppState(ClientEntity(
        name: state.client.name,
        contacts: []
          ..addAll(state.client.contacts)
          ..add(ContactEntity())));
  } else if (action is DeleteContact) {
    return AppState(ClientEntity(
      name: state.client.name,
      contacts: state.client.contacts.where((contact) => contact.email != action.email).toList(),
    ));
  } else if (action is UpdateContact) {
    return AppState(ClientEntity(
      name: state.client.name,
    ));
  }

  return state;
}

void main() {
  final store =
      Store<AppState>(reducer, initialState: AppState.init(), middleware: [
    LoggingMiddleware.printer(),
  ]);

  runApp(MyApp(store: store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Client Form'),
            actions: <Widget>[
              StoreBuilder(
                  builder: (BuildContext context, Store<AppState> store) {
                return IconButton(
                  icon: Icon(Icons.cloud_upload),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    // Do something with the client...
                    print('Client name: ' + store.state.client.name);
                  },
                );
              }),
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
                ClientPage(),
                ContactsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => new _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final _nameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _nameController.removeListener(_onChanged);
    _nameController.dispose();
    super.dispose();
  }

  _onChanged() {
    var name = _nameController.text.trim();
    StoreProvider.of<AppState>(context).dispatch(UpdateClient(name));
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      _nameController.text = store.state.client.name;

      return FormCard(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
        ],
      );
    });
  }
}

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      var contacts = store.state.client.contacts
          .map((contact) => ContactForm(contact))
          .toList();

      return ListView(
        children: []
          ..addAll(contacts)
          ..add(Padding(
            padding: const EdgeInsets.all(12.0),
            child: RaisedButton(
              elevation: 4.0,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).secondaryHeaderColor,
              child: Text('ADD CONTACT'),
              onPressed: () {
                store.dispatch(AddContact());
              },
            ),
          )),
      );
    });
  }
}

class ContactForm extends StatefulWidget {
  ContactForm(this.contact);
  final ContactEntity contact;

  @override
  _ContactFormState createState() => new _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _emailController.removeListener(_onChanged);
    _emailController.dispose();
    super.dispose();
  }

  _onChanged() {
    var name = _emailController.text.trim();
    //StoreProvider.of<AppState>(context).dispatch(UpdateClient(name));
  }

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return FormCard(
      children: <Widget>[
        TextFormField(
          initialValue: widget.contact.email,
          //onSaved: (value) => _email = value.trim(),
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
                onPressed: () => store.dispatch(DeleteContact(widget.contact.email)),
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
  FormCard({this.children});
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
