import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

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
  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _vatNumberController = TextEditingController();
  final _websiteController = TextEditingController();
  final _phoneController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  final List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
      _nameController,
      _idNumberController,
      _vatNumberController,
      _websiteController,
      _phoneController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final client = widget.viewModel.client;
    _nameController.text = client.name;
    _idNumberController.text = client.idNumber;
    _vatNumberController.text = client.vatNumber;
    _websiteController.text = client.website;
    _phoneController.text = client.workPhone;
    _custom1Controller.text = client.customValue1;
    _custom2Controller.text = client.customValue2;

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
      ..name = _nameController.text.trim()
      ..idNumber = _idNumberController.text.trim()
      ..vatNumber = _vatNumberController.text.trim()
      ..website = _websiteController.text.trim()
      ..workPhone = _phoneController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim());
    if (client != viewModel.client) {
      viewModel.onChanged(client);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final client = viewModel.client;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              label: localization.name,
              controller: _nameController,
              validator: (String val) => !viewModel.client.hasNameSet
                  ? AppLocalization.of(context).pleaseEnterAClientOrContactName
                  : null,
            ),
            EntityDropdown(
              entityType: EntityType.group,
              entityMap: state.groupState.map,
              entityList: memoizedGroupList(state.groupState.map),
              labelText: localization.group,
              initialValue: state.groupState.map[client.groupId]?.name,
              onSelected: (SelectableEntity group) => viewModel
                  .onChanged(client.rebuild((b) => b..groupId = group?.id)),
              allowClearing: true,
            ),
            DecoratedFormField(
              label: localization.idNumber,
              controller: _idNumberController,
            ),
            DecoratedFormField(
              label: localization.vatNumber,
              controller: _vatNumberController,
            ),
            DecoratedFormField(
              label: localization.website,
              controller: _websiteController,
              keyboardType: TextInputType.url,
            ),
            DecoratedFormField(
              label: localization.phone,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            CustomField(
              controller: _custom1Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.client1),
              options: company.getCustomFieldValues(CustomFieldType.client1),
            ),
            CustomField(
              controller: _custom2Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.client2),
              options: company.getCustomFieldValues(CustomFieldType.client2),
            ),
          ],
        ),
      ],
    );
  }
}
