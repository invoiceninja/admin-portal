// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/client_portal_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ClientPortal extends StatefulWidget {
  const ClientPortal({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ClientPortalVM viewModel;

  @override
  _ClientPortalState createState() => _ClientPortalState();
}

class _ClientPortalState extends State<ClientPortal>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_clientPortal');
  final FocusScopeNode _focusNode = FocusScopeNode();
  TabController? _controller;

  final _webClient = WebClient();
  bool _isSubdomainUnique = true;
  bool _isCheckingSubdomain = false;

  final _subdomainDebouncer =
      SimpleDebouncer(milliseconds: kMillisecondsToDebounceSave);
  final _debouncer = Debouncer();

  final _subdomainController = TextEditingController();
  final _portalDomainController = TextEditingController();
  final _customCssController = TextEditingController();
  final _customJavaScriptController = TextEditingController();
  final _customHeaderController = TextEditingController();
  final _customFooterController = TextEditingController();
  final _customMessageDashboard = TextEditingController();
  final _customMessageUnpaidInvoice = TextEditingController();
  final _customMessagePaidInvoice = TextEditingController();
  final _customMessageUnapprovedQuote = TextEditingController();
  final _termsController = TextEditingController();
  final _privacyController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    final settingsUIState = widget.viewModel.state.settingsUIState;
    _controller = TabController(
        vsync: this,
        length: settingsUIState.isFiltered ? 4 : 5,
        initialIndex: settingsUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));
  }

  void _validateSubdomain() {
    setState(() => _isSubdomainUnique = false);

    _subdomainDebouncer.run(() {
      final subdomain = _subdomainController.text.trim();
      final store = StoreProvider.of<AppState>(context);
      final state = store.state;
      final credentials = state.credentials;
      final url = '${credentials.url}/check_subdomain';

      if (subdomain.isEmpty) {
        return;
      }

      if (subdomain == state.company.subdomain) {
        setState(() => _isSubdomainUnique = true);
        return;
      }

      setState(() => _isCheckingSubdomain = true);

      _webClient
          .post(url, credentials.token,
              data: jsonEncode(
                {'subdomain': subdomain},
              ))
          .then((dynamic data) {
        setState(() {
          _isSubdomainUnique = true;
          _isCheckingSubdomain = false;
          _onChanged();
        });
      }).catchError((Object error) {
        setState(() {
          _isSubdomainUnique = false;
          _isCheckingSubdomain = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _subdomainController,
      _portalDomainController,
      _customCssController,
      _customJavaScriptController,
      _customMessageDashboard,
      _customMessageUnpaidInvoice,
      _customMessagePaidInvoice,
      _customMessageUnapprovedQuote,
      _termsController,
      _privacyController,
      _customHeaderController,
      _customFooterController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final company = widget.viewModel.company;
    final settings = widget.viewModel.settings;
    _portalDomainController.text = company.portalDomain;
    _subdomainController.text = company.subdomain;
    _customMessageDashboard.text = settings.customMessageDashboard ?? '';
    _customMessagePaidInvoice.text = settings.customMessagePaidInvoice ?? '';
    _customMessageUnpaidInvoice.text =
        settings.customMessageUnpaidInvoice ?? '';
    _customMessageUnapprovedQuote.text =
        settings.customMessageUnapprovedQuote ?? '';
    _privacyController.text = settings.clientPortalPrivacy ?? '';
    _termsController.text = settings.clientPortalTerms ?? '';
    _customHeaderController.text = settings.clientPortalCustomHeader ?? '';
    _customFooterController.text = settings.clientPortalCustomFooter ?? '';
    _customCssController.text = settings.clientPortalCustomCss ?? '';
    _customJavaScriptController.text = settings.clientPortalCustomJs ?? '';

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      final portalDomain = _portalDomainController.text.trim();
      final subdomain = _subdomainController.text.trim();
      final customMessageDashboard = _customMessageDashboard.text.trim();
      final customMessageUnpaidInvoice =
          _customMessageUnpaidInvoice.text.trim();
      final customMessagePaidInvoice = _customMessagePaidInvoice.text.trim();
      final customMessageUnapprovedQuote =
          _customMessageUnapprovedQuote.text.trim();
      final clientPortalTerms = _termsController.text.trim();
      final clientPortalPrivacy = _privacyController.text.trim();
      final clientPortalCustomJs = _customJavaScriptController.text.trim();
      final clientPortalCustomCss = _customCssController.text.trim();
      final clientPortalCustomHeader = _customHeaderController.text.trim();
      final clientPortalCustomFooter = _customFooterController.text.trim();

      final viewModel = widget.viewModel;
      final isFiltered = viewModel.state.settingsUIState.isFiltered;

      final company = widget.viewModel.company.rebuild((b) => b
        ..portalDomain =
            isFiltered && portalDomain.isEmpty ? null : portalDomain
        ..subdomain = isFiltered && subdomain.isEmpty ? null : subdomain);

      if (company != widget.viewModel.company) {
        widget.viewModel.onCompanyChanged(company);
      }

      final settings = widget.viewModel.settings.rebuild((b) => b
        ..customMessageDashboard = isFiltered && customMessageDashboard.isEmpty
            ? null
            : customMessageDashboard
        ..customMessageUnpaidInvoice =
            isFiltered && customMessageUnpaidInvoice.isEmpty
                ? null
                : customMessageUnpaidInvoice
        ..customMessagePaidInvoice =
            isFiltered && customMessagePaidInvoice.isEmpty
                ? null
                : customMessagePaidInvoice
        ..customMessageUnapprovedQuote =
            isFiltered && customMessageUnapprovedQuote.isEmpty
                ? null
                : customMessageUnapprovedQuote
        ..clientPortalTerms =
            isFiltered && clientPortalTerms.isEmpty ? null : clientPortalTerms
        ..clientPortalPrivacy = isFiltered && clientPortalPrivacy.isEmpty
            ? null
            : clientPortalPrivacy
        ..clientPortalCustomJs = isFiltered && clientPortalCustomJs.isEmpty
            ? null
            : clientPortalCustomJs
        ..clientPortalCustomCss = isFiltered && clientPortalCustomCss.isEmpty
            ? null
            : clientPortalCustomCss
        ..clientPortalCustomHeader =
            isFiltered && clientPortalCustomHeader.isEmpty
                ? null
                : clientPortalCustomHeader
        ..clientPortalCustomFooter =
            isFiltered && clientPortalCustomFooter.isEmpty
                ? null
                : clientPortalCustomFooter);
      if (settings != widget.viewModel.settings) {
        widget.viewModel.onSettingsChanged(settings);
      }
    });
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid || _isCheckingSubdomain) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final settings = viewModel.settings;
    final loginUrl = clientPortalUrlSelector(state);
    final registrationUrl = clientPortalUrlSelector(state, route: 'register');

    return EditScaffold(
      title: localization.clientPortal,
      onSavePressed: (context) => _onSavePressed(context),
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.settings,
          ),
          if (!state.settingsUIState.isFiltered)
            Tab(
              text: localization.registration,
            ),
          Tab(
            text: localization.authorization,
          ),
          Tab(
            text: localization.messages,
          ),
          Tab(
            text: localization.customize,
          ),
        ],
      ),
      body: AppTabForm(
        tabController: _controller,
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          ScrollableListView(
            children: <Widget>[
              if (!state.settingsUIState.isFiltered)
                FormCard(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (state.isHosted)
                      AppDropdownButton<String>(
                        labelText: localization.portalMode,
                        value: viewModel.company.portalMode,
                        onChanged: (dynamic value) =>
                            viewModel.onCompanyChanged(viewModel.company
                                .rebuild((b) => b..portalMode = value)),
                        items: [
                          DropdownMenuItem(
                            child: Text(localization.subdomain),
                            value: kClientPortalModeSubdomain,
                          ),
                          /*
                        DropdownMenuItem(
                          child: Text('iFrame'),
                          value: kClientPortalModeIFrame,
                        ),
                        */
                          DropdownMenuItem(
                            child: Text(localization.domain),
                            value: kClientPortalModeDomain,
                          ),
                        ],
                      ),
                    if (state.isHosted &&
                        company.portalMode == kClientPortalModeSubdomain) ...[
                      DecoratedFormField(
                        label: localization.subdomain,
                        controller: _subdomainController,
                        keyboardType: TextInputType.text,
                        hint: localization.subdomainHelp,
                        validator: (value) {
                          if (value.isEmpty) {
                            return localization.pleaseEnterAValue;
                          } else if (!_isCheckingSubdomain &&
                              !_isSubdomainUnique) {
                            return localization.subdomainIsNotAvailable;
                          }

                          return null;
                        },
                        suffixIcon: Icon(_isCheckingSubdomain
                            ? Icons.pending_outlined
                            : _isSubdomainUnique
                                ? Icons.check_circle_outline
                                : Icons.error_outline),
                        onChanged: (value) => _validateSubdomain(),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-z0-9\-]'),
                          ),
                        ],
                      ),
                    ] else ...[
                      DecoratedFormField(
                        enabled: state.isEnterprisePlan,
                        label: company.portalMode == kClientPortalModeDomain ||
                                state.isSelfHosted
                            ? localization.domainUrl
                            : localization.iFrameUrl,
                        controller: _portalDomainController,
                        hint: state.isSelfHosted
                            ? localization.clientPortalDomainHint
                            : '',
                        keyboardType: TextInputType.url,
                        validator: (val) =>
                            (val.isEmpty || val.trim().isEmpty) &&
                                    state.isHosted
                                ? localization.pleaseEnterAValue
                                : null,
                        onSavePressed: _onSavePressed,
                      ),
                      SizedBox(height: 16),
                      if (state.isEnterprisePlan)
                        if (company.portalMode == kClientPortalModeDomain &&
                            state.isHosted)
                          OutlinedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconText(
                                icon: MdiIcons.openInNew,
                                text: localization.viewDocs.toUpperCase(),
                              ),
                            ),
                            onPressed: () =>
                                launchUrl(Uri.parse(kDocsCustomDomainUrl)),
                          )
                        else
                          SizedBox()
                      else
                        Text(localization.requiresAnEnterprisePlan)
                    ],
                    SizedBox(height: 16),
                    ListTile(
                      title: Text(localization.loginUrl),
                      subtitle: Text(
                        loginUrl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Icon(Icons.content_copy),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: loginUrl));
                        showToast(localization.copiedToClipboard
                            .replaceFirst(':value ', loginUrl));
                      },
                    ),
                  ],
                ),
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.clientPortal,
                    value: settings.enablePortal,
                    iconData: MdiIcons.cloud,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..enablePortal = value)),
                  ),
                  /*
                  BoolDropdownButton(
                    label: localization.dashboard,
                    value: settings.enablePortalDashboard,
                    iconData: getEntityIcon(EntityType.dashboard),
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..enablePortalDashboard = value)),
                  ),
                  */
                  BoolDropdownButton(
                      label: localization.clientDocumentUpload,
                      helpLabel: localization.documentUploadHelp,
                      value: settings.enableClientPortalUploads,
                      iconData: MdiIcons.upload,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..enableClientPortalUploads = value))),
                  if (company.isModuleEnabled(EntityType.vendor))
                    BoolDropdownButton(
                        label: localization.vendorDocumentUpload,
                        helpLabel: localization.vendorDocumentUploadHelp,
                        value: settings.enableVendorPortalUploads,
                        iconData: MdiIcons.upload,
                        onChanged: (value) => viewModel.onSettingsChanged(
                            settings.rebuild(
                                (b) => b..enableVendorPortalUploads = value))),
                  if (company.isModuleEnabled(EntityType.purchaseOrder) &&
                      company.isModuleEnabled(EntityType.quote))
                    BoolDropdownButton(
                        label: localization.acceptPurchaseOrderNumber,
                        helpLabel: localization.acceptPurchaseOrderNumberHelp,
                        value: settings.acceptPurchaseOrderNumber,
                        iconData: Icons.numbers,
                        onChanged: (value) => viewModel.onSettingsChanged(
                            settings.rebuild(
                                (b) => b..acceptPurchaseOrderNumber = value))),
                  if (!state.settingsUIState.isFiltered)
                    BoolDropdownButton(
                      label: localization.storefront,
                      helpLabel: localization.storefrontHelp,
                      value: company.enableShopApi,
                      iconData: MdiIcons.shopping,
                      onChanged: (value) => viewModel.onCompanyChanged(
                          company.rebuild((b) => b..enableShopApi = value)),
                    ),
                  if (!state.isDemo && state.company.enableShopApi) ...[
                    SizedBox(height: 16),
                    ListDivider(),
                    ListTile(
                      title: Text(localization.companyKey),
                      subtitle: Text(
                        company.companyKey,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Icon(Icons.content_copy),
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: company.companyKey));
                        showToast(localization.copiedToClipboard
                            .replaceFirst(':value ', company.companyKey));
                      },
                    ),
                  ],
                ],
              ),
              FormCard(
                isLast: true,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecoratedFormField(
                    controller: _termsController,
                    label: localization.termsOfService,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                  DecoratedFormField(
                    controller: _privacyController,
                    label: localization.privacyPolicy,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              )
            ],
          ),
          if (!state.settingsUIState.isFiltered)
            ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    BoolDropdownButton(
                      label: localization.clientRegistration,
                      helpLabel: localization.clientRegistrationHelp,
                      value: company.clientCanRegister,
                      iconData: MdiIcons.login,
                      onChanged: (value) => viewModel.onCompanyChanged(
                          company.rebuild((b) => b..clientCanRegister = value)),
                    ),
                    if (state.company.clientCanRegister) ...[
                      SizedBox(height: 16),
                      ListTile(
                        title: Text(localization.registrationUrl),
                        subtitle: Text(
                          registrationUrl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Icon(Icons.content_copy),
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: registrationUrl));
                          showToast(localization.copiedToClipboard
                              .replaceFirst(':value ', registrationUrl));
                        },
                      ),
                    ],
                  ],
                ),
                FormCard(
                  isLast: true,
                  children: company.clientRegistrationFields.map((field) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(localization.lookup(field.key)),
                        ),
                        Expanded(
                          child: AppDropdownButton<String>(
                            value: field.setting,
                            onChanged: (dynamic value) {
                              final index = company.clientRegistrationFields
                                  .indexOf(field);
                              viewModel.onCompanyChanged(company.rebuild((b) =>
                                  b
                                    ..clientRegistrationFields[index] =
                                        field.rebuild((b) => b
                                          ..required = value ==
                                              RegistrationFieldEntity
                                                  .SETTING_REQUIRED
                                          ..visible = value ==
                                                  RegistrationFieldEntity
                                                      .SETTING_REQUIRED ||
                                              value ==
                                                  RegistrationFieldEntity
                                                      .SETTING_OPTIONAL)));
                            },
                            items: [
                              DropdownMenuItem(
                                value: RegistrationFieldEntity.SETTING_HIDDEN,
                                child: Text(localization.hidden),
                              ),
                              DropdownMenuItem(
                                value: RegistrationFieldEntity.SETTING_OPTIONAL,
                                child: Text(localization.optional),
                              ),
                              DropdownMenuItem(
                                value: RegistrationFieldEntity.SETTING_REQUIRED,
                                child: Text(localization.requiredWord),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ScrollableListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.enablePortalPassword,
                    helpLabel: localization.enablePortalPasswordHelp,
                    value: settings.enablePortalPassword,
                    iconData: MdiIcons.shield,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..enablePortalPassword = value)),
                  ),
                ],
              ),
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.showAcceptInvoiceTerms,
                    helpLabel: localization.showAcceptInvoiceTermsHelp,
                    value: settings.showAcceptInvoiceTerms,
                    iconData: MdiIcons.checkboxOutline,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..showAcceptInvoiceTerms = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.showAcceptQuoteTerms,
                    helpLabel: localization.showAcceptQuoteTermsHelp,
                    value: settings.showAcceptQuoteTerms,
                    iconData: MdiIcons.checkboxOutline,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..showAcceptQuoteTerms = value)),
                  ),
                ],
              ),
              FormCard(
                isLast: true,
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.requireInvoiceSignature,
                    helpLabel: localization.requireInvoiceSignatureHelp,
                    value: settings.requireInvoiceSignature,
                    iconData: MdiIcons.signature,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..requireInvoiceSignature = value)),
                  ),
                  if (company.isModuleEnabled(EntityType.quote))
                    BoolDropdownButton(
                      label: localization.requireQuoteSignature,
                      helpLabel: localization.requireInvoiceSignatureHelp,
                      value: settings.requireQuoteSignature,
                      iconData: MdiIcons.signature,
                      onChanged: (value) => viewModel.onSettingsChanged(settings
                          .rebuild((b) => b..requireQuoteSignature = value)),
                    ),
                  if (company.isModuleEnabled(EntityType.purchaseOrder))
                    BoolDropdownButton(
                      label: localization.requirePurchaseOrderSignature,
                      helpLabel: localization.requirePurchaseOrderSignatureHelp,
                      value: settings.requirePurchaseOrderSignature,
                      iconData: MdiIcons.signature,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..requirePurchaseOrderSignature = value)),
                    ),
                  BoolDropdownButton(
                    label: localization.signatureOnPdf,
                    helpLabel: localization.signatureOnPdfHelp,
                    value: settings.signatureOnPdf,
                    iconData: getEntityIcon(EntityType.invoice),
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..signatureOnPdf = value)),
                  ),
                ],
              ),
            ],
          ),
          ScrollableListView(
            children: <Widget>[
              FormCard(
                isLast: true,
                children: <Widget>[
                  /*
                  DecoratedFormField(
                    controller: _customMessageDashboard,
                    label: localization.dashboard,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                  */
                  DecoratedFormField(
                    controller: _customMessageUnpaidInvoice,
                    label: localization.unpaidInvoice,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                  DecoratedFormField(
                    controller: _customMessagePaidInvoice,
                    label: localization.paidInvoice,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                  DecoratedFormField(
                    controller: _customMessageUnapprovedQuote,
                    label: localization.unapprovedQuote,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
            ],
          ),
          ScrollableListView(
            children: <Widget>[
              FormCard(
                isLast: true,
                children: <Widget>[
                  DecoratedFormField(
                    label: localization.header,
                    controller: _customHeaderController,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                  DecoratedFormField(
                    label: localization.footer,
                    controller: _customFooterController,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                  DecoratedFormField(
                    label: localization.customCss,
                    controller: _customCssController,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                  ),
                  if (isSelfHosted(context))
                    DecoratedFormField(
                      label: localization.customJavascript,
                      controller: _customJavaScriptController,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
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
