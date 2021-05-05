import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/contacts.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:contacts_service/contacts_service.dart';

class VendorEditDetails extends StatefulWidget {
  const VendorEditDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  VendorEditDetailsState createState() => VendorEditDetailsState();
}

class VendorEditDetailsState extends State<VendorEditDetails> {
  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _vatNumberController = TextEditingController();
  final _websiteController = TextEditingController();
  final _phoneController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  final _debouncer = Debouncer();
  List<TextEditingController> _controllers;

  @override
  void didChangeDependencies() {
    _controllers = [
      _numberController,
      _nameController,
      _idNumberController,
      _vatNumberController,
      _websiteController,
      _phoneController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final vendor = widget.viewModel.vendor;
    _numberController.text = vendor.number;
    _nameController.text = vendor.name;
    _idNumberController.text = vendor.idNumber;
    _vatNumberController.text = vendor.vatNumber;
    _websiteController.text = vendor.website;
    _phoneController.text = vendor.phone;
    _custom1Controller.text = vendor.customValue1;
    _custom2Controller.text = vendor.customValue2;
    _custom3Controller.text = vendor.customValue3;
    _custom4Controller.text = vendor.customValue4;

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
    final vendor = viewModel.vendor.rebuild((b) => b
      ..number = _numberController.text.trim()
      ..name = _nameController.text.trim()
      ..idNumber = _idNumberController.text.trim()
      ..vatNumber = _vatNumberController.text.trim()
      ..website = _websiteController.text.trim()
      ..phone = _phoneController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());
    if (vendor != viewModel.vendor) {
      _debouncer.run(() {
        viewModel.onChanged(vendor);
      });
    }
  }

  void _setContactControllers(Contact contact) {
    if (_nameController.text.isEmpty) {
      _nameController.text = contact.displayName ?? '';
    }
    if (contact.phones.isNotEmpty) {
      _phoneController.text = contact.phones.first.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final vendor = viewModel.vendor;

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              key: ValueKey(localization.name),
              autofocus: true,
              controller: _nameController,
              validator: (String val) => val == null || val.isEmpty
                  ? AppLocalization.of(context).pleaseEnterAName
                  : null,
              onSavePressed: viewModel.onSavePressed,
              decoration: InputDecoration(
                labelText: localization.name,
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
            if (vendor.isOld)
              DecoratedFormField(
                label: localization.number,
                controller: _numberController,
                onSavePressed: viewModel.onSavePressed,
              ),
            UserPicker(
              userId: vendor.assignedUserId,
              onChanged: (userId) => viewModel
                  .onChanged(vendor.rebuild((b) => b..assignedUserId = userId)),
            ),
            DecoratedFormField(
              controller: _idNumberController,
              label: localization.idNumber,
              onSavePressed: viewModel.onSavePressed,
            ),
            DecoratedFormField(
              controller: _vatNumberController,
              label: localization.vatNumber,
              onSavePressed: viewModel.onSavePressed,
            ),
            DecoratedFormField(
              controller: _websiteController,
              label: localization.website,
              keyboardType: TextInputType.url,
              onSavePressed: viewModel.onSavePressed,
            ),
            DecoratedFormField(
              controller: _phoneController,
              label: localization.phone,
              keyboardType: TextInputType.phone,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom1Controller,
              field: CustomFieldType.vendor1,
              value: vendor.customValue1,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom2Controller,
              field: CustomFieldType.vendor2,
              value: vendor.customValue2,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom3Controller,
              field: CustomFieldType.vendor3,
              value: vendor.customValue3,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom4Controller,
              field: CustomFieldType.vendor4,
              value: vendor.customValue4,
              onSavePressed: viewModel.onSavePressed,
            ),
          ],
        ),
      ],
    );
  }
}
