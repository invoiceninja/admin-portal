import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class CompanyGatewayEdit extends StatefulWidget {
  const CompanyGatewayEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayEditVM viewModel;

  @override
  _CompanyGatewayEditState createState() => _CompanyGatewayEditState();
}

class _CompanyGatewayEditState extends State<CompanyGatewayEdit>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusScopeNode _focusNode = FocusScopeNode();
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final localization = AppLocalization.of(context);
    final companyGateway = viewModel.companyGateway;

    return SettingsScaffold(
      title: viewModel.companyGateway.isNew
          ? localization.newCompanyGateway
          : companyGateway.gateway.name,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
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
          ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  if (companyGateway.isNew)
                    EntityDropdown(
                      key: ValueKey('__gateway_${companyGateway.gatewayId}__'),
                      entityType: EntityType.gateway,
                      entityList:
                          memoizedGatewayList(state.staticState.gatewayMap),
                      labelText: localization.provider,
                      entityId: companyGateway.gatewayId,
                      onSelected: (SelectableEntity gateway) =>
                          viewModel.onChanged(
                        companyGateway.rebuild((b) => b
                          ..gatewayId = gateway.id
                          ..config = ''),
                      ),
                      //onFieldSubmitted: (String value) => _node.nextFocus(),
                    ),
                  GatewayConfigSettings(
                    key: ValueKey('__${companyGateway.gatewayId}__'),
                    companyGateway: companyGateway,
                    viewModel: viewModel,
                  ),
                ],
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  SwitchListTile(
                    activeColor: Theme.of(context).accentColor,
                    title: Text(localization.updateAddress),
                    subtitle: Text(localization.updateAddressHelp),
                    value: companyGateway.updateDetails,
                    onChanged: (value) => viewModel.onChanged(companyGateway
                        .rebuild((b) => b..updateDetails = value)),
                  ),
                  SwitchListTile(
                    activeColor: Theme.of(context).accentColor,
                    title: Text(localization.billingAddress),
                    subtitle: Text(localization.requireBillingAddressHelp),
                    value: companyGateway.showBillingAddress,
                    onChanged: (value) => viewModel.onChanged(companyGateway
                        .rebuild((b) => b..showBillingAddress = value)),
                  ),
                  SwitchListTile(
                    activeColor: Theme.of(context).accentColor,
                    title: Text(localization.shippingAddress),
                    subtitle: Text(localization.requireShippingAddressHelp),
                    value: companyGateway.showShippingAddress,
                    onChanged: (value) => viewModel.onChanged(companyGateway
                        .rebuild((b) => b..showShippingAddress = value)),
                  ),
                ],
              ),
              FormCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                    child: Text(
                      localization.acceptedCardLogos,
                      style: Theme.of(context).textTheme.subhead,
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
            ],
          ),
          ListView(
            children: <Widget>[
              LimitEditor(
                viewModel: viewModel,
                companyGateway: companyGateway,
              ),
              FeesEditor(
                viewModel: viewModel,
                companyGateway: companyGateway,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardListTile extends StatelessWidget {
  const CardListTile({this.viewModel, this.paymentType, this.cardType});

  final CompanyGatewayEditVM viewModel;
  final String paymentType;
  final int cardType;

  @override
  Widget build(BuildContext context) {
    final staticState = viewModel.state.staticState;
    final companyGateway = viewModel.companyGateway;

    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Theme.of(context).accentColor,
      title: Text(staticState.paymentTypeMap[paymentType]?.name ?? ''),
      value: companyGateway.supportsCard(cardType),
      onChanged: (value) => viewModel.onChanged(value
          ? companyGateway.addCard(cardType)
          : companyGateway.removeCard(cardType)),
    );
  }
}

class GatewayConfigSettings extends StatelessWidget {
  const GatewayConfigSettings({Key key, this.companyGateway, this.viewModel})
      : super(key: key);

  final CompanyGatewayEntity companyGateway;
  final CompanyGatewayEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final gateway = state.staticState.gatewayMap[companyGateway.gatewayId];

    if (gateway == null) {
      return SizedBox();
    }

    return Column(
        children: gateway.parsedFields.keys
            .map((field) => GatewayConfigField(
                  field: field,
                  value: companyGateway.parsedConfig[field],
                  gateway: gateway,
                  defaultValue: gateway.parsedFields[field],
                  onChanged: (dynamic value) {
                    viewModel
                        .onChanged(companyGateway.updateConfig(field, value));
                  },
                ))
            .toList());
  }
}

class GatewayConfigField extends StatefulWidget {
  const GatewayConfigField({
    Key key,
    @required this.gateway,
    @required this.field,
    @required this.value,
    @required this.defaultValue,
    @required this.onChanged,
  }) : super(key: key);

  final GatewayEntity gateway;
  final String field;
  final dynamic value;
  final dynamic defaultValue;
  final Function(dynamic) onChanged;

  @override
  _GatewayConfigFieldState createState() => _GatewayConfigFieldState();
}

class _GatewayConfigFieldState extends State<GatewayConfigField> {
  bool autoValidate = false;
  TextEditingController _textController;
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _textController.removeListener(_onChanged);

    _textController.text = (widget.value ?? widget.defaultValue).toString();

    _textController.addListener(_onChanged);

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      widget.onChanged(_textController.text.trim());
    });
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
      label = toTitleCase(widget.field);
    }

    if ('${widget.defaultValue}'.startsWith('[') &&
        '${widget.defaultValue}'.endsWith(']')) {
      final options = [
        '',
        ...'${widget.defaultValue}'
            .replaceFirst('[', '')
            .replaceFirst(']', '')
            .split(',')
      ];
      final dynamic value =
          widget.value == widget.defaultValue ? '' : widget.value;

      return AppDropdownButton(
        labelText: toTitleCase(widget.field),
        value: value,
        onChanged: (value) => widget.onChanged(value),
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
        activeColor: Theme.of(context).accentColor,
        title: Text(toTitleCase(widget.field)),
        value: widget.value ?? false,
        onChanged: (value) => widget.onChanged(value),
      );
    } else {
      return TextFormField(
        controller: _textController,
        decoration: InputDecoration(
          labelText: label,
        ),
        onChanged: (value) => _onChanged(),
        obscureText: _obscureText(widget.field),
      );
    }
  }
}

class LimitEditor extends StatefulWidget {
  const LimitEditor({this.companyGateway, this.viewModel});

  final CompanyGatewayEntity companyGateway;
  final CompanyGatewayEditVM viewModel;

  @override
  _LimitEditorState createState() => _LimitEditorState();
}

class _LimitEditorState extends State<LimitEditor> {
  final _debouncer = Debouncer();

  bool _enableMin = false;
  bool _enableMax = false;

  TextEditingController _minController;
  TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    _minController = TextEditingController();
    _maxController = TextEditingController();
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _minController.removeListener(_onChanged);
    _maxController.removeListener(_onChanged);

    final companyGateway = widget.companyGateway;

    if (companyGateway.minLimit != null) {
      _enableMin = true;
    }

    if (companyGateway.maxLimit != null) {
      _enableMax = true;
    }

    _minController.text = formatNumber(
        (companyGateway.minLimit ?? 0).toDouble(), context,
        formatNumberType: FormatNumberType.input);
    _maxController.text = formatNumber(
        (companyGateway.maxLimit ?? 0).toDouble(), context,
        formatNumberType: FormatNumberType.input);

    _minController.addListener(_onChanged);
    _maxController.addListener(_onChanged);

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      final viewModel = widget.viewModel;
      final companyGateway = viewModel.companyGateway;

      final updatedGateway = companyGateway.rebuild((b) => b
        ..minLimit = _enableMin ? parseDouble(_minController.text.trim()) : null
        ..maxLimit =
            _enableMax ? parseDouble(_maxController.text.trim()) : null);

      if (companyGateway != updatedGateway) {
        viewModel.onChanged(updatedGateway);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return FormCard(
      children: <Widget>[
        /*
        RangeSlider(
          values: RangeValues((widget.companyGateway.minLimit ?? 0).toDouble(),
              (widget.companyGateway.maxLimit ?? 100000).toDouble()),
          min: 0,
          max: 100000,
          onChanged: (values) {
            _minController.text = formatNumber(values.start, context,
                formatNumberType: FormatNumberType.input);
            _maxController.text = formatNumber(values.end, context,
                formatNumberType: FormatNumberType.input);
            widget.viewModel.onChanged(widget.companyGateway.rebuild((b) => b
              ..minLimit = values.start.toInt()
              ..maxLimit = values.end.toInt()));
          },
        ),
         */
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
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Theme.of(context).accentColor,
                    title: Text(localization.enableMin),
                    value: _enableMin,
                    onChanged: (value) {
                      setState(() {
                        _enableMin = value;
                        _onChanged();
                        if (!value) {
                          _minController.text = '';
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
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Theme.of(context).accentColor,
                    title: Text(localization.enableMax),
                    value: _enableMax,
                    onChanged: (value) {
                      setState(() {
                        _enableMax = value;
                        _onChanged();
                        if (!value) {
                          _maxController.text = '';
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
  const FeesEditor({this.companyGateway, this.viewModel});

  final CompanyGatewayEntity companyGateway;
  final CompanyGatewayEditVM viewModel;

  @override
  _FeesEditorState createState() => _FeesEditorState();
}

class _FeesEditorState extends State<FeesEditor> {
  final _amountController = TextEditingController();
  final _percentController = TextEditingController();
  final _capController = TextEditingController();

  List<TextEditingController> _controllers;
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

    final companyGateway = widget.companyGateway;

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _amountController.text = formatNumber(companyGateway.feeAmount, context,
        formatNumberType: FormatNumberType.input);
    _percentController.text = formatNumber(companyGateway.feePercent, context,
        formatNumberType: FormatNumberType.input);
    _capController.text = formatNumber(companyGateway.feeCap, context,
        formatNumberType: FormatNumberType.input);

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      final viewModel = widget.viewModel;
      final companyGateway = viewModel.companyGateway;

      final amount = parseDouble(_amountController.text.trim());
      final percent = parseDouble(_percentController.text.trim());
      final cap = parseDouble(_capController.text.trim());
      final feesEnabled = amount != 0 || percent != 0;

      final updatedGateway = companyGateway.rebuild((b) => b
        ..feeAmount = feesEnabled ? amount : null
        ..feePercent = feesEnabled ? percent : null
        ..feeCap = feesEnabled ? cap : null);

      if (companyGateway != updatedGateway) {
        viewModel.onChanged(updatedGateway);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final companyGateway = viewModel.companyGateway;
    final company = viewModel.state.selectedCompany;

    return FormCard(
      children: <Widget>[
        DecoratedFormField(
          label: localization.feeAmount,
          controller: _amountController,
        ),
        DecoratedFormField(
          label: localization.feePercent,
          controller: _percentController,
        ),
        DecoratedFormField(
          label: localization.feeCap,
          controller: _capController,
        ),
        if (company.settings.enableInvoiceItemTaxes)
          TaxRateDropdown(
            taxRates: company.taxRates,
            onSelected: (taxRate) =>
                viewModel.onChanged(companyGateway.rebuild((b) => b
                  ..taxRate1 = taxRate.rate
                  ..taxName1 = taxRate.name)),
            labelText: localization.tax,
            initialTaxName: companyGateway.taxName1,
            initialTaxRate: companyGateway.taxRate1,
          ),
        if (company.settings.enableInvoiceItemTaxes &&
            company.settings.enableSecondTaxRate)
          TaxRateDropdown(
            taxRates: company.taxRates,
            onSelected: (taxRate) =>
                viewModel.onChanged(companyGateway.rebuild((b) => b
                  ..taxRate2 = taxRate.rate
                  ..taxName2 = taxRate.name)),
            labelText: localization.tax,
            initialTaxName: companyGateway.taxName2,
            initialTaxRate: companyGateway.taxRate2,
          ),
      ],
    );
  }
}
