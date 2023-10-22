// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientEditContacts extends StatefulWidget {
  const ClientEditContacts({
    Key? key,
    required this.viewModel,
    required this.clientViewModel,
  }) : super(key: key);

  final ClientEditContactsVM viewModel;
  final ClientEditVM clientViewModel;

  @override
  _ClientEditContactsState createState() => _ClientEditContactsState();
}

class _ClientEditContactsState extends State<ClientEditContacts> {
  ClientContactEntity? selectedContact;

  void _showContactEditor(ClientContactEntity? contact, BuildContext context) {
    showDialog<ResponsivePadding>(
        context: context,
        builder: (BuildContext context) {
          final viewModel = widget.viewModel;
          final client = viewModel.client!;

          return ContactEditDetails(
            viewModel: viewModel,
            clientViewModel: widget.clientViewModel,
            key: Key(contact!.entityKey),
            contact: contact,
            isDialog: client.contacts.length > 1,
            index: client.contacts
                .indexOf(client.contacts.firstWhere((c) => c.id == contact.id)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final client = viewModel.client!;
    final state = widget.clientViewModel.state;
    final prefState = state.prefState;
    final isFullscreen = prefState.isEditorFullScreen(EntityType.client);

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
          clientViewModel: widget.clientViewModel,
          key: Key(contact.entityKey),
          contact: contact,
          isDialog: client.contacts.length > 1,
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

    final children = <Widget>[]
      ..addAll(contacts)
      ..add(Padding(
        padding: const EdgeInsets.only(
          left: 25,
          top: 0,
          right: 25,
          bottom: 6,
        ),
        child: AppButton(
          label: (client.contacts.length == 1
                  ? localization!.addSecondContact
                  : localization!.addContact)
              .toUpperCase(),
          onPressed: () => viewModel.onAddContactPressed(),
        ),
      ));

    return isFullscreen
        ? Column(
            children: children,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          )
        : ScrollableListView(
            children: children,
          );
  }
}

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    required this.contact,
    required this.onTap,
  });

  final Function onTap;
  final ClientContactEntity? contact;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: onTap as void Function()?,
                title: contact!.fullName.isNotEmpty
                    ? Text(contact!.fullName)
                    : Text(AppLocalization.of(context)!.blankContact,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        )),
                subtitle: Text(contact!.email.isNotEmpty
                    ? contact!.email
                    : contact!.phone),
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
    Key? key,
    required this.index,
    required this.contact,
    required this.viewModel,
    required this.clientViewModel,
    required this.isDialog,
  }) : super(key: key);

  final int index;
  final ClientContactEntity? contact;
  final ClientEditContactsVM viewModel;
  final ClientEditVM clientViewModel;
  final bool isDialog;

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
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  final _debouncer = Debouncer();
  List<TextEditingController> _controllers = [];
  ClientContactEntity? _contact;

  void _onDoneContactPressed() {
    if (widget.isDialog) {
      Debouncer.complete();
      widget.viewModel.onDoneContactPressed(context);
      Navigator.of(context).pop();
    } else {
      widget.clientViewModel.onSavePressed(context);
    }
  }

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
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final contact = (_contact = widget.contact)!;
    _firstNameController.text = contact.firstName;
    _lastNameController.text = contact.lastName;
    _emailController.text = contact.email;
    _phoneController.text = contact.phone;
    _passwordController.text = contact.password;
    _custom1Controller.text = contact.customValue1;
    _custom2Controller.text = contact.customValue2;
    _custom3Controller.text = contact.customValue3;
    _custom4Controller.text = contact.customValue4;

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
    final viewModel = widget.viewModel;
    final contact = _contact = widget.contact!.rebuild((b) => b
      ..firstName = _firstNameController.text.trim()
      ..lastName = _lastNameController.text.trim()
      ..email = _emailController.text.trim()
      ..password = _passwordController.text.trim()
      ..phone = _phoneController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());
    if (contact != widget.contact) {
      _debouncer.run(() {
        viewModel.onChangedContact(contact, widget.index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final company = viewModel.company!;
    final state = widget.clientViewModel.state;
    final isFullscreen = state.prefState.isEditorFullScreen(EntityType.client);

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DecoratedFormField(
          autofocus: widget.isDialog,
          controller: _firstNameController,
          validator: (String val) =>
              val.trim().isEmpty && !viewModel.client!.hasNameSet
                  ? AppLocalization.of(context)!.pleaseEnterAClientOrContactName
                  : null,
          onSavePressed: (_) => _onDoneContactPressed(),
          label: localization.firstName,
          keyboardType: TextInputType.name,
        ),
        DecoratedFormField(
          controller: _lastNameController,
          label: localization.lastName,
          validator: (String val) =>
              val.trim().isEmpty && !viewModel.client!.hasNameSet
                  ? AppLocalization.of(context)!.pleaseEnterAClientOrContactName
                  : null,
          onSavePressed: (_) => _onDoneContactPressed(),
          keyboardType: TextInputType.name,
        ),
        DecoratedFormField(
          controller: _emailController,
          label: localization.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => value.isNotEmpty && !value.contains('@')
              ? localization.emailIsInvalid
              : null,
          onSavePressed: (_) => _onDoneContactPressed(),
        ),
        company.settings.enablePortalPassword ?? false
            ? DecoratedFormField(
                autocorrect: false,
                controller: _passwordController,
                label: localization.password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => value.isNotEmpty && value.length < 8
                    ? localization.passwordIsTooShort
                    : null,
                onSavePressed: (_) => _onDoneContactPressed(),
              )
            : SizedBox(),
        DecoratedFormField(
          controller: _phoneController,
          label: localization.phone,
          keyboardType: TextInputType.phone,
          onSavePressed: (_) => _onDoneContactPressed(),
        ),
        CustomField(
          controller: _custom1Controller,
          field: CustomFieldType.contact1,
          value: widget.contact!.customValue1,
          onSavePressed: (_) => _onDoneContactPressed(),
        ),
        CustomField(
          controller: _custom2Controller,
          field: CustomFieldType.contact2,
          value: widget.contact!.customValue2,
          onSavePressed: (_) => _onDoneContactPressed(),
        ),
        CustomField(
          controller: _custom3Controller,
          field: CustomFieldType.contact3,
          value: widget.contact!.customValue3,
          onSavePressed: (_) => _onDoneContactPressed(),
        ),
        CustomField(
          controller: _custom4Controller,
          field: CustomFieldType.contact4,
          value: widget.contact!.customValue4,
          onSavePressed: (_) => _onDoneContactPressed(),
        ),
        if (widget.isDialog)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SwitchListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: Text(localization.addToInvoices),
                value: _contact!.sendEmail,
                onChanged: (value) {
                  setState(() => _contact =
                      _contact!.rebuild((b) => b..sendEmail = value));

                  viewModel.onChangedContact(
                    _contact!.rebuild((b) => b..sendEmail = value),
                    widget.index,
                  );
                }),
          ),
      ],
    );

    return widget.isDialog
        ? AlertDialog(
            content: SingleChildScrollView(child: column),
            actions: [
              TextButton(
                child: Text(localization.remove.toUpperCase()),
                onPressed: () => confirmCallback(
                    context: context,
                    callback: (_) {
                      widget.viewModel.onRemoveContactPressed(widget.index);
                      Navigator.pop(context);
                    }),
              ),
              TextButton(
                child: Text(localization.done.toUpperCase()),
                onPressed: () => _onDoneContactPressed(),
              )
            ],
          )
        : FormCard(
            child: column,
            padding: isFullscreen
                ? const EdgeInsets.only(
                    left: kMobileDialogPadding / 2,
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding / 2,
                  )
                : null);
  }
}
