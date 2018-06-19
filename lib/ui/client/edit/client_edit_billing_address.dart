import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditBillingAddress extends StatefulWidget {
  ClientEditBillingAddress({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditBillingAddressState createState() =>
      new ClientEditBillingAddressState();
}

class ClientEditBillingAddressState extends State<ClientEditBillingAddress> {

  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();

  var _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      _address1Controller,
      _address2Controller,
      _cityController,
      _stateController,
      _postalCodeController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    var client = widget.viewModel.client;
    _address1Controller.text = client.address1;
    _address2Controller.text = client.address2;
    _cityController.text = client.city;
    _stateController.text = client.state;
    _postalCodeController.text = client.postalCode;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  _onChanged() {
    var client = widget.viewModel.client.rebuild((b) => b
      ..address1 = _address1Controller.text.trim()
        ..address2 = _address2Controller.text.trim()
        ..city = _cityController.text.trim()
        ..state = _stateController.text.trim()
        ..postalCode = _postalCodeController.text.trim()
    );
    if (client != widget.viewModel.client) {
      widget.viewModel.onChanged(client);
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return ListView(shrinkWrap: true, children: <Widget>[
      FormCard(
        children: <Widget>[
          TextFormField(
            autocorrect: false,
            controller: _address1Controller,
            decoration: InputDecoration(
              labelText: localization.address1,
            ),
          ),
          TextFormField(
            autocorrect: false,
            controller: _address2Controller,
            decoration: InputDecoration(
              labelText: localization.address2,
            ),
          ),
          TextFormField(
            autocorrect: false,
            controller: _cityController,
            decoration: InputDecoration(
              labelText: localization.city,
            ),
          ),
          TextFormField(
            autocorrect: false,
            controller: _stateController,
            decoration: InputDecoration(
              labelText: localization.state,
            ),
          ),
          TextFormField(
            autocorrect: false,
            controller: _postalCodeController,
            decoration: InputDecoration(
              labelText: localization.postalCode,
            ),
            keyboardType: TextInputType.phone,
          ),
        ],
      )
    ]);
  }
}
