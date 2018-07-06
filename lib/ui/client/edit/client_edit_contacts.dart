import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/ui/app/forms/custom_field.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditContacts extends StatelessWidget {
  const ClientEditContacts({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final client = viewModel.client;
    final contacts = client.contacts.map((contact) => ContactEditDetails(
        viewModel: viewModel,
        key: Key('__${EntityType.contact}_${contact.id}__'),
        isRemoveVisible: client.contacts.length > 1,
        contact: contact,
        index: client.contacts.indexOf(contact)));

    return ListView(
      children: []
        ..addAll(contacts)
        ..add(Padding(
          padding: const EdgeInsets.all(14.0),
          child: RaisedButton(
            elevation: 4.0,
            color: Theme.of(context).primaryColorDark,
            textColor: Theme.of(context).secondaryHeaderColor,
            child: Text(localization.addContact.toUpperCase()),
            onPressed: viewModel.onAddContactPressed,
          ),
        )),
    );
  }
}

class ContactEditDetails extends StatefulWidget {
  const ContactEditDetails({
    Key key,
    @required this.index,
    @required this.contact,
    @required this.viewModel,
    @required this.isRemoveVisible,
  }) : super(key: key);

  final int index;
  final ContactEntity contact;
  final ClientEditVM viewModel;
  final bool isRemoveVisible;

  @override
  ContactEditDetailsState createState() => ContactEditDetailsState();
}

class ContactEditDetailsState extends State<ContactEditDetails> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _firstNameController,
      _lastNameController,
      _emailController,
      _phoneController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers.forEach((dynamic controller) => controller.removeListener(_onChanged));

    final contact = widget.contact;
    _firstNameController.text = contact.firstName;
    _lastNameController.text = contact.lastName;
    _emailController.text = contact.email;
    _phoneController.text = contact.phone;
    _custom1Controller.text = contact.customValue1;
    _custom2Controller.text = contact.customValue2;

    _controllers.forEach((dynamic controller) => controller.addListener(_onChanged));

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
    final contact = widget.contact.rebuild((b) => b
      ..firstName = _firstNameController.text.trim()
      ..lastName = _lastNameController.text.trim()
      ..email = _emailController.text.trim()
      ..phone = _phoneController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
    );
    if (contact != widget.contact) {
      widget.viewModel.onChangedContact(contact, widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    void _confirmDelete() {
      showDialog<AlertDialog>(
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
                      widget.viewModel.onRemoveContactPressed(widget.index);
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
          controller: _firstNameController,
          decoration: InputDecoration(
            labelText: localization.firstName,
          ),
          validator: (String val) => ! viewModel.client.hasNameSet
              ? AppLocalization.of(context).pleaseEnterAClientOrContactName
              : null,
        ),
        TextFormField(
          autocorrect: false,
          controller: _lastNameController,
          decoration: InputDecoration(
            labelText: localization.lastName,
          ),
          validator: (String val) => ! viewModel.client.hasNameSet
              ? AppLocalization.of(context).pleaseEnterAClientOrContactName
              : null,
        ),
        TextFormField(
          autocorrect: false,
          controller: _emailController,
          decoration: InputDecoration(
            labelText: localization.email,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) => value.isNotEmpty && !value.contains('@')
              ? localization.emailIsInvalid
              : null,
        ),
        TextFormField(
          autocorrect: false,
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: localization.phone,
          ),
          keyboardType: TextInputType.phone,
        ),
        CustomField(
          controller: _custom1Controller,
          labelText: company.getCustomFieldLabel(CustomFieldType.contact1),
          options: company.getCustomFieldValues(CustomFieldType.contact1),
        ),
        CustomField(
          controller: _custom2Controller,
          labelText: company.getCustomFieldLabel(CustomFieldType.contact2),
          options: company.getCustomFieldValues(CustomFieldType.contact2),
        ),
        widget.isRemoveVisible
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
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
              )
            : Container(),
      ],
    );
  }
}
