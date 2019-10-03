import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyDetails extends StatefulWidget {
  const CompanyDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CompanyDetailsVM viewModel;

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TabController _controller;

  bool autoValidate = false;

  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _vatNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _phoneController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _taskRateController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print('### didChangeDependencies...');

    _controllers = [
      _nameController,
      _idNumberController,
      _vatNumberController,
      _emailController,
      _websiteController,
      _phoneController,
      _address1Controller,
      _address2Controller,
      _cityController,
      _stateController,
      _postalCodeController,
      _taskRateController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final company = widget.viewModel.company;
    _nameController.text = company.name;
    _idNumberController.text = company.idNumber;
    _vatNumberController.text = company.vatNumber;
    _emailController.text = company.workEmail;
    _websiteController.text = company.website;
    _phoneController.text = company.workPhone;
    _address1Controller.text = company.address1;
    _address2Controller.text = company.address2;
    _cityController.text = company.city;
    _stateController.text = company.state;
    _postalCodeController.text = company.postalCode;
    _taskRateController.text = ''; // TODO fix this

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final company = widget.viewModel.company.rebuild((b) => b
      ..name = _nameController.text.trim()
      ..idNumber = _idNumberController.text.trim()
      ..vatNumber = _vatNumberController.text.trim()
      ..workPhone = _phoneController.text.trim()
      ..workEmail = _emailController.text.trim()
      ..website = _websiteController.text.trim()
      ..address1 = _address1Controller.text.trim()
      ..address2 = _address2Controller.text.trim()
      ..city = _cityController.text.trim()
      ..state = _stateController.text.trim()
      ..postalCode = _postalCodeController.text.trim());
    if (company != widget.viewModel.company) {
      widget.viewModel.onChanged(company);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    return SettingsScaffold(
      title: localization.companyDetails,
      onCancelPressed: viewModel.onCancelPressed,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        controller: _controller,
        tabs: [
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.address,
          ),
          Tab(
            text: localization.defaults,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _controller,
          children: <Widget>[
            ListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      label: localization.name,
                      controller: _nameController,
                      validator: (val) => val.isEmpty || val.trim().isEmpty
                          ? localization.pleaseEnterAName
                          : null,
                      autovalidate: autoValidate,
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
                    ),
                    DecoratedFormField(
                      label: localization.email,
                      controller: _emailController,
                    ),
                    DecoratedFormField(
                      label: localization.phone,
                      controller: _phoneController,
                    ),
                  ],
                )
              ],
            ),
            ListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      label: localization.address1,
                      controller: _address1Controller,
                    ),
                    DecoratedFormField(
                      label: localization.address2,
                      controller: _address2Controller,
                    ),
                    DecoratedFormField(
                      label: localization.city,
                      controller: _cityController,
                    ),
                    DecoratedFormField(
                      label: localization.state,
                      controller: _stateController,
                    ),
                    DecoratedFormField(
                      label: localization.postalCode,
                      controller: _postalCodeController,
                    ),
                  ],
                )
              ],
            ),
            ListView(),
          ],
        ),
      ),
    );
  }
}
