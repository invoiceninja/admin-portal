// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientEditShippingAddress extends StatefulWidget {
  const ClientEditShippingAddress({
    Key? key,
    required this.viewModel,
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
  final _debouncer = Debouncer();

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
    final viewModel = widget.viewModel;
    final client = viewModel.client.rebuild((b) => b
      ..shippingAddress1 = _shippingAddress1Controller.text.trim()
      ..shippingAddress2 = _shippingAddress2Controller.text.trim()
      ..shippingCity = _shippingCityController.text.trim()
      ..shippingState = _shippingStateController.text.trim()
      ..shippingPostalCode = _shippingPostalCodeController.text.trim());
    if (client != viewModel.client) {
      _debouncer.run(() {
        viewModel.onChanged(client);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final client = viewModel.client;
    final isFullscreen =
        viewModel.state.prefState.isEditorFullScreen(EntityType.client);

    return FormCard(
      isLast: true,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      padding: isFullscreen
          ? const EdgeInsets.only(
              left: kMobileDialogPadding / 2,
              top: kMobileDialogPadding,
              right: kMobileDialogPadding,
            )
          : null,
      children: <Widget>[
        DecoratedFormField(
          controller: _shippingAddress1Controller,
          label: isFullscreen
              ? localization.shippingAddress1
              : localization.address1,
          onSavePressed: viewModel.onSavePressed,
          keyboardType: TextInputType.streetAddress,
        ),
        DecoratedFormField(
          controller: _shippingAddress2Controller,
          label: localization.address2,
          onSavePressed: viewModel.onSavePressed,
          keyboardType: TextInputType.text,
        ),
        DecoratedFormField(
          controller: _shippingCityController,
          label: localization.city,
          onSavePressed: viewModel.onSavePressed,
          keyboardType: TextInputType.text,
        ),
        DecoratedFormField(
          controller: _shippingStateController,
          label: localization.state,
          onSavePressed: viewModel.onSavePressed,
          keyboardType: TextInputType.text,
        ),
        DecoratedFormField(
          controller: _shippingPostalCodeController,
          label: localization.postalCode,
          onSavePressed: viewModel.onSavePressed,
          keyboardType: TextInputType.text,
        ),
        EntityDropdown(
          entityType: EntityType.country,
          entityList: memoizedCountryList(viewModel.staticState.countryMap),
          labelText: localization.country,
          entityId: client.shippingCountryId,
          onSelected: (SelectableEntity? country) => viewModel.onChanged(
              client.rebuild((b) => b..shippingCountryId = country?.id ?? '')),
        ),
        if (client.hasBillingAddress && client.areAddressesDifferent)
          AppButton(
            label: localization.copyBilling.toUpperCase(),
            onPressed: () {
              viewModel.copyBillingAddress();
              WidgetsBinding.instance.addPostFrameCallback((duration) {
                didChangeDependencies();
              });
            },
          )
      ],
    );
  }
}
