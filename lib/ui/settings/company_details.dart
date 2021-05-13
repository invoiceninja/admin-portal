import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_selectors.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/blank_screen.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/app/resources/cached_image.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:file_picker/file_picker.dart';

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

    final state = widget.viewModel.state;
    final settingsUIState = state.settingsUIState;

    _controller = TabController(
        vsync: this,
        length: state.settingsUIState.isFiltered ? 4 : 5,
        initialIndex: settingsUIState.tabIndex);
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller.index));
  }

  @override
  void dispose() {
    _controller.removeListener(_onTabChanged);
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
      _debouncer.run(() {
        widget.viewModel.onSettingsChanged(settings);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final settings = viewModel.settings;

    if (!state.userCompany.isAdmin) {
      return BlankScreen();
    }

    return EditScaffold(
      title: localization.companyDetails,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.address,
          ),
          Tab(
            text: localization.logo,
          ),
          Tab(
            text: localization.defaults,
          ),
          if (!state.settingsUIState.isFiltered)
            Tab(
              text: company.documents.isEmpty
                  ? localization.documents
                  : '${localization.documents} (${company.documents.length})',
            ),
        ],
      ),
      body: AppTabForm(
        focusNode: _focusNode,
        formKey: _formKey,
        tabController: _controller,
        children: <Widget>[
          ScrollableListView(
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
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  DecoratedFormField(
                    label: localization.idNumber,
                    controller: _idNumberController,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  DecoratedFormField(
                    label: localization.vatNumber,
                    controller: _vatNumberController,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  DecoratedFormField(
                    label: localization.website,
                    controller: _websiteController,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  DecoratedFormField(
                    label: localization.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  DecoratedFormField(
                    label: localization.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  CustomField(
                    controller: _custom1Controller,
                    field: CustomFieldType.company1,
                    value: settings.customValue1,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  CustomField(
                    controller: _custom2Controller,
                    field: CustomFieldType.company2,
                    value: settings.customValue2,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  CustomField(
                    controller: _custom3Controller,
                    field: CustomFieldType.company3,
                    value: settings.customValue3,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                  CustomField(
                    controller: _custom4Controller,
                    field: CustomFieldType.company4,
                    value: settings.customValue4,
                    onSavePressed: viewModel.onSavePressed,
                  ),
                ],
              ),
              if (!state.settingsUIState.isFiltered)
                FormCard(
                  children: <Widget>[
                    AppDropdownButton(
                      showUseDefault: true,
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
                        company
                            .rebuild((b) => b..industryId = industry?.id ?? ''),
                      ),
                      showUseDefault: state.settingsUIState.isFiltered,
                    ),
                  ],
                ),
            ],
          ),
          AutofillGroup(
            child: ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      label: localization.address1,
                      controller: _address1Controller,
                      autofillHints: [AutofillHints.streetAddressLine1],
                      onSavePressed: viewModel.onSavePressed,
                    ),
                    DecoratedFormField(
                      label: localization.address2,
                      controller: _address2Controller,
                      autofillHints: [AutofillHints.streetAddressLine2],
                      onSavePressed: viewModel.onSavePressed,
                    ),
                    DecoratedFormField(
                      label: localization.city,
                      controller: _cityController,
                      onSavePressed: viewModel.onSavePressed,
                      autofillHints: [AutofillHints.addressCity],
                    ),
                    DecoratedFormField(
                      label: localization.state,
                      controller: _stateController,
                      onSavePressed: viewModel.onSavePressed,
                      autofillHints: [AutofillHints.addressState],
                    ),
                    DecoratedFormField(
                      label: localization.postalCode,
                      controller: _postalCodeController,
                      onSavePressed: viewModel.onSavePressed,
                      autofillHints: [AutofillHints.postalCode],
                    ),
                    EntityDropdown(
                      key: ValueKey('__country_${settings.countryId}__'),
                      entityType: EntityType.country,
                      entityList:
                          memoizedCountryList(state.staticState.countryMap),
                      labelText: localization.country,
                      entityId: settings.countryId,
                      onSelected: (SelectableEntity country) =>
                          viewModel.onSettingsChanged(settings
                              .rebuild((b) => b..countryId = country?.id)),
                      showUseDefault: state.settingsUIState.isFiltered,
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ScrollableListView(
              children: <Widget>[
                Builder(
                  builder: (context) {
                    return Row(
                      children: <Widget>[
                        if ('${settings.companyLogo ?? ''}'.isNotEmpty) ...[
                          Expanded(
                            child: AppButton(
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
                          child: AppButton(
                            width: double.infinity,
                            label: localization.uploadLogo,
                            iconData: Icons.cloud_upload,
                            onPressed: () async {
                              final multipartFile = await pickFile(
                                fileIndex: 'company_logo',
                                fileType: FileType.image,
                              );
                              if (multipartFile != null) {
                                viewModel.onUploadLogo(context, multipartFile);
                              }
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
                if ('${settings.companyLogo ?? ''}'.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CachedImage(
                        width: double.infinity,
                        url: settings.companyLogo,
                      )),
              ],
            ),
          ),
          ScrollableListView(
            children: <Widget>[
              FormCard(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppDropdownButton<String>(
                      labelText: localization.autoBill,
                      value: settings.autoBill,
                      onChanged: (dynamic value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..autoBill = value)),
                      items: [
                        CompanyGatewayEntity.TOKEN_BILLING_ALWAYS,
                        CompanyGatewayEntity.TOKEN_BILLING_OPT_OUT,
                        CompanyGatewayEntity.TOKEN_BILLING_OPT_IN,
                        CompanyGatewayEntity.TOKEN_BILLING_DISABLED
                      ]
                          .map((value) => DropdownMenuItem(
                                child: Text(localization.lookup(value)),
                                value: value,
                              ))
                          .toList()),
                  EntityDropdown(
                    key: ValueKey(
                        '__default_payment_type_${settings.defaultPaymentTypeId}__'),
                    entityType: EntityType.paymentType,
                    entityList: memoizedPaymentTypeList(
                        state.staticState.paymentTypeMap),
                    labelText: localization.paymentType,
                    entityId: settings.defaultPaymentTypeId,
                    onSelected: (paymentType) => viewModel.onSettingsChanged(
                        settings.rebuild(
                            (b) => b..defaultPaymentTypeId = paymentType?.id)),
                    showUseDefault: state.settingsUIState.isFiltered,
                  ),
                  if (company.isModuleEnabled(EntityType.invoice))
                    AppDropdownButton<String>(
                      showUseDefault: true,
                      showBlank: true,
                      labelText: localization.invoicePaymentTerms,
                      items: memoizedDropdownPaymentTermList(
                              state.paymentTermState.map,
                              state.paymentTermState.list)
                          .map((paymentTermId) {
                        final paymentTerm =
                            state.paymentTermState.map[paymentTermId];
                        return DropdownMenuItem<String>(
                          child: Text(paymentTerm.name),
                          value: paymentTerm.numDays.toString(),
                        );
                      }).toList(),
                      value: '${settings.defaultPaymentTerms}',
                      onChanged: (dynamic numDays) {
                        viewModel.onSettingsChanged(settings.rebuild((b) => b
                          ..defaultPaymentTerms =
                              numDays == null ? null : '$numDays'));
                      },
                    ),
                  if (company.isModuleEnabled(EntityType.quote))
                    AppDropdownButton<String>(
                      showUseDefault: true,
                      showBlank: true,
                      labelText: localization.quoteValidUntil,
                      items: memoizedDropdownPaymentTermList(
                              state.paymentTermState.map,
                              state.paymentTermState.list)
                          .map((paymentTermId) {
                        final paymentTerm =
                            state.paymentTermState.map[paymentTermId];
                        return DropdownMenuItem<String>(
                          child: Text(paymentTerm.name),
                          value: paymentTerm.numDays.toString(),
                        );
                      }).toList(),
                      value: '${settings.defaultValidUntil}',
                      onChanged: (dynamic numDays) {
                        viewModel.onSettingsChanged(settings.rebuild((b) => b
                          ..defaultValidUntil =
                              numDays == null ? null : '$numDays'));
                      },
                    ),
                ],
              ),
              if (!state.uiState.settingsUIState.isFiltered)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 16, right: 16),
                  child: AppButton(
                    iconData: Icons.settings,
                    label: localization.configurePaymentTerms.toUpperCase(),
                    onPressed: () =>
                        viewModel.onConfigurePaymentTermsPressed(context),
                  ),
                ),
              if (!state.isProPlan)
                FormCard(children: <Widget>[
                  if (company.isModuleEnabled(EntityType.invoice))
                    DesignPicker(
                      label: localization.invoiceDesign,
                      initialValue: settings.defaultInvoiceDesignId,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..defaultInvoiceDesignId = value.id)),
                    ),
                  if (company.isModuleEnabled(EntityType.quote))
                    DesignPicker(
                      label: localization.quoteDesign,
                      initialValue: settings.defaultQuoteDesignId,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..defaultQuoteDesignId = value.id)),
                    ),
                  if (company.isModuleEnabled(EntityType.credit))
                    DesignPicker(
                      label: localization.creditDesign,
                      initialValue: settings.defaultCreditDesignId,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..defaultCreditDesignId = value.id)),
                    ),
                ]),
              FormCard(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (!state.settingsUIState.isFiltered)
                      BoolDropdownButton(
                        value: settings.clientManualPaymentNotification,
                        onChanged: (value) => viewModel.onSettingsChanged(
                            settings.rebuild((b) =>
                                b..clientManualPaymentNotification = value)),
                        label: localization.manualPaymentEmail,
                        helpLabel: localization.emailReceipt,
                        iconData: Icons.email,
                      ),
                    BoolDropdownButton(
                      value: settings.clientOnlinePaymentNotification,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) =>
                              b..clientOnlinePaymentNotification = value)),
                      label: localization.onlinePaymentEmail,
                      helpLabel: localization.emailReceipt,
                      iconData: Icons.email,
                    ),
                  ]),
              FormCard(
                children: <Widget>[
                  if (company.isModuleEnabled(EntityType.invoice)) ...[
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
                  ],
                  if (company.isModuleEnabled(EntityType.quote)) ...[
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
                  ],
                  if (company.isModuleEnabled(EntityType.credit)) ...[
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
                ],
              )
            ],
          ),
          if (!state.settingsUIState.isFiltered)
            DocumentGrid(
              documents: company.documents.toList(),
              onUploadDocument: (path) =>
                  viewModel.onUploadDocument(context, path),
              onDeleteDocument: (document, password, idToken) => viewModel
                  .onDeleteDocument(context, document, password, idToken),
            ),
        ],
      ),
    );
  }
}
