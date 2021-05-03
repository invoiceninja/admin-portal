import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/contacts.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:contacts_service/contacts_service.dart';

class ClientEditDetails extends StatefulWidget {
  const ClientEditDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditDetailsState createState() => ClientEditDetailsState();
}

class ClientEditDetailsState extends State<ClientEditDetails> {
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

    final client = widget.viewModel.client;
    _numberController.text = client.number;
    _nameController.text = client.name;
    _idNumberController.text = client.idNumber;
    _vatNumberController.text = client.vatNumber;
    _websiteController.text = client.website;
    _phoneController.text = client.phone;
    _custom1Controller.text = client.customValue1;
    _custom2Controller.text = client.customValue2;
    _custom3Controller.text = client.customValue3;
    _custom4Controller.text = client.customValue4;

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
    final client = viewModel.client.rebuild((b) => b
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
    if (client != viewModel.client) {
      _debouncer.run(() {
        viewModel.onChanged(client);
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
    final state = viewModel.state;
    final client = viewModel.client;

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              key: ValueKey(localization.name),
              autofocus: true,
              controller: _nameController,
              validator: (String val) => !viewModel.client.hasNameSet
                  ? AppLocalization.of(context).pleaseEnterAClientOrContactName
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
            if (client.isOld)
              DecoratedFormField(
                label: localization.number,
                controller: _numberController,
              ),
            DynamicSelector(
              entityType: EntityType.group,
              entityIds: memoizedGroupList(state.groupState.map),
              entityId: client.groupId,
              onChanged: (groupId) => viewModel
                  .onChanged(client.rebuild((b) => b..groupId = groupId)),
            ),
            UserPicker(
              userId: client.assignedUserId,
              onChanged: (userId) => viewModel
                  .onChanged(client.rebuild((b) => b..assignedUserId = userId)),
            ),
            DecoratedFormField(
              label: localization.idNumber,
              controller: _idNumberController,
              onSavePressed: viewModel.onSavePressed,
            ),
            DecoratedFormField(
              label: localization.vatNumber,
              controller: _vatNumberController,
              onSavePressed: viewModel.onSavePressed,
            ),
            DecoratedFormField(
              label: localization.website,
              controller: _websiteController,
              keyboardType: TextInputType.url,
              onSavePressed: viewModel.onSavePressed,
            ),
            DecoratedFormField(
              label: localization.phone,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom1Controller,
              field: CustomFieldType.client1,
              value: client.customValue1,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom2Controller,
              field: CustomFieldType.client2,
              value: client.customValue2,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom3Controller,
              field: CustomFieldType.client3,
              value: client.customValue3,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom4Controller,
              field: CustomFieldType.client4,
              value: client.customValue4,
              onSavePressed: viewModel.onSavePressed,
            ),
          ],
        ),
      ],
    );
  }
}
