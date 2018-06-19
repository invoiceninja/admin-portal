import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

import '../../app/form_card.dart';

class ClientEditShippingAddress extends StatefulWidget {
  ClientEditShippingAddress({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditShippingAddressState createState() =>
      new ClientEditShippingAddressState();
}

class ClientEditShippingAddressState extends State<ClientEditShippingAddress> {

  final _shippingAddress1Controller = TextEditingController();
  final _shippingAddress2Controller = TextEditingController();
  final _shippingCityController = TextEditingController();
  final _shippingStateController = TextEditingController();
  final _shippingPostalCodeController = TextEditingController();

  var _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      _shippingAddress1Controller,
      _shippingAddress2Controller,
      _shippingCityController,
      _shippingStateController,
      _shippingPostalCodeController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    var client = widget.viewModel.client;
    _shippingAddress1Controller.text = client.shippingAddress1;
    _shippingAddress2Controller.text = client.shippingAddress2;
    _shippingCityController.text = client.shippingCity;
    _shippingStateController.text = client.shippingState;
    _shippingPostalCodeController.text = client.shippingPostalCode;

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
      ..shippingAddress1 = _shippingAddress1Controller.text.trim()
      ..shippingAddress2 = _shippingAddress2Controller.text.trim()
      ..shippingCity = _shippingCityController.text.trim()
      ..shippingState = _shippingStateController.text.trim()
      ..shippingPostalCode = _shippingPostalCodeController.text.trim()
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
            controller: _shippingAddress1Controller,
            decoration: InputDecoration(
              labelText: localization.address1,
            ),
          ),
          TextFormField(
            autocorrect: false,
            controller: _shippingAddress2Controller,
            decoration: InputDecoration(
              labelText: localization.address2,
            ),
          ),
          TextFormField(
            autocorrect: false,
            controller: _shippingCityController,
            decoration: InputDecoration(
              labelText: localization.city,
            ),
          ),
          TextFormField(
            autocorrect: false,
            controller: _shippingStateController,
            decoration: InputDecoration(
              labelText: localization.state,
            ),
          ),
          TextFormField(
            autocorrect: false,
            controller: _shippingPostalCodeController,
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
