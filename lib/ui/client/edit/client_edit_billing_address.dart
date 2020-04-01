import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';

class ClientEditBillingAddress extends StatefulWidget {
  const ClientEditBillingAddress({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditBillingAddressState createState() =>
      ClientEditBillingAddressState();
}

class ClientEditBillingAddressState extends State<ClientEditBillingAddress> {
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _address1Controller,
      _address2Controller,
      _cityController,
      _stateController,
      _postalCodeController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final client = widget.viewModel.client;
    _address1Controller.text = client.address1;
    _address2Controller.text = client.address2;
    _cityController.text = client.city;
    _stateController.text = client.state;
    _postalCodeController.text = client.postalCode;

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
    _debouncer.run(() {
      final client = widget.viewModel.client.rebuild((b) => b
        ..address1 = _address1Controller.text.trim()
        ..address2 = _address2Controller.text.trim()
        ..city = _cityController.text.trim()
        ..state = _stateController.text.trim()
        ..postalCode = _postalCodeController.text.trim());
      if (client != widget.viewModel.client) {
        widget.viewModel.onChanged(client);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final client = viewModel.client;

    return ListView(shrinkWrap: true, children: <Widget>[
      FormCard(
        children: <Widget>[
          DecoratedFormField(
            controller: _address1Controller,
            label: localization.address1,
          ),
          DecoratedFormField(
            autocorrect: false,
            controller: _address2Controller,
            label: localization.address2,
          ),
          DecoratedFormField(
            autocorrect: false,
            controller: _cityController,
            label: localization.city,
          ),
          DecoratedFormField(
            autocorrect: false,
            controller: _stateController,
            label: localization.state,
          ),
          DecoratedFormField(
            autocorrect: false,
            controller: _postalCodeController,
            label: localization.postalCode,
          ),
          EntityDropdown(
            key: ValueKey('__billing_country_${client.countryId}__'),
            allowClearing: true,
            entityType: EntityType.country,
            entityList: memoizedCountryList(viewModel.staticState.countryMap),
            labelText: localization.country,
            entityId: client.countryId,
            onSelected: (SelectableEntity country) => viewModel
                .onChanged(client.rebuild((b) => b..countryId = country?.id)),
          ),
        ],
      ),
      client.hasShippingAddress && client.areAddressesDifferent
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                label: localization.copyShipping.toUpperCase(),
                onPressed: () {
                  viewModel.copyShippingAddress();
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
