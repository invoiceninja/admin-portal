import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';

class VendorEditAddress extends StatefulWidget {
  const VendorEditAddress({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  VendorEditAddressState createState() => VendorEditAddressState();
}

class VendorEditAddressState extends State<VendorEditAddress> {
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

    final vendor = widget.viewModel.vendor;
    _address1Controller.text = vendor.address1;
    _address2Controller.text = vendor.address2;
    _cityController.text = vendor.city;
    _stateController.text = vendor.state;
    _postalCodeController.text = vendor.postalCode;

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
    final vendor = widget.viewModel.vendor.rebuild((b) => b
      ..address1 = _address1Controller.text.trim()
      ..address2 = _address2Controller.text.trim()
      ..city = _cityController.text.trim()
      ..state = _stateController.text.trim()
      ..postalCode = _postalCodeController.text.trim());
    if (vendor != widget.viewModel.vendor) {
      _debouncer.run(() {
        widget.viewModel.onChanged(vendor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final vendor = viewModel.vendor;

    return ScrollableListView(children: <Widget>[
      FormCard(
        children: <Widget>[
          DecoratedFormField(
            controller: _address1Controller,
            label: localization.address1,
            onSavePressed: viewModel.onSavePressed,
          ),
          DecoratedFormField(
            controller: _address2Controller,
            label: localization.address2,
            onSavePressed: viewModel.onSavePressed,
          ),
          DecoratedFormField(
            controller: _cityController,
            label: localization.city,
            onSavePressed: viewModel.onSavePressed,
          ),
          DecoratedFormField(
            controller: _stateController,
            label: localization.state,
            onSavePressed: viewModel.onSavePressed,
          ),
          DecoratedFormField(
            controller: _postalCodeController,
            label: localization.postalCode,
            onSavePressed: viewModel.onSavePressed,
          ),
          EntityDropdown(
            key: ValueKey('__country_${vendor.countryId}__'),
            entityType: EntityType.country,
            entityList:
                memoizedCountryList(viewModel.state.staticState.countryMap),
            labelText: localization.country,
            entityId: vendor.countryId,
            onSelected: (SelectableEntity country) => viewModel
                .onChanged(vendor.rebuild((b) => b..countryId = country?.id)),
          ),
        ],
      ),
    ]);
  }
}
