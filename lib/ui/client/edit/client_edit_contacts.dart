import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientEditContacts extends StatefulWidget {
  const ClientEditContacts({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditContactsVM viewModel;

  @override
  _ClientEditContactsState createState() => _ClientEditContactsState();
}

class _ClientEditContactsState extends State<ClientEditContacts> {
  ContactEntity selectedContact;

  void _showContactEditor(ContactEntity contact, BuildContext context) {
    showDialog<ResponsivePadding>(
        context: context,
        builder: (BuildContext context) {
          final viewModel = widget.viewModel;
          final client = viewModel.client;

          return ResponsivePadding(
            child: ContactEditDetails(
              viewModel: viewModel,
              key: Key(contact.entityKey),
              contact: contact,
              areButtonsVisible: client.contacts.length > 1,
              index: client.contacts.indexOf(
                  client.contacts.firstWhere((c) => c.id == contact.id)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final client = viewModel.client;

    List<Widget> contacts;

    if (client.contacts.length > 1) {
      contacts = client.contacts
          .map((contact) => ContactListTile(
                contact: contact,
                onTap: () => _showContactEditor(contact, context),
              ))
          .toList();
    } else {
      final contact = client.contacts[0];
      contacts = [
        ContactEditDetails(
          viewModel: viewModel,
          key: Key(contact.entityKey),
          contact: contact,
          areButtonsVisible: client.contacts.length > 1,
          index: client.contacts.indexOf(contact),
        ),
      ];
    }

    final contact =
        client.contacts.contains(viewModel.contact) ? viewModel.contact : null;

    if (contact != null && contact != selectedContact) {
      selectedContact = contact;
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        _showContactEditor(contact, context);
      });
    }

    return ListView(
      children: []
        ..addAll(contacts)
        ..add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            label: localization.addContact.toUpperCase(),
            onPressed: () => viewModel.onAddContactPressed(),
          ),
        )),
    );
  }
}

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    @required this.contact,
    @required this.onTap,
  });

  final Function onTap;
  final ContactEntity contact;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: onTap,
                title: contact.fullName.isNotEmpty
                    ? Text(contact.fullName)
                    : Text(AppLocalization.of(context).blankContact,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        )),
                subtitle: Text(
                    contact.email.isNotEmpty ? contact.email : contact.phone),
                trailing: Icon(Icons.navigate_next),
              ),
              Divider(
                height: 1.0,
              ),
            ],
          ),
        ));
  }
}

class ContactEditDetails extends StatefulWidget {
  const ContactEditDetails({
    Key key,
    @required this.index,
    @required this.contact,
    @required this.viewModel,
    @required this.areButtonsVisible,
  }) : super(key: key);

  final int index;
  final ContactEntity contact;
  final ClientEditContactsVM viewModel;
  final bool areButtonsVisible;

  @override
  ContactEditDetailsState createState() => ContactEditDetailsState();
}

class ContactEditDetailsState extends State<ContactEditDetails> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  final _debouncer = Debouncer();
  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    if (_controllers.isNotEmpty) {
      return;
    }

    _controllers = [
      _firstNameController,
      _lastNameController,
      _emailController,
      _passwordController,
      _phoneController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final contact = widget.contact;
    _firstNameController.text = contact.firstName;
    _lastNameController.text = contact.lastName;
    _emailController.text = contact.email;
    _phoneController.text = contact.phone;
    _custom1Controller.text = contact.customValue1;
    _custom2Controller.text = contact.customValue2;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    _debouncer.run(() {
      final contact = widget.contact.rebuild((b) => b
        ..firstName = _firstNameController.text.trim()
        ..lastName = _lastNameController.text.trim()
        ..email = _emailController.text.trim()
        ..password = _passwordController.text.trim()
        ..phone = _phoneController.text.trim()
        ..customValue1 = _custom1Controller.text.trim()
        ..customValue2 = _custom2Controller.text.trim());
      if (contact != widget.contact) {
        widget.viewModel.onChangedContact(contact, widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // stay clear of the keyboard
      ),
      child: SingleChildScrollView(
        child: FormCard(
          children: <Widget>[
            widget.areButtonsVisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      ElevatedButton(
                        color: Colors.red,
                        iconData: Icons.delete,
                        label: localization.remove,
                        onPressed: () => confirmCallback(
                            context: context,
                            callback: () {
                              widget.viewModel
                                  .onRemoveContactPressed(widget.index);
                              Navigator.pop(context);
                            }),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        iconData: Icons.check_circle,
                        label: localization.done,
                        onPressed: () {
                          viewModel.onDoneContactPressed();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                : Container(),
            DecoratedFormField(
              controller: _firstNameController,
              label: localization.firstName,
              validator: (String val) => !viewModel.client.hasNameSet
                  ? AppLocalization.of(context).pleaseEnterAClientOrContactName
                  : null,
            ),
            DecoratedFormField(
              controller: _lastNameController,
              label: localization.lastName,
              validator: (String val) => !viewModel.client.hasNameSet
                  ? AppLocalization.of(context).pleaseEnterAClientOrContactName
                  : null,
            ),
            DecoratedFormField(
              controller: _emailController,
              label: localization.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value.isNotEmpty && !value.contains('@')
                  ? localization.emailIsInvalid
                  : null,
            ),
            company.settings.enablePortalPassword ?? false
                ? DecoratedFormField(
                    autocorrect: false,
                    controller: _passwordController,
                    label: localization.password,
                    obscureText: true,
                    validator: (value) => value.isNotEmpty && value.length < 8
                        ? localization.passwordIsTooShort
                        : null,
                  )
                : SizedBox(),
            DecoratedFormField(
              controller: _phoneController,
              label: localization.phone,
              keyboardType: TextInputType.phone,
            ),
            CustomField(
              controller: _custom1Controller,
              field: CustomFieldType.contact1,
              value: widget.contact.customValue1,
            ),
            CustomField(
              controller: _custom2Controller,
              field: CustomFieldType.contact2,
              value: widget.contact.customValue2,
            ),
          ],
        ),
      ),
    );
  }
}
