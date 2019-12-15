import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/client_portal_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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
      _subdomainController,
      _portalDomainController,
      _customCssController,
      _customJavaScriptController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final company = widget.viewModel.company;
    _portalDomainController.text = company.portalDomain;
    _subdomainController.text = company.subdomain;

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

    return EditScaffold(
      title: localization.clientPortal,
      onSavePressed: (context) => _onSavePressed(context),
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
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
          ListView(
            children: <Widget>[
              if (!state.settingsUIState.isFiltered)
                FormCard(
                  children: <Widget>[
                    AppDropdownButton(
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
                        if (company.isEnterprisePlan)
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
                      ),
                    DecoratedFormField(
                      label: localization.subdomain,
                      controller: _subdomainController,
                    ),
                  ],
                ),
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.clientPortal,
                    value: settings.enablePortal,
                    iconData: kIsWeb ? Icons.timer : FontAwesomeIcons.cloud,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..enablePortal = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.dashboard,
                    value: settings.enablePortalDashboard,
                    iconData: kIsWeb
                        ? Icons.dashboard
                        : FontAwesomeIcons.tachometerAlt,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..enablePortalDashboard = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.tasks,
                    value: settings.enablePortalTasks,
                    iconData: getEntityIcon(EntityType.task),
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..enablePortalTasks = value)),
                  ),
                ],
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.enablePortalPassword,
                    helpLabel: localization.enablePortalPasswordHelp,
                    value: settings.enablePortalPassword,
                    iconData:
                        kIsWeb ? Icons.security : FontAwesomeIcons.shieldAlt,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..enablePortalPassword = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.sendPortalPassword,
                    helpLabel: localization.sendPortalPasswordHelp,
                    iconData:
                        kIsWeb ? Icons.email : FontAwesomeIcons.solidEnvelope,
                    value: settings.sendPortalPassword,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..sendPortalPassword = value)),
                  ),
                ],
              ),
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.showAcceptInvoiceTerms,
                    helpLabel: localization.showAcceptInvoiceTermsHelp,
                    value: settings.showAcceptInvoiceTerms,
                    iconData: FontAwesomeIcons.checkSquare,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..showAcceptInvoiceTerms = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.showAcceptQuoteTerms,
                    helpLabel: localization.showAcceptQuoteTermsHelp,
                    value: settings.showAcceptQuoteTerms,
                    iconData: FontAwesomeIcons.checkSquare,
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
                    iconData: FontAwesomeIcons.fileSignature,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..requireInvoiceSignature = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.requireQuoteSignature,
                    helpLabel: localization.requireInvoiceSignatureHelp,
                    value: settings.requireQuoteSignature,
                    iconData: FontAwesomeIcons.fileSignature,
                    onChanged: (value) => viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..requireQuoteSignature = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.signatureOnPdf,
                    helpLabel: localization.signatureOnPdfHelp,
                    value: settings.signatureOnPdf,
                    iconData: FontAwesomeIcons.fileContract,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..signatureOnPdf = value)),
                  ),
                ],
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              // TODO implement fields
            ],
          ),
          ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  DecoratedFormField(
                    label: localization.customCss,
                    controller: _customCssController,
                    maxLines: 8,
                  ),
                  if (isSelfHosted(context))
                    DecoratedFormField(
                      label: localization.customJavascript,
                      controller: _customJavaScriptController,
                      maxLines: 8,
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
