import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';

import '../../app/form_card.dart';

class ClientEditShippingAddress extends StatefulWidget {
  const ClientEditShippingAddress({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditShippingAddressState createState() =>
      ClientEditShippingAddressState();
}

class ClientEditShippingAddressState extends State<ClientEditShippingAddress> {
  final _shippingAddress1Controller = TextEditingController();
  final _shippingAddress2Controller = TextEditingController();
  final _shippingCityController = TextEditingController();
  final _shippingStateController = TextEditingController();
  final _shippingPostalCodeController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _shippingAddress1Controller,
      _shippingAddress2Controller,
      _shippingCityController,
      _shippingStateController,
      _shippingPostalCodeController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final client = widget.viewModel.client;
    _shippingAddress1Controller.text = client.shippingAddress1;
    _shippingAddress2Controller.text = client.shippingAddress2;
    _shippingCityController.text = client.shippingCity;
    _shippingStateController.text = client.shippingState;
    _shippingPostalCodeController.text = client.shippingPostalCode;

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
    final client = widget.viewModel.client.rebuild((b) => b
      ..shippingAddress1 = _shippingAddress1Controller.text.trim()
      ..shippingAddress2 = _shippingAddress2Controller.text.trim()
      ..shippingCity = _shippingCityController.text.trim()
      ..shippingState = _shippingStateController.text.trim()
      ..shippingPostalCode = _shippingPostalCodeController.text.trim());
    if (client != widget.viewModel.client) {
      widget.viewModel.onChanged(client);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final client = viewModel.client;

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
          EntityDropdown(
            key: ValueKey(client.shippingCountryId),
            entityType: EntityType.country,
            entityMap: viewModel.staticState.countryMap,
            entityList: memoizedCountryList(viewModel.staticState.countryMap),
            labelText: localization.country,
            initialValue: viewModel
                .staticState.countryMap[client.shippingCountryId]?.name,
            onSelected: (SelectableEntity country) => viewModel.onChanged(
                client.rebuild((b) => b..shippingCountryId = country.id)),
          ),
        ],
      ),
      client.hasBillingAddress && client.areAddressesDifferent
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                label: localization.copyBilling.toUpperCase(),
                onPressed: () {
                  viewModel.copyBillingAddress();
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    didChangeDependencies();
                  });
                },
              ),
            )
          : SizedBox(),
    ]);
  }
}
