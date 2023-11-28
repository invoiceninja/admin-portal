// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

// Package imports:
import 'package:file_picker/file_picker.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_selectors.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/blank_screen.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
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
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyDetails extends StatefulWidget {
  const CompanyDetails({
    Key? key,
    required this.viewModel,
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
  TabController? _controller;
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
  final _purchaseOrderTermsController = TextEditingController();
  final _purchaseOrderFooterController = TextEditingController();
  final _qrIbanController = TextEditingController();
  final _besrIdController = TextEditingController();

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
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));
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
      _purchaseOrderFooterController,
      _purchaseOrderTermsController,
      _qrIbanController,
      _besrIdController,
    ];

    _controllers.forEach(
        (dynamic controller) => controller.removeListener(_onSettingsChanged));

    final viewModel = widget.viewModel;
    final settings = viewModel.settings;

    _nameController.text = settings.name ?? '';
    _idNumberController.text = settings.idNumber ?? '';
    _vatNumberController.text = settings.vatNumber ?? '';
    _emailController.text = settings.email ?? '';
    _websiteController.text = settings.website ?? '';
    _phoneController.text = settings.phone ?? '';
    _address1Controller.text = settings.address1 ?? '';
    _address2Controller.text = settings.address2 ?? '';
    _cityController.text = settings.city ?? '';
    _stateController.text = settings.state ?? '';
    _postalCodeController.text = settings.postalCode ?? '';
    _custom1Controller.text = settings.customValue1 ?? '';
    _custom2Controller.text = settings.customValue2 ?? '';
    _custom3Controller.text = settings.customValue3 ?? '';
    _custom4Controller.text = settings.customValue4 ?? '';
    _invoiceTermsController.text = settings.defaultInvoiceTerms ?? '';
    _invoiceFooterController.text = settings.defaultInvoiceFooter ?? '';
    _quoteTermsController.text = settings.defaultQuoteTerms ?? '';
    _quoteFooterController.text = settings.defaultQuoteFooter ?? '';
    _creditFooterController.text = settings.defaultCreditFooter ?? '';
    _creditTermsController.text = settings.defaultCreditTerms ?? '';
    _purchaseOrderFooterController.text =
        settings.defaultPurchaseOrderFooter ?? '';
    _purchaseOrderTermsController.text =
        settings.defaultPurchaseOrderTerms ?? '';
    _qrIbanController.text = settings.qrIban ?? '';
    _besrIdController.text = settings.besrId ?? '';

    _controllers.forEach(
        (dynamic controller) => controller.addListener(_onSettingsChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onSettingsChanged);
      controller.dispose();
    });
    super.dispose();
  }

  void _onSettingsChanged() {
    final name = _nameController.text.trim();
    final idNumber = _idNumberController.text.trim();
    final vatNumber = _vatNumberController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final website = _websiteController.text.trim();
    final address1 = _address1Controller.text.trim();
    final address2 = _address2Controller.text.trim();
    final city = _cityController.text.trim();
    final state = _stateController.text.trim();
    final postalCode = _postalCodeController.text.trim();
    final customValue1 = _custom1Controller.text.trim();
    final customValue2 = _custom2Controller.text.trim();
    final customValue3 = _custom3Controller.text.trim();
    final customValue4 = _custom4Controller.text.trim();
    final defaultInvoiceFooter = _invoiceFooterController.text.trim();
    final defaultInvoiceTerms = _invoiceTermsController.text.trim();
    final defaultQuoteFooter = _quoteFooterController.text.trim();
    final defaultQuoteTerms = _quoteTermsController.text.trim();
    final defaultCreditFooter = _creditFooterController.text.trim();
    final defaultCreditTerms = _creditTermsController.text.trim();
    final defaultPurchaseOrderFooter =
        _purchaseOrderFooterController.text.trim();
    final defaultPurchaseOrderTerms = _purchaseOrderTermsController.text.trim();
    final qrIban = _qrIbanController.text.trim();
    final besrId = _besrIdController.text.trim();

    final viewModel = widget.viewModel;
    final isFiltered = viewModel.state.settingsUIState.isFiltered;
    final settings = viewModel.settings.rebuild((b) => b
      ..name = isFiltered && name.isEmpty ? null : name
      ..idNumber = isFiltered && idNumber.isEmpty ? null : idNumber
      ..vatNumber = isFiltered && vatNumber.isEmpty ? null : vatNumber
      ..phone = isFiltered && phone.isEmpty ? null : phone
      ..email = isFiltered && email.isEmpty ? null : email
      ..website = isFiltered && website.isEmpty ? null : website
      ..address1 = isFiltered && address1.isEmpty ? null : address1
      ..address2 = isFiltered && address2.isEmpty ? null : address2
      ..city = isFiltered && city.isEmpty ? null : city
      ..state = isFiltered && state.isEmpty ? null : state
      ..postalCode = isFiltered && postalCode.isEmpty ? null : postalCode
      ..customValue1 = isFiltered && customValue1.isEmpty ? null : customValue1
      ..customValue2 = isFiltered && customValue2.isEmpty ? null : customValue2
      ..customValue3 = isFiltered && customValue3.isEmpty ? null : customValue3
      ..customValue4 = isFiltered && customValue4.isEmpty ? null : customValue4
      ..defaultInvoiceFooter = isFiltered && defaultInvoiceFooter.isEmpty
          ? null
          : defaultInvoiceFooter
      ..defaultInvoiceTerms =
          isFiltered && defaultInvoiceTerms.isEmpty ? null : defaultInvoiceTerms
      ..defaultQuoteFooter =
          isFiltered && defaultQuoteFooter.isEmpty ? null : defaultQuoteFooter
      ..defaultQuoteTerms =
          isFiltered && defaultQuoteTerms.isEmpty ? null : defaultQuoteTerms
      ..defaultCreditFooter =
          isFiltered && defaultCreditFooter.isEmpty ? null : defaultCreditFooter
      ..defaultCreditTerms =
          isFiltered && defaultCreditTerms.isEmpty ? null : defaultCreditTerms
      ..defaultPurchaseOrderFooter =
          isFiltered && defaultPurchaseOrderFooter.isEmpty
              ? null
              : defaultPurchaseOrderFooter
      ..defaultPurchaseOrderTerms =
          isFiltered && defaultPurchaseOrderTerms.isEmpty
              ? null
              : defaultPurchaseOrderTerms
      ..qrIban = isFiltered && qrIban.isEmpty ? null : qrIban
      ..besrId = isFiltered && besrId.isEmpty ? null : besrId);
    if (settings != widget.viewModel.settings) {
      _debouncer.run(() {
        widget.viewModel.onSettingsChanged(settings);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final settings = viewModel.settings;

    if (!state.userCompany.isAdmin) {
      return BlankScreen();
    }

    return EditScaffold(
      title: localization!.companyDetails,
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
              text: state.company.documents.isEmpty
                  ? localization.documents
                  : '${localization.documents} (${state.company.documents.length})',
            ),
        ],
      ),
      body: AppTabForm(
        focusNode: _focusNode,
        formKey: _formKey,
        tabController: _controller,
        children: <Widget>[
          ScrollableListView(
            primary: true,
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  DecoratedFormField(
                    label: state.settingsUIState.isFiltered
                        ? localization.companyName
                        : localization.name,
                    controller: _nameController,
                    /*
                    validator: (val) => val.isEmpty || val.trim().isEmpty
                        ? localization.pleaseEnterAName
                        : null,
                        */
                    onSavePressed: viewModel.onSavePressed,
                    keyboardType: TextInputType.text,
                  ),
                  DecoratedFormField(
                    label: localization.idNumber,
                    controller: _idNumberController,
                    onSavePressed: viewModel.onSavePressed,
                    keyboardType: TextInputType.text,
                  ),
                  DecoratedFormField(
                    label: localization.vatNumber,
                    controller: _vatNumberController,
                    onSavePressed: viewModel.onSavePressed,
                    keyboardType: TextInputType.text,
                  ),
                  AppDropdownButton<String>(
                    labelText: localization.classification,
                    showBlank: true,
                    value: settings.classification,
                    onChanged: (dynamic value) {
                      viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..classification = value));
                    },
                    items: kTaxClassifications
                        .map((classification) => DropdownMenuItem(
                              child: Text(localization.lookup(classification)),
                              value: classification,
                            ))
                        .toList(),
                  ),
                  DecoratedFormField(
                    label: localization.website,
                    controller: _websiteController,
                    onSavePressed: viewModel.onSavePressed,
                    keyboardType: TextInputType.url,
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
              if (company.supportsQrIban)
                FormCard(
                  children: [
                    DecoratedFormField(
                      label: localization.qrIban,
                      controller: _qrIbanController,
                      onSavePressed: viewModel.onSavePressed,
                      keyboardType: TextInputType.text,
                    ),
                    DecoratedFormField(
                      label: localization.besrId,
                      controller: _besrIdController,
                      onSavePressed: viewModel.onSavePressed,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              if (!state.settingsUIState.isFiltered)
                FormCard(
                  isLast: true,
                  children: <Widget>[
                    AppDropdownButton(
                      value: company.sizeId,
                      labelText: localization.size,
                      items: memoizedSizeList(state.staticState.sizeMap)
                          .map((sizeId) => DropdownMenuItem(
                                child: Text(
                                    state.staticState.sizeMap[sizeId]!.name),
                                value: sizeId,
                              ))
                          .toList(),
                      onChanged: (dynamic sizeId) => viewModel.onCompanyChanged(
                        company.rebuild((b) => b..sizeId = sizeId),
                      ),
                      showBlank: true,
                    ),
                    EntityDropdown(
                      entityType: EntityType.industry,
                      entityList:
                          memoizedIndustryList(state.staticState.industryMap),
                      labelText: localization.industry,
                      entityId: company.industryId,
                      onSelected: (SelectableEntity? industry) =>
                          viewModel.onCompanyChanged(
                        company
                            .rebuild((b) => b..industryId = industry?.id ?? ''),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          AutofillGroup(
            child: ScrollableListView(
              primary: true,
              children: <Widget>[
                FormCard(
                  isLast: true,
                  children: <Widget>[
                    DecoratedFormField(
                      label: localization.address1,
                      controller: _address1Controller,
                      autofillHints: [AutofillHints.streetAddressLine1],
                      onSavePressed: viewModel.onSavePressed,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    DecoratedFormField(
                      label: localization.address2,
                      controller: _address2Controller,
                      autofillHints: [AutofillHints.streetAddressLine2],
                      onSavePressed: viewModel.onSavePressed,
                      keyboardType: TextInputType.text,
                    ),
                    DecoratedFormField(
                      label: localization.city,
                      controller: _cityController,
                      onSavePressed: viewModel.onSavePressed,
                      autofillHints: [AutofillHints.addressCity],
                      keyboardType: TextInputType.text,
                    ),
                    DecoratedFormField(
                      label: localization.state,
                      controller: _stateController,
                      onSavePressed: viewModel.onSavePressed,
                      autofillHints: [AutofillHints.addressState],
                      keyboardType: TextInputType.text,
                    ),
                    DecoratedFormField(
                      label: localization.postalCode,
                      controller: _postalCodeController,
                      onSavePressed: viewModel.onSavePressed,
                      autofillHints: [AutofillHints.postalCode],
                      keyboardType: TextInputType.text,
                    ),
                    EntityDropdown(
                      entityType: EntityType.country,
                      entityList:
                          memoizedCountryList(state.staticState.countryMap),
                      labelText: localization.country,
                      entityId: settings.countryId,
                      onSelected: (SelectableEntity? country) =>
                          viewModel.onSettingsChanged(settings
                              .rebuild((b) => b..countryId = country?.id)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ScrollableListView(
              primary: true,
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
                              label: localization.delete.toUpperCase(),
                              iconData: Icons.delete,
                              onPressed: () {
                                if (state.settingsUIState.isChanged) {
                                  showMessageDialog(
                                      message:
                                          localization.errorUnsavedChanges);
                                  return;
                                }

                                confirmCallback(
                                    context: context,
                                    callback: (_) =>
                                        viewModel.onDeleteLogo(context));
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                        Expanded(
                          child: AppButton(
                            width: double.infinity,
                            label: localization.uploadLogo.toUpperCase(),
                            iconData: Icons.cloud_upload,
                            onPressed: () async {
                              if (state.settingsUIState.isChanged) {
                                showMessageDialog(
                                    message: localization.errorUnsavedChanges);
                                return;
                              }

                              final multipartFiles = await pickFiles(
                                fileIndex: 'company_logo',
                                fileType: FileType.image,
                                allowMultiple: false,
                              );
                              if (multipartFiles != null &&
                                  multipartFiles.isNotEmpty) {
                                viewModel.onUploadLogo(
                                    navigatorKey.currentContext!,
                                    multipartFiles.first);
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
                      // Fix for CORS error using 'object' subdomain
                      child: (state.isHosted && kIsWeb)
                          ? CachedImage(
                              width: double.infinity,
                              url: state.credentials.url+
                                  '/companies/' +
                                  company.id +
                                  '/logo',
                              apiToken: state.userCompany.token.token,
                            )
                          : CachedImage(
                              width: double.infinity,
                              url: company.settings.companyLogo,
                            )),
              ],
            ),
          ),
          ScrollableListView(
            primary: true,
            children: <Widget>[
              FormCard(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (company.isModuleEnabled(EntityType.invoice))
                    AppDropdownButton<String>(
                      showBlank: true,
                      labelText: localization.invoicePaymentTerms,
                      items: memoizedDropdownPaymentTermList(
                              state.paymentTermState.map,
                              state.paymentTermState.list)
                          .map((paymentTermId) {
                        final paymentTerm =
                            state.paymentTermState.map[paymentTermId]!;
                        return DropdownMenuItem<String>(
                          child: Text(paymentTerm.numDays == 0
                              ? localization.dueOnReceipt
                              : paymentTerm.name),
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
                      showBlank: true,
                      labelText: localization.quoteValidUntil,
                      items: memoizedDropdownPaymentTermList(
                              state.paymentTermState.map,
                              state.paymentTermState.list)
                          .map((paymentTermId) {
                        final paymentTerm =
                            state.paymentTermState.map[paymentTermId]!;
                        return DropdownMenuItem<String>(
                          child: Text(paymentTerm.numDays == 0
                              ? localization.dueOnReceipt
                              : paymentTerm.name),
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
                              (b) => b..defaultInvoiceDesignId = value!.id)),
                    ),
                  if (company.isModuleEnabled(EntityType.quote))
                    DesignPicker(
                      label: localization.quoteDesign,
                      initialValue: settings.defaultQuoteDesignId,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..defaultQuoteDesignId = value!.id)),
                    ),
                  if (company.isModuleEnabled(EntityType.credit))
                    DesignPicker(
                      label: localization.creditDesign,
                      initialValue: settings.defaultCreditDesignId,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..defaultCreditDesignId = value!.id)),
                    ),
                  if (company.isModuleEnabled(EntityType.purchaseOrder))
                    DesignPicker(
                      label: localization.purchaseOrder,
                      initialValue: settings.defaultPurchaseOrderDesignId,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) =>
                              b..defaultPurchaseOrderDesignId = value!.id)),
                    ),
                ]),
              if (!state.settingsUIState.isFiltered)
                FormCard(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      BoolDropdownButton(
                        value: company.useQuoteTermsOnConversion,
                        onChanged: (value) => viewModel.onCompanyChanged(
                            company.rebuild(
                                (b) => b..useQuoteTermsOnConversion = value)),
                        label: localization.useQuoteTerms,
                        helpLabel: localization.useQuoteTermsHelp,
                        iconData: getEntityIcon(EntityType.quote),
                      ),
                    ]),
              FormCard(
                isLast: true,
                children: <Widget>[
                  if (company.isModuleEnabled(EntityType.invoice)) ...[
                    DecoratedFormField(
                      label: localization.invoiceTerms,
                      controller: _invoiceTermsController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                    DecoratedFormField(
                      label: localization.invoiceFooter,
                      controller: _invoiceFooterController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                  if (company.isModuleEnabled(EntityType.quote)) ...[
                    DecoratedFormField(
                      label: localization.quoteTerms,
                      controller: _quoteTermsController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                    DecoratedFormField(
                      label: localization.quoteFooter,
                      controller: _quoteFooterController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                  if (company.isModuleEnabled(EntityType.credit)) ...[
                    DecoratedFormField(
                      label: localization.creditTerms,
                      controller: _creditTermsController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                    DecoratedFormField(
                      label: localization.creditFooter,
                      controller: _creditFooterController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                  if (company.isModuleEnabled(EntityType.purchaseOrder)) ...[
                    DecoratedFormField(
                      label: localization.purchaseOrderTerms,
                      controller: _purchaseOrderTermsController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                    DecoratedFormField(
                      label: localization.purchaseOrderFooter,
                      controller: _purchaseOrderFooterController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                ],
              )
            ],
          ),
          if (!state.settingsUIState.isFiltered)
            DocumentGrid(
              documents: state.company.documents.toList(),
              onUploadDocument: (path, isPrivate) =>
                  viewModel.onUploadDocuments(context, path, isPrivate),
              onRenamedDocument: () => store.dispatch(RefreshData()),
            ),
        ],
      ),
    );
  }
}
