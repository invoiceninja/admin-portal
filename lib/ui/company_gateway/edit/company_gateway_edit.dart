// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/ui/app/autobill_dropdown_menu_item.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/learn_more.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class CompanyGatewayEdit extends StatefulWidget {
  const CompanyGatewayEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayEditVM viewModel;

  @override
  _CompanyGatewayEditState createState() => _CompanyGatewayEditState();
}

class _CompanyGatewayEditState extends State<CompanyGatewayEdit>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_companyGatewayEdit');

  final FocusScopeNode _focusNode = FocusScopeNode();
  TabController? _controller;

  // ignore: unused_field
  String _gatewayTypeId = kGatewayTypeCreditCard;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void didChangeDependencies() {
    final companyGateway = widget.viewModel.companyGateway;
    final gateway =
        widget.viewModel.state.staticState.gatewayMap[companyGateway.gatewayId];

    final enabledGatewayIds = (gateway?.options.keys ?? []).where(
        (gatewayTypeId) => companyGateway
            .getSettingsForGatewayTypeId(gatewayTypeId)
            .isEnabled);

    if (enabledGatewayIds.isNotEmpty) {
      _gatewayTypeId = enabledGatewayIds.first;
    } else {
      _gatewayTypeId = gateway?.defaultGatewayTypeId ?? kGatewayTypeCreditCard;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = state.company;
    final localization = AppLocalization.of(context)!;
    final companyGateway = viewModel.companyGateway;
    final origCompanyGateway = state.companyGatewayState.get(companyGateway.id);
    final gateway = state.staticState.gatewayMap[companyGateway.gatewayId];
    final accountId =
        (companyGateway.parsedConfig!['account_id'] ?? '').toString();

    final connectGateways = [
      kGatewayStripeConnect,
      kGatewayWePay,
      kGatewayPayPalPlatform,
    ];

    final disableSave = (connectGateways.contains(companyGateway.gatewayId) &&
            companyGateway.isNew) ||
        state.isDemo;
    final enabledGatewayIds = (gateway?.options.keys ?? []).where(
        (gatewayTypeId) => companyGateway
            .getSettingsForGatewayTypeId(gatewayTypeId)
            .isEnabled);

    return EditScaffold(
      entity: companyGateway,
      title: viewModel.companyGateway.isNew
          ? localization.newCompanyGateway
          : origCompanyGateway.listDisplayName,
      onSavePressed: disableSave ? null : viewModel.onSavePressed,
      onCancelPressed: viewModel.onCancelPressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: isMobile(context),
        tabs: [
          Tab(
            text: localization.credentials,
          ),
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.limitsAndFees,
          ),
        ],
      ),
      body: AppTabForm(
        formKey: _formKey,
        focusNode: _focusNode,
        tabController: _controller,
        children: <Widget>[
          ScrollableListView(
            children: <Widget>[
              FormCard(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (companyGateway.isNew)
                    EntityDropdown(
                      autofocus: true,
                      entityType: EntityType.gateway,
                      entityList: memoizedGatewayList(
                          state.staticState.gatewayMap, state.isHosted),
                      labelText: localization.provider,
                      entityId: companyGateway.gatewayId,
                      onSelected: (SelectableEntity? gateway) {
                        viewModel.onChanged(
                          companyGateway.rebuild((b) => b
                            ..feesAndLimitsMap[((gateway ?? GatewayEntity())
                                        as GatewayEntity)
                                    .defaultGatewayTypeId] =
                                FeesAndLimitsSettings(isEnabled: true)
                            ..gatewayId = gateway?.id ?? ''
                            ..config = '{}'
                            ..label = gateway?.listDisplayName ?? ''),
                        );
                      },
                    ),
                  if (connectGateways.contains(companyGateway.gatewayId))
                    if (companyGateway.isNew ||
                        (companyGateway.gatewayId == kGatewayStripeConnect &&
                            accountId.isEmpty)) ...[
                      AppButton(
                        label: localization.gatewaySetup.toUpperCase(),
                        onPressed: viewModel.state.isSaving
                            ? null
                            : () {
                                viewModel.onCancelPressed(context);
                                viewModel.onGatewaySignUpPressed(
                                    companyGateway.gatewayId);
                              },
                      ),
                      if (companyGateway.gatewayId == kGatewayStripeConnect)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: OutlinedButton(
                            onPressed: () =>
                                launchUrl(Uri.parse(kDocsStripeConnectUrl)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconText(
                                icon: MdiIcons.openInNew,
                                text: localization.learnMore.toUpperCase(),
                              ),
                            ),
                          ),
                        ),
                    ] else
                      GatewayConfigSettings(
                        key:
                            ValueKey('__connect_${companyGateway.gatewayId}__'),
                        companyGateway: companyGateway,
                        viewModel: viewModel,
                        disasbledFields: ['account_id'],
                      )
                  else
                    GatewayConfigSettings(
                      key: ValueKey('__${companyGateway.gatewayId}__'),
                      companyGateway: companyGateway,
                      viewModel: viewModel,
                    ),
                ],
              ),
            ],
          ),
          if (companyGateway.gatewayId == kGatewayCustom)
            Center(
              child: HelpText(localization.noPaymentTypesEnabled),
            )
          else
            ScrollableListView(
              children: <Widget>[
                FormCard(children: <Widget>[
                  DecoratedFormField(
                    label: localization.label,
                    initialValue: companyGateway.label,
                    onChanged: (String value) => viewModel.onChanged(
                        companyGateway.rebuild((b) => b..label = value.trim())),
                    keyboardType: TextInputType.text,
                  ),
                  if (state.staticState.gatewayMap[companyGateway.gatewayId]
                          ?.supportsTokenBilling ==
                      true)
                    AppDropdownButton<String>(
                      labelText: localization.captureCard,
                      value: companyGateway.tokenBilling,
                      selectedItemBuilder: companyGateway.tokenBilling.isEmpty
                          ? null
                          : (context) => [
                                SettingsEntity.AUTO_BILL_ALWAYS,
                                SettingsEntity.AUTO_BILL_OPT_OUT,
                                SettingsEntity.AUTO_BILL_OPT_IN,
                                SettingsEntity.AUTO_BILL_OFF,
                              ]
                                  .map(
                                      (type) => Text(localization.lookup(type)))
                                  .toList(),
                      onChanged: (dynamic value) => viewModel.onChanged(
                          companyGateway
                              .rebuild((b) => b..tokenBilling = value)),
                      items: [
                        SettingsEntity.AUTO_BILL_ALWAYS,
                        SettingsEntity.AUTO_BILL_OPT_OUT,
                        SettingsEntity.AUTO_BILL_OPT_IN,
                        SettingsEntity.AUTO_BILL_OFF
                      ]
                          .map((value) => DropdownMenuItem(
                                child: AutobillDropdownMenuItem(type: value),
                                value: value,
                              ))
                          .toList(),
                    ),
                  SizedBox(height: 16),
                  for (var gatewayTypeId in gateway?.options.keys ?? <String>[])
                    SwitchListTile(
                        title: Text(kGatewayTypes.containsKey(gatewayTypeId)
                            ? localization
                                .lookup(kGatewayTypes[gatewayTypeId] ?? '')
                            : '$gatewayTypeId'),
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: companyGateway
                            .getSettingsForGatewayTypeId(gatewayTypeId)
                            .isEnabled,
                        onChanged: (value) {
                          final settings = companyGateway
                              .getSettingsForGatewayTypeId(gatewayTypeId);
                          viewModel.onChanged(companyGateway.rebuild((b) => b
                            ..feesAndLimitsMap[gatewayTypeId] =
                                settings.rebuild((b) => b..isEnabled = value)));
                        }),
                ]),
                FormCard(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: Text(
                        localization.requiredFields,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.clientName),
                      value: companyGateway.requireClientName,
                      onChanged: (value) => viewModel.onChanged(companyGateway
                          .rebuild((b) => b..requireClientName = value)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.clientPhone),
                      value: companyGateway.requireClientPhone,
                      onChanged: (value) => viewModel.onChanged(companyGateway
                          .rebuild((b) => b..requireClientPhone = value)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.contactName),
                      value: companyGateway.requireContactName,
                      onChanged: (value) => viewModel.onChanged(companyGateway
                          .rebuild((b) => b..requireContactName = value)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.contactEmail),
                      value: companyGateway.requireContactEmail,
                      onChanged: (value) => viewModel.onChanged(companyGateway
                          .rebuild((b) => b..requireContactEmail = value)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    if (company.hasCustomField(CustomFieldType.client1))
                      CheckboxListTile(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        title: Text(company
                            .getCustomFieldLabel(CustomFieldType.client1)),
                        value: companyGateway.requireCustomValue1,
                        onChanged: (value) => viewModel.onChanged(companyGateway
                            .rebuild((b) => b..requireCustomValue1 = value)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    if (company.hasCustomField(CustomFieldType.client2))
                      CheckboxListTile(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        title: Text(company
                            .getCustomFieldLabel(CustomFieldType.client2)),
                        value: companyGateway.requireCustomValue2,
                        onChanged: (value) => viewModel.onChanged(companyGateway
                            .rebuild((b) => b..requireCustomValue2 = value)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    if (company.hasCustomField(CustomFieldType.client3))
                      CheckboxListTile(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        title: Text(company
                            .getCustomFieldLabel(CustomFieldType.client3)),
                        value: companyGateway.requireCustomValue3,
                        onChanged: (value) => viewModel.onChanged(companyGateway
                            .rebuild((b) => b..requireCustomValue3 = value)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    if (company.hasCustomField(CustomFieldType.client4))
                      CheckboxListTile(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        title: Text(company
                            .getCustomFieldLabel(CustomFieldType.client4)),
                        value: companyGateway.requireCustomValue4,
                        onChanged: (value) => viewModel.onChanged(companyGateway
                            .rebuild((b) => b..requireCustomValue4 = value)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.postalCode),
                      value: companyGateway.requirePostalCode,
                      onChanged: (value) => viewModel.onChanged(companyGateway
                          .rebuild((b) => b..requirePostalCode = value)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.cvv),
                      value: companyGateway.requireCvv,
                      onChanged: (value) => viewModel.onChanged(
                          companyGateway.rebuild((b) => b..requireCvv = value)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.billingAddress),
                      value: companyGateway.requireBillingAddress,
                      onChanged: (value) => viewModel.onChanged(companyGateway
                          .rebuild((b) => b..requireBillingAddress = value)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.shippingAddress),
                      value: companyGateway.requireShippingAddress,
                      onChanged: (value) => viewModel.onChanged(companyGateway
                          .rebuild((b) => b..requireShippingAddress = value)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    SizedBox(height: 16),
                    SwitchListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(localization.updateAddress),
                      subtitle: Text(localization.updateAddressHelp),
                      value: companyGateway.updateDetails,
                      onChanged: (value) => viewModel.onChanged(companyGateway
                          .rebuild((b) => b..updateDetails = value)),
                    ),
                  ],
                ),
                // TODO enable once supported in backend
                /*
              if (gateway?.isOffsite != true)
                FormCard(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: Text(
                        localization.acceptedCardLogos,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CardListTile(
                      viewModel: viewModel,
                      cardType: kCardTypeVisa,
                      paymentType: kPaymentTypeVisa,
                    ),
                    CardListTile(
                      viewModel: viewModel,
                      cardType: kCardTypeMasterCard,
                      paymentType: kPaymentTypeMasterCard,
                    ),
                    CardListTile(
                      viewModel: viewModel,
                      cardType: kCardTypeAmEx,
                      paymentType: kPaymentTypeAmEx,
                    ),
                    CardListTile(
                      viewModel: viewModel,
                      cardType: kCardTypeDiscover,
                      paymentType: kPaymentTypeDiscover,
                    ),
                    CardListTile(
                      viewModel: viewModel,
                      cardType: kCardTypeDiners,
                      paymentType: kPaymentTypeDiners,
                    ),
                  ],
                )
                */
              ],
            ),
          if (enabledGatewayIds.isEmpty)
            Center(
              child: HelpText(localization.noPaymentTypesEnabled),
            )
          else
            ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    AppDropdownButton(
                      labelText: localization.paymentType,
                      value: _gatewayTypeId,
                      items: enabledGatewayIds
                          .map((gatewayTypeId) => DropdownMenuItem(
                                child: Text(localization.lookup(
                                    kGatewayTypes[gatewayTypeId] ?? '')),
                                value: gatewayTypeId,
                              ))
                          .toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          _gatewayTypeId = value;
                        });
                      },
                    ),
                  ],
                ),
                if (enabledGatewayIds.contains(_gatewayTypeId)) ...[
                  LimitEditor(
                    key: ValueKey('__limits_${_gatewayTypeId}__'),
                    gatewayTypeId: _gatewayTypeId,
                    viewModel: viewModel,
                    companyGateway: companyGateway,
                  ),
                  FeesEditor(
                    key: ValueKey('__fees_${_gatewayTypeId}__'),
                    gatewayTypeId: _gatewayTypeId,
                    viewModel: viewModel,
                    companyGateway: companyGateway,
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class CardListTile extends StatelessWidget {
  const CardListTile({this.viewModel, this.paymentType, this.cardType});

  final CompanyGatewayEditVM? viewModel;
  final String? paymentType;
  final int? cardType;

  @override
  Widget build(BuildContext context) {
    final staticState = viewModel!.state.staticState;
    final companyGateway = viewModel!.companyGateway;

    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(staticState.paymentTypeMap[paymentType]?.name ?? ''),
      value: companyGateway.supportsCard(cardType!),
      onChanged: (value) => viewModel!.onChanged(value!
          ? companyGateway.addCard(cardType)
          : companyGateway.removeCard(cardType)),
    );
  }
}

class GatewayConfigSettings extends StatelessWidget {
  const GatewayConfigSettings({
    Key? key,
    this.companyGateway,
    this.viewModel,
    this.disasbledFields = const <String>[],
  }) : super(key: key);

  final CompanyGatewayEntity? companyGateway;
  final CompanyGatewayEditVM? viewModel;
  final List<String> disasbledFields;

  @override
  Widget build(BuildContext context) {
    final state = viewModel!.state;
    final localization = AppLocalization.of(context);
    final gateway = state.staticState.gatewayMap[companyGateway!.gatewayId];

    if (gateway == null) {
      return SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (gateway.siteUrl.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: OutlinedButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: IconText(
                  icon: MdiIcons.openInNew,
                  text: localization!.learnMore.toUpperCase(),
                ),
              ),
              onPressed: () => launchUrl(Uri.parse(gateway.siteUrl)),
            ),
          ),
        ...gateway.parsedFields!.keys
            .map((field) => GatewayConfigField(
                  field: field,
                  value: companyGateway!.parsedConfig![field],
                  gateway: gateway,
                  defaultValue: gateway.parsedFields![field],
                  enabled: !disasbledFields.contains(field),
                  onChanged: (dynamic value) {
                    viewModel!
                        .onChanged(companyGateway!.updateConfig(field, value));
                  },
                ))
            .toList()
      ],
    );
  }
}

class GatewayConfigField extends StatefulWidget {
  const GatewayConfigField({
    Key? key,
    required this.gateway,
    required this.field,
    required this.value,
    required this.defaultValue,
    required this.onChanged,
    required this.enabled,
  }) : super(key: key);

  final GatewayEntity gateway;
  final String field;
  final dynamic value;
  final dynamic defaultValue;
  final Function(dynamic) onChanged;
  final bool enabled;

  @override
  _GatewayConfigFieldState createState() => _GatewayConfigFieldState();
}

class _GatewayConfigFieldState extends State<GatewayConfigField> {
  bool autoValidate = false;
  TextEditingController? _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _textController!.removeListener(_onChanged);

    _textController!.text = (widget.value ?? widget.defaultValue).toString();

    _textController!.addListener(_onChanged);

    super.didChangeDependencies();
  }

  void _onChanged() {
    widget.onChanged(_textController!.text.trim());
  }

  bool _obscureText(String field) {
    bool obscure = false;
    ['password', 'secret', 'key'].forEach((word) {
      if (field.toLowerCase().contains(word)) {
        obscure = true;
      }
    });
    return obscure;
  }

  @override
  Widget build(BuildContext context) {
    String label;
    if (widget.gateway.id == kGatewayStripe && widget.field == 'apiKey') {
      label = 'Secret Key';
    } else {
      label = toTitleCase(widget.field.replaceAll('_', ' '));
    }

    if ('${widget.defaultValue}'.startsWith('[') &&
        '${widget.defaultValue}'.endsWith(']')) {
      final options = '${widget.defaultValue}'
          .replaceFirst('[', '')
          .replaceFirst(']', '')
          .split(',');

      final dynamic value =
          (widget.value == null || widget.value == widget.defaultValue)
              ? ''
              : widget.value;

      return AppDropdownButton<String>(
        labelText: toTitleCase(widget.field),
        value: value,
        onChanged: (dynamic value) => widget.onChanged(value),
        items: options
            .map((value) => DropdownMenuItem<String>(
                  child: Text(value.trim()),
                  value: value.trim(),
                ))
            .toList(),
      );
    } else if (widget.field.toLowerCase().contains('color')) {
      return FormColorPicker(
        initialValue: widget.value,
        labelText: toTitleCase(widget.field),
        onSelected: (value) => widget.onChanged(value),
      );
    } else if (widget.defaultValue.runtimeType == bool) {
      return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Theme.of(context).colorScheme.secondary,
        title: Text(toTitleCase(widget.field)),
        value: widget.value ?? false,
        onChanged: (value) => widget.onChanged(value),
      );
    } else {
      final isMultiline = [
        'text',
        'appleDomainVerification',
      ].contains(widget.field);

      return DecoratedFormField(
        enabled: widget.enabled,
        controller: _textController,
        label: label,
        maxLines: isMultiline ? 6 : 1,
        onChanged: (value) => _onChanged(),
        obscureText: _obscureText(widget.field),
        keyboardType: isMultiline
            ? TextInputType.multiline
            : TextInputType.visiblePassword,
      );
    }
  }
}

class LimitEditor extends StatefulWidget {
  const LimitEditor(
      {Key? key, this.companyGateway, this.viewModel, this.gatewayTypeId})
      : super(key: key);

  final CompanyGatewayEntity? companyGateway;
  final CompanyGatewayEditVM? viewModel;
  final String? gatewayTypeId;

  @override
  _LimitEditorState createState() => _LimitEditorState();
}

class _LimitEditorState extends State<LimitEditor> {
  final _debouncer = Debouncer();

  bool? _enableMin = false;
  bool? _enableMax = false;

  TextEditingController? _minController;
  TextEditingController? _maxController;

  @override
  void initState() {
    super.initState();
    _minController = TextEditingController();
    _maxController = TextEditingController();
  }

  @override
  void dispose() {
    _minController!.dispose();
    _maxController!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _minController!.removeListener(_onTextChange);
    _maxController!.removeListener(_onTextChange);

    final companyGateway = widget.companyGateway!;
    final settings =
        companyGateway.getSettingsForGatewayTypeId(widget.gatewayTypeId);

    if (settings.minLimit != -1) {
      _enableMin = true;
    }

    if (settings.maxLimit != -1) {
      _enableMax = true;
    }

    _minController!.text = settings.minLimit == -1
        ? ''
        : formatNumber(settings.minLimit.toDouble(), context,
            formatNumberType: FormatNumberType.inputMoney)!;
    _maxController!.text = settings.maxLimit == -1
        ? ''
        : formatNumber(settings.maxLimit.toDouble(), context,
            formatNumberType: FormatNumberType.inputMoney)!;

    _minController!.addListener(_onTextChange);
    _maxController!.addListener(_onTextChange);

    super.didChangeDependencies();
  }

  void _onChanged() {
    final viewModel = widget.viewModel!;
    final companyGateway = viewModel.companyGateway;
    final settings =
        companyGateway.getSettingsForGatewayTypeId(widget.gatewayTypeId);

    final updatedSettings = settings.rebuild((b) => b
      ..minLimit = _enableMin! ? parseDouble(_minController!.text.trim()) : -1
      ..maxLimit = _enableMax! ? parseDouble(_maxController!.text.trim()) : -1);

    if (settings != updatedSettings) {
      viewModel.onChanged(companyGateway.rebuild(
          (b) => b..feesAndLimitsMap[widget.gatewayTypeId] = updatedSettings));
    }
  }

  void _onTextChange() {
    _debouncer.run(() {
      _onChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return FormCard(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DecoratedFormField(
                    label: localization.minLimit,
                    enabled: _enableMin,
                    controller: _minController,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    autocorrect: false,
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.all(0),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    title: Text(isDesktop(context)
                        ? localization.enableMin
                        : localization.enable),
                    value: _enableMin,
                    onChanged: (value) {
                      setState(() {
                        _enableMin = value;
                        _onChanged();
                        if (!value!) {
                          _minController!.text = '';
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(width: 40),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DecoratedFormField(
                    label: localization.maxLimit,
                    enabled: _enableMax,
                    controller: _maxController,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    autocorrect: false,
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.all(0),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    title: Text(isDesktop(context)
                        ? localization.enableMax
                        : localization.enable),
                    value: _enableMax,
                    onChanged: (value) {
                      setState(() {
                        _enableMax = value;
                        _onChanged();
                        if (!value!) {
                          _maxController!.text = '';
                        }
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FeesEditor extends StatefulWidget {
  const FeesEditor(
      {Key? key, this.companyGateway, this.viewModel, this.gatewayTypeId})
      : super(key: key);

  final CompanyGatewayEntity? companyGateway;
  final CompanyGatewayEditVM? viewModel;
  final String? gatewayTypeId;

  @override
  _FeesEditorState createState() => _FeesEditorState();
}

class _FeesEditorState extends State<FeesEditor> {
  final _amountController = TextEditingController();
  final _percentController = TextEditingController();
  final _capController = TextEditingController();

  late List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
      _percentController,
      _capController,
    ];

    final companyGateway = widget.companyGateway!;
    final settings =
        companyGateway.getSettingsForGatewayTypeId(widget.gatewayTypeId);

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _amountController.text = formatNumber(settings.feeAmount, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _percentController.text = formatNumber(settings.feePercent, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _capController.text = formatNumber(settings.feeCap, context,
        formatNumberType: FormatNumberType.inputMoney)!;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final viewModel = widget.viewModel!;
    final companyGateway = viewModel.companyGateway;
    final settings =
        companyGateway.getSettingsForGatewayTypeId(widget.gatewayTypeId);

    final amount = parseDouble(_amountController.text.trim());
    final percent = parseDouble(_percentController.text.trim());
    final cap = parseDouble(_capController.text.trim());

    final updatedSettings = settings.rebuild((b) => b
      ..feeAmount = amount
      ..feePercent = percent
      ..feeCap = cap);

    if (settings != updatedSettings) {
      _debouncer.run(() {
        viewModel.onChanged(companyGateway.rebuild((b) =>
            b..feesAndLimitsMap[widget.gatewayTypeId] = updatedSettings));
      });
    }
  }

  String _sampleFee() {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel!;
    final companyGateway = viewModel.companyGateway;
    final settings =
        companyGateway.getSettingsForGatewayTypeId(widget.gatewayTypeId);

    const double amount = 100;
    final fee = settings.calculateSampleFee(100);

    return localization.feesSample
        .replaceFirst(':amount', formatNumber(amount, context)!)
        .replaceFirst(':total', formatNumber(fee, context)!);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel!;
    final companyGateway = viewModel.companyGateway;
    final company = viewModel.state.company;
    final settings =
        companyGateway.getSettingsForGatewayTypeId(widget.gatewayTypeId);

    return FormCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DecoratedFormField(
          label: localization.feePercent,
          controller: _percentController,
          isPercent: true,
          keyboardType:
              TextInputType.numberWithOptions(decimal: true, signed: true),
        ),
        DecoratedFormField(
          label: localization.feeAmount,
          controller: _amountController,
          isMoney: true,
          keyboardType:
              TextInputType.numberWithOptions(decimal: true, signed: true),
        ),
        if (company.enableFirstItemTaxRate)
          TaxRateDropdown(
            onSelected: (taxRate) => viewModel.onChanged(companyGateway.rebuild(
                (b) => b
                  ..feesAndLimitsMap[widget.gatewayTypeId] =
                      settings.rebuild((b) => b
                        ..taxRate1 = taxRate.rate
                        ..taxName1 = taxRate.name))),
            labelText: localization.tax,
            initialTaxName: settings.taxName1,
            initialTaxRate: settings.taxRate1,
          ),
        if (company.enableSecondItemTaxRate)
          TaxRateDropdown(
            onSelected: (taxRate) => viewModel.onChanged(companyGateway.rebuild(
                (b) => b
                  ..feesAndLimitsMap[widget.gatewayTypeId] =
                      settings.rebuild((b) => b
                        ..taxRate2 = taxRate.rate
                        ..taxName2 = taxRate.name))),
            labelText: localization.tax,
            initialTaxName: settings.taxName2,
            initialTaxRate: settings.taxRate2,
          ),
        if (company.enableThirdItemTaxRate)
          TaxRateDropdown(
            onSelected: (taxRate) => viewModel.onChanged(companyGateway.rebuild(
                (b) => b
                  ..feesAndLimitsMap[widget.gatewayTypeId] =
                      settings.rebuild((b) => b
                        ..taxRate3 = taxRate.rate
                        ..taxName3 = taxRate.name))),
            labelText: localization.tax,
            initialTaxName: settings.taxName3,
            initialTaxRate: settings.taxRate3,
          ),
        DecoratedFormField(
          label: localization.feeCap,
          controller: _capController,
          isMoney: true,
          keyboardType:
              TextInputType.numberWithOptions(decimal: true, signed: true),
        ),
        SizedBox(height: 16),
        LearnMoreUrl(
          url: kGatewayFeeHelpURL,
          child: SwitchListTile(
            value: settings.adjustFeePercent,
            onChanged: (value) => viewModel.onChanged(companyGateway.rebuild(
                (b) => b
                  ..feesAndLimitsMap[widget.gatewayTypeId] =
                      settings.rebuild((b) => b..adjustFeePercent = value))),
            title: Text(localization.adjustFeePercent),
            activeColor: Theme.of(context).colorScheme.secondary,
            subtitle: Text(localization.adjustFeePercentHelp),
          ),
        ),
        SizedBox(height: 16),
        Text(
          _sampleFee(),
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
