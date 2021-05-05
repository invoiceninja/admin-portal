import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';

import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/client_portal_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ClientPortal extends StatefulWidget {
  const ClientPortal({
    Key key,
    @required this.viewModel,
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
  TabController _controller;

  bool autoValidate = false;

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
        vsync: this, length: 4, initialIndex: settingsUIState.tabIndex);
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
    _customMessageDashboard.text = settings.customMessageDashboard;
    _customMessagePaidInvoice.text = settings.customMessagePaidInvoice;
    _customMessageUnpaidInvoice.text = settings.customMessageUnpaidInvoice;
    _customMessageUnapprovedQuote.text = settings.customMessageUnapprovedQuote;
    _privacyController.text = settings.clientPortalPrivacy;
    _termsController.text = settings.clientPortalTerms;
    _customHeaderController.text = settings.clientPortalCustomHeader;
    _customFooterController.text = settings.clientPortalCustomFooter;
    _customCssController.text = settings.clientPortalCustomCss;
    _customJavaScriptController.text = settings.clientPortalCustomJs;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      final company = widget.viewModel.company.rebuild((b) => b
        ..portalDomain = _portalDomainController.text.trim()
        ..subdomain = _subdomainController.text.trim());

      if (company != widget.viewModel.company) {
        widget.viewModel.onCompanyChanged(company);
      }

      final settings = widget.viewModel.settings.rebuild((b) => b
        ..customMessageDashboard = _customMessageDashboard.text.trim()
        ..customMessageUnpaidInvoice = _customMessageUnpaidInvoice.text.trim()
        ..customMessagePaidInvoice = _customMessagePaidInvoice.text.trim()
        ..customMessageUnapprovedQuote =
            _customMessageUnapprovedQuote.text.trim()
        ..clientPortalTerms = _termsController.text.trim()
        ..clientPortalPrivacy = _privacyController.text.trim()
        ..clientPortalCustomJs = _customJavaScriptController.text.trim()
        ..clientPortalCustomCss = _customCssController.text.trim()
        ..clientPortalCustomHeader = _customHeaderController.text.trim()
        ..clientPortalCustomFooter = _customFooterController.text.trim());
      if (settings != widget.viewModel.settings) {
        widget.viewModel.onSettingsChanged(settings);
      }
    });
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState.validate();

    setState(() {
      autoValidate = !isValid;
    });

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final settings = viewModel.settings;
    final registrationUrl = portalRegistrationUrlSelector(state);

    return EditScaffold(
      title: localization.clientPortal,
      isAdvancedSettings: true,
      onSavePressed: (context) => _onSavePressed(context),
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: isMobile(context),
        tabs: [
          Tab(
            text: localization.settings,
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
              if (state.isHosted && !state.settingsUIState.isFiltered)
                FormCard(
                  children: <Widget>[
                    AppDropdownButton<String>(
                      labelText: localization.portalMode,
                      value: viewModel.company.portalMode,
                      onChanged: (dynamic value) => viewModel.onCompanyChanged(
                          viewModel.company
                              .rebuild((b) => b..portalMode = value)),
                      items: [
                        DropdownMenuItem(
                          child: Text(localization.subdomain),
                          value: kClientPortalModeSubdomain,
                        ),
                        if (state.isEnterprisePlan)
                          DropdownMenuItem(
                            child: Text(localization.domain),
                            value: kClientPortalModeDomain,
                          ),
                        DropdownMenuItem(
                          child: Text('iFrame'),
                          value: kClientPortalModeIFrame,
                        ),
                      ],
                    ),
                    if (company.portalMode != kClientPortalModeSubdomain)
                      DecoratedFormField(
                        label: company.portalMode == kClientPortalModeDomain
                            ? localization.domainUrl
                            : localization.iFrameUrl,
                        controller: _portalDomainController,
                        keyboardType: TextInputType.url,
                        validator: (val) => val.isEmpty || val.trim().isEmpty
                            ? localization.pleaseEnterAValue
                            : null,
                        onSavePressed: viewModel.onSavePressed,
                      ),
                    DecoratedFormField(
                      label: localization.subdomain,
                      controller: _subdomainController,
                      hint: localization.subdomainHelp,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-z0-9\-]'),
                        ),
                      ],
                      onSavePressed: viewModel.onSavePressed,
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
                    label: localization.tasks,
                    value: settings.enablePortalTasks,
                    iconData: getEntityIcon(EntityType.task),
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..enablePortalTasks = value)),
                  ),
                ],
              ),
              FormCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!state.settingsUIState.isFiltered) ...[
                    BoolDropdownButton(
                      label: localization.clientRegistration,
                      helpLabel: localization.clientRegistrationHelp,
                      value: company.clientCanRegister,
                      iconData: MdiIcons.login,
                      onChanged: (value) => viewModel.onCompanyChanged(
                          company.rebuild((b) => b..clientCanRegister = value)),
                    ),
                    if (state.company.clientCanRegister ?? false) ...[
                      SizedBox(height: 16),
                      ListDivider(),
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
                      ListDivider(),
                    ],
                  ],
                  BoolDropdownButton(
                      label: localization.documentUpload,
                      helpLabel: localization.documentUploadHelp,
                      value: settings.enablePortalUploads,
                      iconData: MdiIcons.upload,
                      onChanged: (value) => viewModel.onSettingsChanged(settings
                          .rebuild((b) => b..enablePortalUploads = value))),
                  BoolDropdownButton(
                    label: localization.storefront,
                    helpLabel: localization.storefrontHelp,
                    value: company.enableShopApi,
                    iconData: MdiIcons.shopping,
                    onChanged: (value) => viewModel.onCompanyChanged(
                        company.rebuild((b) => b..enableShopApi = value)),
                  ),
                  if (!state.isDemo &&
                      (state.company.enableShopApi ?? false)) ...[
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
                    ListDivider(),
                  ],
                  DecoratedFormField(
                    controller: _termsController,
                    label: localization.termsOfService,
                    maxLines: 6,
                  ),
                  DecoratedFormField(
                    controller: _privacyController,
                    label: localization.privacyPolicy,
                    maxLines: 6,
                  ),
                ],
              )
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
                    iconData: MdiIcons.checkBoxOutline,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..showAcceptInvoiceTerms = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.showAcceptQuoteTerms,
                    helpLabel: localization.showAcceptQuoteTermsHelp,
                    value: settings.showAcceptQuoteTerms,
                    iconData: MdiIcons.checkBoxOutline,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..showAcceptQuoteTerms = value)),
                  ),
                ],
              ),
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.requireInvoiceSignature,
                    helpLabel: localization.requireInvoiceSignatureHelp,
                    value: settings.requireInvoiceSignature,
                    iconData: MdiIcons.signature,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..requireInvoiceSignature = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.requireQuoteSignature,
                    helpLabel: localization.requireInvoiceSignatureHelp,
                    value: settings.requireQuoteSignature,
                    iconData: MdiIcons.signature,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..requireQuoteSignature = value)),
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
                children: <Widget>[
                  DecoratedFormField(
                    controller: _customMessageDashboard,
                    label: localization.dashboard,
                    maxLines: 6,
                  ),
                  DecoratedFormField(
                    controller: _customMessageUnpaidInvoice,
                    label: localization.unpaidInvoice,
                    maxLines: 6,
                  ),
                  DecoratedFormField(
                    controller: _customMessagePaidInvoice,
                    label: localization.paidInvoice,
                    maxLines: 6,
                  ),
                  DecoratedFormField(
                    controller: _customMessageUnapprovedQuote,
                    label: localization.unapprovedQuote,
                    maxLines: 6,
                  ),
                ],
              ),
            ],
          ),
          ScrollableListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  DecoratedFormField(
                    label: localization.header,
                    controller: _customHeaderController,
                    maxLines: 6,
                  ),
                  DecoratedFormField(
                    label: localization.footer,
                    controller: _customFooterController,
                    maxLines: 6,
                  ),
                  DecoratedFormField(
                    label: localization.customCss,
                    controller: _customCssController,
                    maxLines: 6,
                  ),
                  if (isSelfHosted(context))
                    DecoratedFormField(
                      label: localization.customJavascript,
                      controller: _customJavaScriptController,
                      maxLines: 6,
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
