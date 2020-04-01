import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/resources/cached_image.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

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
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_companyDetails');

  final FocusScopeNode _focusNode = FocusScopeNode();
  TabController _controller;
  bool autoValidate = false;
  final _debouncer = Debouncer();

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
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();
  final _invoiceTermsController = TextEditingController();
  final _invoiceFooterController = TextEditingController();
  final _quoteTermsController = TextEditingController();
  final _quoteFooterController = TextEditingController();
  final _creditTermsController = TextEditingController();
  final _creditFooterController = TextEditingController();

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
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
      _invoiceFooterController,
      _invoiceTermsController,
      _quoteFooterController,
      _quoteTermsController,
      _creditFooterController,
      _creditTermsController,
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
    _paymentTermsController.text =
        settings.defaultPaymentTerms == kPaymentTermsOff
            ? ''
            : formatNumber(settings.defaultPaymentTerms?.toDouble(), context,
                formatNumberType: FormatNumberType.input);
    _custom1Controller.text = settings.customValue1;
    _custom2Controller.text = settings.customValue2;
    _custom3Controller.text = settings.customValue3;
    _custom4Controller.text = settings.customValue4;
    _invoiceTermsController.text = settings.defaultInvoiceTerms;
    _invoiceFooterController.text = settings.defaultInvoiceFooter;
    _quoteTermsController.text = settings.defaultQuoteTerms;
    _quoteFooterController.text = settings.defaultQuoteFooter;
    _creditFooterController.text = settings.defaultCreditFooter;
    _creditTermsController.text = settings.defaultCreditTerms;

    _controllers.forEach(
        (dynamic controller) => controller.addListener(_onSettingsChanged));

    super.didChangeDependencies();
  }

  void _onSettingsChanged() {
    final state = widget.viewModel.state;
    _debouncer.run(() {
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
        ..defaultTaskRate =
            parseDouble(_taskRateController.text, zeroIsNull: true)
        ..defaultPaymentTerms = _paymentTermsController.text.isEmpty
            ? (state.settingsUIState.entityType == EntityType.company
                ? -1
                : null)
            : parseInt(_paymentTermsController.text)
        ..customValue1 = _custom1Controller.text.trim()
        ..customValue2 = _custom2Controller.text.trim()
        ..customValue3 = _custom3Controller.text.trim()
        ..customValue4 = _custom4Controller.text.trim()
        ..defaultInvoiceFooter = _invoiceFooterController.text.trim()
        ..defaultInvoiceTerms = _invoiceTermsController.text.trim()
        ..defaultQuoteFooter = _quoteFooterController.text.trim()
        ..defaultQuoteTerms = _quoteTermsController.text.trim()
        ..defaultCreditFooter = _creditFooterController.text.trim()
        ..defaultCreditTerms = _creditTermsController.text.trim());
      if (settings != widget.viewModel.settings) {
        widget.viewModel.onSettingsChanged(settings);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final settings = viewModel.settings;

    return EditScaffold(
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
      body: AppTabForm(
        focusNode: _focusNode,
        formKey: _formKey,
        tabController: _controller,
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
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.idNumber,
                    controller: _idNumberController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.vatNumber,
                    controller: _vatNumberController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.website,
                    controller: _websiteController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    //textInputAction: TextInputAction.next,
                    //onFieldSubmitted: (String value) => _node.nextFocus(),
                  ),
                  CustomField(
                    controller: _custom1Controller,
                    field: company.customFields[CustomFieldType.company1],
                    value: settings.customValue1,
                  ),
                  CustomField(
                    controller: _custom2Controller,
                    field: company.customFields[CustomFieldType.company2],
                    value: settings.customValue2,
                  ),
                  CustomField(
                    controller: _custom3Controller,
                    field: company.customFields[CustomFieldType.company3],
                    value: settings.customValue3,
                  ),
                  CustomField(
                    controller: _custom4Controller,
                    field: company.customFields[CustomFieldType.company4],
                    value: settings.customValue4,
                  ),
                ],
              ),
              if (!state.settingsUIState.isFiltered)
                FormCard(
                  children: <Widget>[
                    AppDropdownButton(
                      value: company.sizeId,
                      labelText: localization.size,
                      items: memoizedSizeList(state.staticState.sizeMap)
                          .map((sizeId) => DropdownMenuItem(
                                child: Text(
                                    state.staticState.sizeMap[sizeId].name),
                                value: sizeId,
                              ))
                          .toList(),
                      onChanged: (dynamic sizeId) => viewModel.onCompanyChanged(
                        company.rebuild((b) => b..sizeId = sizeId),
                      ),
                      showBlank: true,
                    ),
                    EntityDropdown(
                      key: ValueKey('__industry_${company.industryId}__'),
                      entityType: EntityType.industry,
                      entityList:
                          memoizedIndustryList(state.staticState.industryMap),
                      labelText: localization.industry,
                      entityId: company.industryId,
                      onSelected: (SelectableEntity industry) =>
                          viewModel.onCompanyChanged(
                        company.rebuild((b) => b..industryId = industry?.id),
                      ),
                      allowClearing: true,
                    ),
                  ],
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                if ('${settings.companyLogo ?? ''}'.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: CachedImage(
                        width: double.infinity,
                        url: settings.companyLogo,
                        //url: '${settings.logoUrl}?clear_cache=${state.selectedCompany.updatedAt}',
                      )),
                Builder(
                  builder: (context) {
                    return Row(
                      children: <Widget>[
                        if ('${settings.companyLogo ?? ''}'.isNotEmpty) ...[
                          Expanded(
                            child: ElevatedButton(
                              width: double.infinity,
                              color: Colors.redAccent,
                              label: localization.delete,
                              iconData: Icons.delete,
                              onPressed: () {
                                confirmCallback(
                                    context: context,
                                    callback: () =>
                                        viewModel.onDeleteLogo(context));
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                        Expanded(
                          child: ElevatedButton(
                            width: double.infinity,
                            label: localization.uploadLogo,
                            iconData: Icons.cloud_upload,
                            onPressed: () async {
                              String path;
                              if (kIsWeb) {
                                path = await webFilePicker();
                              } else {
                                final image = await ImagePicker.pickImage(
                                    source: kReleaseMode
                                        ? ImageSource.gallery
                                        : ImageSource.camera);
                                if (image != null) {
                                  path = image.path;
                                }
                              }
                              if (path != null) {
                                viewModel.onUploadLogo(context, path);
                              }
                            },
                          ),
                        )
                      ],
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
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.address2,
                    controller: _address2Controller,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.city,
                    controller: _cityController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.state,
                    controller: _stateController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  DecoratedFormField(
                    label: localization.postalCode,
                    controller: _postalCodeController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String value) => _focusNode.nextFocus(),
                  ),
                  EntityDropdown(
                    allowClearing: state.settingsUIState.isFiltered,
                    key: ValueKey('__country_${settings.countryId}__'),
                    entityType: EntityType.country,
                    entityList:
                        memoizedCountryList(state.staticState.countryMap),
                    labelText: localization.country,
                    entityId: settings.countryId,
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
                    entityList: memoizedPaymentTypeList(
                        state.staticState.paymentTypeMap),
                    labelText: localization.paymentType,
                    entityId: settings.defaultPaymentTypeId,
                    onSelected: (paymentType) => viewModel.onSettingsChanged(
                        settings.rebuild(
                            (b) => b..defaultPaymentTypeId = paymentType?.id)),
                    allowClearing: true,
                  ),
                  DecoratedFormField(
                    label: localization.paymentTerms,
                    controller: _paymentTermsController,
                    keyboardType: TextInputType.number,
                  ),
                  /* TODO Re-enable with tasks
                  DecoratedFormField(
                    label: localization.taskRate,
                    controller: _taskRateController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                   */
                ],
              ),
              FormCard(
                children: <Widget>[
                  DecoratedFormField(
                    label: localization.invoiceTerms,
                    controller: _invoiceTermsController,
                    maxLines: 4,
                  ),
                  DecoratedFormField(
                    label: localization.invoiceFooter,
                    controller: _invoiceFooterController,
                    maxLines: 4,
                  ),
                  DecoratedFormField(
                    label: localization.quoteTerms,
                    controller: _quoteTermsController,
                    maxLines: 4,
                  ),
                  DecoratedFormField(
                    label: localization.quoteFooter,
                    controller: _quoteFooterController,
                    maxLines: 4,
                  ),
                  DecoratedFormField(
                    label: localization.creditTerms,
                    controller: _creditTermsController,
                    maxLines: 4,
                  ),
                  DecoratedFormField(
                    label: localization.creditFooter,
                    controller: _creditFooterController,
                    maxLines: 4,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
