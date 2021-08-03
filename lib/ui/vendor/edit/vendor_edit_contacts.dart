import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/contacts.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:contacts_service/contacts_service.dart';

class VendorEditContacts extends StatefulWidget {
  const VendorEditContacts({
    Key key,
    @required this.viewModel,
    @required this.vendorViewModel,
  }) : super(key: key);

  final VendorEditContactsVM viewModel;
  final VendorEditVM vendorViewModel;

  @override
  _VendorEditContactsState createState() => _VendorEditContactsState();
}

class _VendorEditContactsState extends State<VendorEditContacts> {
  VendorContactEntity selectedContact;

  void _showContactEditor(VendorContactEntity contact, BuildContext context) {
    showDialog<VendorContactEditDetails>(
        context: context,
        builder: (BuildContext context) {
          final viewModel = widget.viewModel;
          final vendor = viewModel.vendor;

          return VendorContactEditDetails(
            viewModel: viewModel,
            vendorViewModel: widget.vendorViewModel,
            key: Key(contact.entityKey),
            contact: contact,
            isDialog: vendor.contacts.length > 1,
            index: vendor.contacts
                .indexOf(vendor.contacts.firstWhere((c) => c.id == contact.id)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final vendor = viewModel.vendor;
    final state = widget.vendorViewModel.state;
    final prefState = state.prefState;
    final isFullscreen = prefState.isEditorFullScreen(EntityType.vendor);

    List<Widget> contacts;

    if (vendor.contacts.length > 1) {
      contacts = vendor.contacts
          .map((contact) => ContactListTile(
                contact: contact,
                onTap: () => _showContactEditor(contact, context),
              ))
          .toList();
    } else {
      final contact = vendor.contacts[0];
      contacts = [
        VendorContactEditDetails(
          viewModel: viewModel,
          vendorViewModel: widget.vendorViewModel,
          key: Key(contact.entityKey),
          contact: contact,
          isDialog: vendor.contacts.length > 1,
          index: vendor.contacts.indexOf(contact),
        ),
      ];
    }

    final contact =
        vendor.contacts.contains(viewModel.contact) ? viewModel.contact : null;

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
          label: (vendor.contacts.length == 1
                  ? localization.addSecondContact
                  : localization.addContact)
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
    @required this.contact,
    @required this.onTap,
  });

  final Function onTap;
  final VendorContactEntity contact;

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

class VendorContactEditDetails extends StatefulWidget {
  const VendorContactEditDetails({
    Key key,
    @required this.index,
    @required this.contact,
    @required this.viewModel,
    @required this.vendorViewModel,
    @required this.isDialog,
  }) : super(key: key);

  final int index;
  final VendorContactEntity contact;
  final VendorEditContactsVM viewModel;
  final VendorEditVM vendorViewModel;
  final bool isDialog;

  @override
  VendorContactEditDetailsState createState() =>
      VendorContactEditDetailsState();
}

class VendorContactEditDetailsState extends State<VendorContactEditDetails> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

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
      _phoneController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final contact = widget.contact;
    _firstNameController.text = contact.firstName;
    _lastNameController.text = contact.lastName;
    _emailController.text = contact.email;
    _phoneController.text = contact.phone;

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
    final contact = widget.contact.rebuild((b) => b
      ..firstName = _firstNameController.text.trim()
      ..lastName = _lastNameController.text.trim()
      ..email = _emailController.text.trim()
      ..phone = _phoneController.text.trim());
    if (contact != widget.contact) {
      _debouncer.run(() {
        widget.viewModel.onChangedContact(contact, widget.index);
      });
    }
  }

  void _setContactControllers(Contact contact) {
    if (_firstNameController.text.isEmpty) {
      _firstNameController.text = contact.givenName ?? '';
    }
    if (_lastNameController.text.isEmpty) {
      _lastNameController.text = contact.familyName ?? '';
    }
    if (_emailController.text.isEmpty && contact.emails.isNotEmpty) {
      _emailController.text = contact.emails.first.value;
    }
    if (_phoneController.text.isEmpty && contact.phones.isNotEmpty) {
      _phoneController.text = contact.phones.first.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = widget.vendorViewModel.state;
    final isFullscreen = state.prefState.isEditorFullScreen(EntityType.vendor);

    final column = Column(
      children: [
        DecoratedFormField(
          controller: _firstNameController,
          decoration: InputDecoration(
            labelText: localization.firstName,
            suffixIcon: !kIsWeb && (Platform.isIOS || Platform.isAndroid)
                ? IconButton(
                    alignment: Alignment.bottomCenter,
                    color: Theme.of(context).cardColor,
                    icon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      final contact = await getDeviceContact();
                      if (contact != null) {
                        setState(() {
                          _setContactControllers(contact);
                        });
                      }
                    })
                : null,
          ),
        ),
        DecoratedFormField(
          controller: _lastNameController,
          label: localization.lastName,
        ),
        DecoratedFormField(
          controller: _emailController,
          label: localization.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => value.isNotEmpty && !value.contains('@')
              ? localization.emailIsInvalid
              : null,
        ),
        DecoratedFormField(
          controller: _phoneController,
          label: localization.phone,
          keyboardType: TextInputType.phone,
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
                    callback: () {
                      widget.viewModel.onRemoveContactPressed(widget.index);
                      Navigator.pop(context);
                    }),
              ),
              TextButton(
                  child: Text(localization.done.toUpperCase()),
                  onPressed: () {
                    viewModel.onDoneContactPressed();
                    Navigator.of(context).pop();
                  })
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
