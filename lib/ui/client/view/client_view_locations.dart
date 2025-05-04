// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientViewLocations extends StatefulWidget {
  const ClientViewLocations({Key? key, this.viewModel}) : super(key: key);

  final ClientViewVM? viewModel;

  @override
  _ClientViewLocationsState createState() => _ClientViewLocationsState();
}

class _ClientViewLocationsState extends State<ClientViewLocations> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel!.client.isStale) {
      widget.viewModel!.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;
    final client = widget.viewModel!.client;
    final locations = client.locations;

    if (client.isStale) {
      return LoadingIndicator();
    }

    return ScrollableListView(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppButton(
            label: localization.addLocation,
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => _LocationModal(
                        location: LocationEntity(),
                      ));
            }),
      ),
      SizedBox(height: 10),
      ...locations
          .map((location) => ListTile(
                onTap: () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => _LocationModal(
                          location: location,
                        )),
                title: Text(location.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (location.address1.isNotEmpty) Text(location.address1),
                    if (location.address2.isNotEmpty) Text(location.address2),
                    if (location.city.isNotEmpty ||
                        location.state.isNotEmpty ||
                        location.postalCode.isNotEmpty)
                      if (state.company.cityStateOrder() ==
                          CompanyFields.cityStatePostal)
                        Row(
                          children: [
                            if (location.city.isNotEmpty) Text(location.city),
                            if (location.city.isNotEmpty &&
                                location.state.isNotEmpty)
                              Text(', '),
                            if (location.state.isNotEmpty) Text(location.state),
                            if (location.city.isNotEmpty &&
                                location.state.isNotEmpty)
                              Text(' '),
                            if (location.postalCode.isNotEmpty)
                              Text(location.postalCode),
                          ],
                        )
                      else
                        Row(
                          children: [
                            if (location.postalCode.isNotEmpty)
                              Text(location.postalCode),
                            if (location.postalCode.isNotEmpty &&
                                location.city.isNotEmpty)
                              Text(' '),
                            if (location.city.isNotEmpty) Text(location.city),
                            if (location.city.isNotEmpty &&
                                location.state.isNotEmpty)
                              Text(', '),
                            if (location.state.isNotEmpty) Text(location.state),
                          ],
                        ),
                  ],
                ),
                leading: Icon(getEntityIcon(EntityType.location)),
              ))
          .toList(),
    ]);
  }
}

class _LocationModal extends StatefulWidget {
  const _LocationModal({required this.location});

  final LocationEntity location;

  @override
  State<_LocationModal> createState() => __LocationModalState();
}

class __LocationModalState extends State<_LocationModal> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_locationEdit');
  final FocusScopeNode _focusNode = FocusScopeNode();

  late List<TextEditingController> _controllers;
  var _location = LocationEntity();

  @override
  void initState() {
    super.initState();

    if (widget.location.isOld) {
      _location = widget.location;
    }

    _nameController.text = _location.name;
    _phoneController.text = _location.phone;
    _address1Controller.text = _location.address1;
    _address2Controller.text = _location.address2;
    _cityController.text = _location.city;
    _stateController.text = _location.state;
    _postalCodeController.text = _location.postalCode;
    _custom1Controller.text = _location.customValue1;
    _custom2Controller.text = _location.customValue2;
    _custom3Controller.text = _location.customValue3;
    _custom4Controller.text = _location.customValue4;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controllers.forEach((dynamic controller) {
      controller.dispose();
    });

    super.dispose();
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final location = _location.rebuild((b) => b
      ..name = _nameController.text.trim()
      ..phone = _phoneController.text.trim()
      ..address1 = _address1Controller.text.trim()
      ..address2 = _address2Controller.text.trim()
      ..city = _cityController.text.trim()
      ..state = _stateController.text.trim()
      ..postalCode = _postalCodeController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());

    //widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;
    final location = _location;

    return AlertDialog(
      title: Text(location.isNew
          ? localization.addLocation
          : localization.editLocation),
      content: AppForm(
        focusNode: _focusNode,
        formKey: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedFormField(
                label: localization.name,
                controller: _nameController,
                onSavePressed: _onSavePressed,
                keyboardType: TextInputType.text,
              ),
              DecoratedFormField(
                controller: _address1Controller,
                label: localization.address1,
                keyboardType: TextInputType.streetAddress,
              ),
              DecoratedFormField(
                autocorrect: false,
                controller: _address2Controller,
                label: localization.address2,
                keyboardType: TextInputType.text,
              ),
              DecoratedFormField(
                autocorrect: false,
                controller: _cityController,
                label: localization.city,
                keyboardType: TextInputType.text,
              ),
              DecoratedFormField(
                autocorrect: false,
                controller: _stateController,
                label: localization.state,
                keyboardType: TextInputType.text,
              ),
              DecoratedFormField(
                autocorrect: false,
                controller: _postalCodeController,
                label: localization.postalCode,
                keyboardType: TextInputType.text,
              ),
              EntityDropdown(
                entityType: EntityType.country,
                entityList: memoizedCountryList(state.staticState.countryMap),
                labelText: localization.country,
                entityId: _location.countryId,
                onSelected: (SelectableEntity? country) {
                  setState(() {
                    _location = _location
                        .rebuild((b) => b..countryId = country?.id ?? '');
                  });
                },
              ),
              CustomField(
                controller: _custom1Controller,
                field: CustomFieldType.location1,
                value: location.customValue1,
              ),
              CustomField(
                controller: _custom2Controller,
                field: CustomFieldType.location2,
                value: location.customValue2,
              ),
              CustomField(
                controller: _custom3Controller,
                field: CustomFieldType.location3,
                value: location.customValue3,
              ),
              CustomField(
                controller: _custom4Controller,
                field: CustomFieldType.location4,
                value: location.customValue4,
              ),
              DecoratedFormField(
                label: localization.phone,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localization.cancel.toUpperCase()),
        ),
        TextButton(
          onPressed: () => _onSavePressed(context),
          child: Text(localization.save.toUpperCase()),
        ),
      ],
    );
  }
}
