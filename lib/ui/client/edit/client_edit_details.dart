import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/form_card.dart';

class ClientEditDetails extends StatefulWidget {
  ClientEditDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditDetailsState createState() => new ClientEditDetailsState();
}

class ClientEditDetailsState extends State<ClientEditDetails> {

  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _vatNumberController = TextEditingController();
  final _websiteController = TextEditingController();
  final _phoneController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
      _nameController,
      _idNumberController,
      _vatNumberController,
      _websiteController,
      _phoneController,
    ];

    _controllers.forEach((dynamic controller) => controller.removeListener(_onChanged));

    final client = widget.viewModel.client;
    _nameController.text = client.name;
    _idNumberController.text = client.idNumber;
    _vatNumberController.text = client.vatNumber;
    _websiteController.text = client.website;
    _phoneController.text = client.workPhone;

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
    final viewModel = widget.viewModel;
    final client = viewModel.client.rebuild((b) => b
        ..name = _nameController.text.trim()
        ..idNumber = _idNumberController.text.trim()
        ..vatNumber = _vatNumberController.text.trim()
        ..website = _websiteController.text.trim()
        ..workPhone = _phoneController.text.trim()
    );
    if (client != viewModel.client) {
      viewModel.onChanged(client);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: localization.name,
              ),
            ),
            TextFormField(
              autocorrect: false,
              controller: _idNumberController,
              decoration: InputDecoration(labelText: localization.idNumber,
              ),
            ),
            TextFormField(
              autocorrect: false,
              controller: _vatNumberController,
              decoration: InputDecoration(
                labelText: localization.vatNumber,
              ),
            ),
            TextFormField(
              autocorrect: false,
              controller: _websiteController,
              decoration: InputDecoration(
                labelText: localization.website,
              ),
              keyboardType: TextInputType.url,
            ),
            TextFormField(
              autocorrect: false,
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: localization.phone,
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ],
    );
  }
}
