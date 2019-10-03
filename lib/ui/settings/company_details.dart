import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
  final _paymentTermsController = TextEditingController();
  final _taskRateController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
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
      _paymentTermsController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final company = widget.viewModel.company;
    final settings = company.settings;

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
    _taskRateController.text = formatNumber(settings.defaultTaskRate, context,
        formatNumberType: FormatNumberType.input);
    _paymentTermsController.text = formatNumber(
        settings.defaultPaymentTerms?.toDouble(), context,
        formatNumberType: FormatNumberType.input);

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
      ..postalCode = _postalCodeController.text.trim()
      ..settings.defaultTaskRate = parseDouble(_taskRateController.text) ?? 0
      ..settings.defaultPaymentTerms =
          int.tryParse(_paymentTermsController.text) ?? 0);
    if (company != widget.viewModel.company) {
      widget.viewModel.onChanged(company);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;

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
            text: localization.logo,
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
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    DecoratedFormField(
                      label: localization.idNumber,
                      controller: _idNumberController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    DecoratedFormField(
                      label: localization.vatNumber,
                      controller: _vatNumberController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    DecoratedFormField(
                      label: localization.website,
                      controller: _websiteController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    DecoratedFormField(
                      label: localization.email,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    DecoratedFormField(
                      label: localization.phone,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                  ],
                ),
                FormCard(
                  children: <Widget>[
                    EntityDropdown(
                      key: ValueKey('__size_${company.sizeId}__'),
                      entityType: EntityType.size,
                      entityMap: state.staticState.sizeMap,
                      entityList: memoizedSizeList(state.staticState.sizeMap),
                      labelText: localization.size,
                      initialValue:
                          state.staticState.sizeMap[company.sizeId]?.name,
                      onSelected: (SelectableEntity size) =>
                          viewModel.onChanged(
                              company.rebuild((b) => b..sizeId = size.id)),
                    ),
                    EntityDropdown(
                      key: ValueKey('__industry_${company.industryId}__'),
                      entityType: EntityType.industry,
                      entityMap: state.staticState.industryMap,
                      entityList:
                          memoizedIndustryList(state.staticState.industryMap),
                      labelText: localization.industry,
                      initialValue: state
                          .staticState.industryMap[company.industryId]?.name,
                      onSelected: (SelectableEntity industry) =>
                          viewModel.onChanged(company
                              .rebuild((b) => b..industryId = industry.id)),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                width: 300,
                label: localization.uploadLogo,
                icon: Icons.cloud_upload,
                onPressed: () {},
              ),
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
                    EntityDropdown(
                      key: ValueKey('__country_${company.countryId}__'),
                      entityType: EntityType.country,
                      entityMap: state.staticState.countryMap,
                      entityList:
                          memoizedCountryList(state.staticState.countryMap),
                      labelText: localization.country,
                      initialValue:
                          state.staticState.countryMap[company.countryId]?.name,
                      onSelected: (SelectableEntity country) =>
                          viewModel.onChanged(company
                              .rebuild((b) => b..countryId = country.id)),
                    ),
                  ],
                )
              ],
            ),
            ListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    EntityDropdown(
                      key: ValueKey(
                          '__payment_type_${company.settings.defaultPaymentTypeId}__'),
                      entityType: EntityType.paymentType,
                      entityMap: state.staticState.paymentTypeMap,
                      entityList: memoizedPaymentTypeList(
                          state.staticState.paymentTypeMap),
                      labelText: localization.paymentType,
                      initialValue: state
                          .staticState
                          .paymentTypeMap[company.settings.defaultPaymentTypeId]
                          ?.name,
                      onSelected: (paymentType) => viewModel.onChanged(
                          company.rebuild((b) => b
                            ..settings.defaultPaymentTypeId = paymentType.id)),
                    ),
                    DecoratedFormField(
                      label: localization.paymentTerms,
                      controller: _paymentTermsController,
                      keyboardType: TextInputType.number,
                    ),
                    DecoratedFormField(
                      label: localization.taskRate,
                      controller: _taskRateController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
