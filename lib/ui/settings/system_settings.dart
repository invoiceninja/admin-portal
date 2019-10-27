import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/system_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final SystemSettingsVM viewModel;

  @override
  _SystemSettingsState createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusScopeNode _focusNode;
  TabController _controller;

  bool autoValidate = false;

  final _recurringPrefixController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
      _recurringPrefixController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final settings = widget.viewModel.settings;
    _recurringPrefixController.text = settings.recurringInvoiceNumberPrefix;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final settings = widget.viewModel.settings.rebuild((b) => b
      ..recurringInvoiceNumberPrefix = _recurringPrefixController.text.trim());

    if (settings != widget.viewModel.settings) {
      widget.viewModel.onSettingsChanged(settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    final state = viewModel.state;

    return SettingsScaffold(
      title: localization.systemSettings,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.general,
          ),
          Tab(
            text: localization.clients,
          ),
          Tab(
            text: localization.invoices,
          ),
          Tab(
            text: localization.credits,
          ),
          Tab(
            text: localization.payments,
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
              FormCard(
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: localization.numberPadding,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: settings.counterPadding,
                        isExpanded: true,
                        isDense: true,
                        onChanged: (value) => viewModel.onSettingsChanged(
                            settings.rebuild((b) => b..counterPadding = value)),
                        items: List<int>.generate(10, (i) => i + 1)
                            .map((value) => DropdownMenuItem(
                                  child: Text('${'0' * (value - 1)}1'),
                                  value: value,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  DecoratedFormField(
                    label: localization.recurringPrefix,
                    controller: _recurringPrefixController,
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: localization.resetCounter,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: settings.resetCounterFrequencyId,
                        isExpanded: true,
                        isDense: true,
                        onChanged: (value) => viewModel.onSettingsChanged(
                            settings.rebuild(
                                (b) => b..resetCounterFrequencyId = value)),
                        items: memoizedFrequencyList(
                                state.staticState.frequencyMap)
                            .map((frequencyId) => DropdownMenuItem(
                                  child: Text(state.staticState
                                      .frequencyMap[frequencyId].name),
                                  value: frequencyId,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  if ((settings.resetCounterFrequencyId ?? '').isNotEmpty)
                    DatePicker(
                      labelText: localization.nextReset,
                      selectedDate: settings.resetCounterDate,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..resetCounterDate = value)),
                    ),
                ],
              ),
            ],
          ),
          ListView(children: <Widget>[
            EntityNumberSettings(),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldLabel: localization.customClientField,
            ),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldLabel: localization.customContactField,
            ),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldLabel: localization.customInvoiceField,
            ),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldLabel: localization.customInvoiceSurcharge,
              showChargeTaxes: true,
            ),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldLabel: localization.customCreditField,
            ),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldLabel: localization.customPaymentField,
            ),
          ]),
        ],
      ),
    );
  }
}

class EntityNumberSettings extends StatefulWidget {
  @override
  _EntityNumberSettingsState createState() => _EntityNumberSettingsState();
}

class _EntityNumberSettingsState extends State<EntityNumberSettings> {
  final _counterController = TextEditingController();
  final _patternController = TextEditingController();

  List<TextEditingController> _controllers = [];

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
      _counterController,
      _patternController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    /*
    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
      */

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return FormCard(
      children: <Widget>[
        DecoratedFormField(
          label: localization.numberPattern,
          controller: _patternController,
        ),
        DecoratedFormField(
          label: localization.numberCounter,
          controller: _counterController,
        ),
      ],
    );
  }
}

class CustomFieldsSettings extends StatefulWidget {
  const CustomFieldsSettings({
    @required this.fieldLabel,
    @required this.viewModel,
    this.showChargeTaxes = false,
  });

  final SystemSettingsVM viewModel;
  final String fieldLabel;
  final bool showChargeTaxes;

  @override
  _CustomFieldsSettingsState createState() => _CustomFieldsSettingsState();
}

class _CustomFieldsSettingsState extends State<CustomFieldsSettings> {
  final _customField1Controller = TextEditingController();
  final _customField2Controller = TextEditingController();
  final _customField3Controller = TextEditingController();
  final _customField4Controller = TextEditingController();

  List<TextEditingController> _controllers = [];

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
      _customField1Controller,
      _customField2Controller,
      _customField3Controller,
      _customField4Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    /*
    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
      */

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    return FormCard(
      children: <Widget>[
        CustomFormField(
          label: widget.fieldLabel,
          controller: _customField1Controller,
          showTaxes: widget.showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes1,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes1 = value)),
        ),
        CustomFormField(
          label: widget.fieldLabel,
          controller: _customField2Controller,
          showTaxes: widget.showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes2,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes2 = value)),
        ),
        CustomFormField(
          label: widget.fieldLabel,
          controller: _customField3Controller,
          showTaxes: widget.showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes3,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes3 = value)),
        ),
        CustomFormField(
          label: widget.fieldLabel,
          controller: _customField4Controller,
          showTaxes: widget.showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes4,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes4 = value)),
        ),
      ],
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    @required this.label,
    @required this.controller,
    this.showTaxes = false,
    this.taxesEnabled,
    this.onTaxesChanged,
  });

  final String label;
  final TextEditingController controller;
  final bool showTaxes;
  final bool taxesEnabled;
  final Function(bool) onTaxesChanged;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: DecoratedFormField(
            label: label,
            controller: controller,
          ),
        ),
        if (showTaxes) ...[
          Checkbox(
            activeColor: Theme.of(context).accentColor,
            value: taxesEnabled ?? false,
            onChanged: onTaxesChanged,
          ),
          GestureDetector(
            child: Text(localization.chargeTaxes),
            onTap: () => onTaxesChanged(!taxesEnabled),
          ),
        ]
      ],
    );
  }
}
