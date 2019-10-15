import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/resources/cached_image.dart';
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

  final FocusScopeNode _node = FocusScopeNode();
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
      controller.removeListener(_onSettingsChanged);
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

    _controllers.forEach(
        (dynamic controller) => controller.removeListener(_onSettingsChanged));

    final viewModel = widget.viewModel;
    final settings = viewModel.settings;

    _nameController.text = settings.name;
    _idNumberController.text = settings.idNumber;
    _vatNumberController.text = settings.vatNumber;
    _emailController.text = settings.email;
    _websiteController.text = settings.website;
    _phoneController.text = settings.phone;
    _address1Controller.text = settings.address1;
    _address2Controller.text = settings.address2;
    _cityController.text = settings.city;
    _stateController.text = settings.state;
    _postalCodeController.text = settings.postalCode;
    _taskRateController.text = formatNumber(settings.defaultTaskRate, context,
        formatNumberType: FormatNumberType.input);
    _paymentTermsController.text = formatNumber(
        settings.defaultPaymentTerms?.toDouble(), context,
        formatNumberType: FormatNumberType.input);

    _controllers.forEach(
        (dynamic controller) => controller.addListener(_onSettingsChanged));

    super.didChangeDependencies();
  }

  void _onSettingsChanged() {
    final settings = widget.viewModel.settings.rebuild((b) => b
      ..name = _nameController.text.trim()
      ..idNumber = _idNumberController.text.trim()
      ..vatNumber = _vatNumberController.text.trim()
      ..phone = _phoneController.text.trim()
      ..email = _emailController.text.trim()
      ..website = _websiteController.text.trim()
      ..address1 = _address1Controller.text.trim()
      ..address2 = _address2Controller.text.trim()
      ..city = _cityController.text.trim()
      ..state = _stateController.text.trim()
      ..postalCode = _postalCodeController.text.trim()
      ..defaultTaskRate = parseDouble(_taskRateController.text) ?? 0
      ..defaultPaymentTerms = int.tryParse(_paymentTermsController.text) ?? 0);
    if (settings != widget.viewModel.settings) {
      widget.viewModel.onSettingsChanged(settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final settings = company.settings;

    return SettingsScaffold(
      title: localization.companyDetails,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
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
      body: FocusScope(
        node: _node,
        child: Form(
          key: _formKey,
          child: TabBarView(
            key: ValueKey(state.settingsUIState.updatedAt),
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
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.idNumber,
                        controller: _idNumberController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.vatNumber,
                        controller: _vatNumberController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.website,
                        controller: _websiteController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.email,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.phone,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        //textInputAction: TextInputAction.next,
                        //onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                    ],
                  ),
                  if (!state.settingsUIState.isFiltered)
                    FormCard(
                      children: <Widget>[
                        EntityDropdown(
                          key: ValueKey('__size_${company.sizeId}__'),
                          entityType: EntityType.size,
                          entityMap: state.staticState.sizeMap,
                          entityList:
                              memoizedSizeList(state.staticState.sizeMap),
                          labelText: localization.size,
                          initialValue:
                              state.staticState.sizeMap[company.sizeId]?.name,
                          onSelected: (SelectableEntity size) =>
                              viewModel.onCompanyChanged(
                            company.rebuild((b) => b..sizeId = size.id),
                          ),
                          //onFieldSubmitted: (String value) => _node.nextFocus(),
                        ),
                        EntityDropdown(
                          key: ValueKey('__industry_${company.industryId}__'),
                          entityType: EntityType.industry,
                          entityMap: state.staticState.industryMap,
                          entityList: memoizedIndustryList(
                              state.staticState.industryMap),
                          labelText: localization.industry,
                          initialValue: state.staticState
                              .industryMap[company.industryId]?.name,
                          onSelected: (SelectableEntity industry) =>
                              viewModel.onCompanyChanged(
                            company.rebuild((b) => b..industryId = industry.id),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    if (settings.companyLogo != null &&
                        settings.companyLogo.isNotEmpty)
                      Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: CachedImage(
                            width: double.infinity,
                            url: settings.companyLogo,
                            //url: '${settings.logoUrl}?clear_cache=${state.selectedCompany.updatedAt}',
                          )),
                    Builder(
                      builder: (context) {
                        return ElevatedButton(
                          width: double.infinity,
                          label: localization.uploadLogo,
                          icon: Icons.cloud_upload,
                          onPressed: () async {
                            final image = await ImagePicker.pickImage(
                                source: kReleaseMode
                                    ? ImageSource.gallery
                                    : ImageSource.camera);
                            if (image != null) {
                              viewModel.onUploadLogo(context, image.path);
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      DecoratedFormField(
                        label: localization.address1,
                        controller: _address1Controller,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.address2,
                        controller: _address2Controller,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.city,
                        controller: _cityController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.state,
                        controller: _stateController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      DecoratedFormField(
                        label: localization.postalCode,
                        controller: _postalCodeController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _node.nextFocus(),
                      ),
                      EntityDropdown(
                        allowClearing: state.settingsUIState.isFiltered,
                        key: ValueKey('__country_${settings.countryId}__'),
                        entityType: EntityType.country,
                        entityMap: state.staticState.countryMap,
                        entityList:
                            memoizedCountryList(state.staticState.countryMap),
                        labelText: localization.country,
                        initialValue: state
                            .staticState.countryMap[settings.countryId]?.name,
                        onSelected: (SelectableEntity country) =>
                            viewModel.onSettingsChanged(settings
                                .rebuild((b) => b..countryId = country?.id)),
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
                            '__payment_type_${settings.defaultPaymentTypeId}__'),
                        entityType: EntityType.paymentType,
                        entityMap: state.staticState.paymentTypeMap,
                        entityList: memoizedPaymentTypeList(
                            state.staticState.paymentTypeMap),
                        labelText: localization.paymentType,
                        initialValue: state
                            .staticState
                            .paymentTypeMap[settings.defaultPaymentTypeId]
                            ?.name,
                        onSelected: (paymentType) =>
                            viewModel.onSettingsChanged(settings.rebuild((b) =>
                                b..defaultPaymentTypeId = paymentType.id)),
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
      ),
    );
  }
}
