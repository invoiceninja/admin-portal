import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorEdit extends StatefulWidget {
  const VendorEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  _VendorEditState createState() => _VendorEditState();
}

class _VendorEditState extends State<VendorEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STARTER: controllers - do not remove comment
  final _nameController = TextEditingController();

  final _address1Controller = TextEditingController();

  final _address2Controller = TextEditingController();

  final _cityController = TextEditingController();

  final _stateController = TextEditingController();

  final _postalCodeController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
      _nameController,

      _address1Controller,

      _address2Controller,

      _cityController,

      _stateController,

      _postalCodeController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final vendor = widget.viewModel.vendor;
    // STARTER: read value - do not remove comment
    _nameController.text = vendor.name;

    _address1Controller.text = vendor.address1;

    _address2Controller.text = vendor.address2;

    _cityController.text = vendor.city;

    _stateController.text = vendor.state;

    _postalCodeController.text = vendor.postalCode;

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

  void _onChanged() {
    final vendor = widget.viewModel.vendor.rebuild((b) => b
      // STARTER: set value - do not remove comment
      ..name = _nameController.text.trim()
      ..address1 = _address1Controller.text.trim()
      ..address2 = _address2Controller.text.trim()
      ..city = _cityController.text.trim()
      ..state = _stateController.text.trim()
      ..postalCode = _postalCodeController.text.trim());
    if (vendor != widget.viewModel.vendor) {
      widget.viewModel.onChanged(vendor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final vendor = viewModel.vendor;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.vendor.isNew
              ? localization.newVendor
              : localization.editVendor),
          actions: <Widget>[
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: !vendor.isDeleted,
              isDirty: vendor.isNew || vendor != viewModel.origVendor,
              isSaving: viewModel.isSaving,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                viewModel.onSavePressed(context);
              },
            ),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Builder(builder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      // STARTER: widgets - do not remove comment
                      TextFormField(
                        controller: _nameController,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),

                      TextFormField(
                        controller: _address1Controller,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Address1',
                        ),
                      ),

                      TextFormField(
                        controller: _address2Controller,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Address2',
                        ),
                      ),

                      TextFormField(
                        controller: _cityController,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'City',
                        ),
                      ),

                      TextFormField(
                        controller: _stateController,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'State',
                        ),
                      ),

                      TextFormField(
                        controller: _postalCodeController,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'PostalCode',
                        ),
                      ),
                    ],
                  ),
                ],
              );
            })),
      ),
    );
  }
}
