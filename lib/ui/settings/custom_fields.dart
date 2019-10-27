import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/custom_fields_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CustomFields extends StatefulWidget {
  const CustomFields({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CustomFieldsVM viewModel;

  @override
  _CustomFieldsState createState() => _CustomFieldsState();
}

class _CustomFieldsState extends State<CustomFields>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusScopeNode _focusNode;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;

    return SettingsScaffold(
      title: localization.customFields,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.company,
          ),
          Tab(
            text: localization.clients,
          ),
          Tab(
            text: localization.invoices,
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
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.company,
                valueLabel: localization.companyValue,
                showValues: true,
                field1Value: settings.customValue1,
                field2Value: settings.customValue2,
                field3Value: settings.customValue3,
                field4Value: settings.customValue4,
              ),
            ],
          ),
          ListView(children: <Widget>[
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldType: CustomFieldType.client,
            ),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldType: CustomFieldType.contact,
            ),
          ]),
          ListView(children: <Widget>[
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldType: CustomFieldType.invoice,
            ),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldType: CustomFieldType.surcharge,
              showChargeTaxes: true,
            ),
          ]),
          ListView(children: <Widget>[
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldType: CustomFieldType.payment,
            ),
          ]),
        ],
      ),
    );
  }
}

class CustomFieldsSettings extends StatefulWidget {
  const CustomFieldsSettings({
    @required this.fieldType,
    @required this.viewModel,
    this.showChargeTaxes = false,
    this.showValues = false,
    this.valueLabel,
    this.field1Value,
    this.field2Value,
    this.field3Value,
    this.field4Value,
  });

  final CustomFieldsVM viewModel;
  final String valueLabel;
  final bool showChargeTaxes;
  final bool showValues;
  final String fieldType;
  final String field1Value;
  final String field2Value;
  final String field3Value;
  final String field4Value;

  @override
  _CustomFieldsSettingsState createState() => _CustomFieldsSettingsState();
}

class _CustomFieldsSettingsState extends State<CustomFieldsSettings> {
  final _customField1Controller = TextEditingController();
  final _customField2Controller = TextEditingController();
  final _customField3Controller = TextEditingController();
  final _customField4Controller = TextEditingController();

  final _customValue1Controller = TextEditingController();
  final _customValue2Controller = TextEditingController();
  final _customValue3Controller = TextEditingController();
  final _customValue4Controller = TextEditingController();

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
      _customValue1Controller,
      _customValue2Controller,
      _customValue3Controller,
      _customValue4Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final fieldType = widget.fieldType;
    final customFields = widget.viewModel.company.customFields;
    _customField1Controller.text = customFields['${fieldType}1'];
    _customField2Controller.text = customFields['${fieldType}2'];
    _customField3Controller.text = customFields['${fieldType}3'];
    _customField4Controller.text = customFields['${fieldType}4'];

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final fieldType = widget.fieldType;
    final company = widget.viewModel.company;
    final origFields = company.customFields;

    final updatedFields = origFields.rebuild((b) => b
      ..addAll({'${fieldType}1': _customField1Controller.text.trim()})
      ..addAll({'${fieldType}2': _customField2Controller.text.trim()})
      ..addAll({'${fieldType}3': _customField3Controller.text.trim()})
      ..addAll({'${fieldType}4': _customField4Controller.text.trim()}));

    if (viewModel.company.customFields != updatedFields) {
      viewModel.onCompanyChanged(company.rebuild((b) => b
        ..customFields.replace(updatedFields)
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    return FormCard(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: CustomFormField(
                label: localization.lookup('${widget.fieldType}_field'),
                controller: _customField1Controller,
                showTaxes: widget.showChargeTaxes,
                taxesEnabled: company.enableCustomSurchargeTaxes1,
                onTaxesChanged: (value) => viewModel.onCompanyChanged(company
                    .rebuild((b) => b..enableCustomSurchargeTaxes1 = value)),
              ),
            ),
            if (widget.showValues) ...[
              SizedBox(width: kGutterWidth),
              Expanded(
                child: CustomFormField(
                  label: widget.valueLabel,
                  controller: _customValue1Controller,
                ),
              ),
            ]
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CustomFormField(
                label: localization.lookup('${widget.fieldType}_field'),
                controller: _customField2Controller,
                showTaxes: widget.showChargeTaxes,
                taxesEnabled: company.enableCustomSurchargeTaxes2,
                onTaxesChanged: (value) => viewModel.onCompanyChanged(company
                    .rebuild((b) => b..enableCustomSurchargeTaxes2 = value)),
              ),
            ),
            if (widget.showValues) ...[
              SizedBox(width: kGutterWidth),
              Expanded(
                child: CustomFormField(
                  label: widget.valueLabel,
                  controller: _customValue2Controller,
                ),
              ),
            ]
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CustomFormField(
                label: localization.lookup('${widget.fieldType}_field'),
                controller: _customField3Controller,
                showTaxes: widget.showChargeTaxes,
                taxesEnabled: company.enableCustomSurchargeTaxes3,
                onTaxesChanged: (value) => viewModel.onCompanyChanged(company
                    .rebuild((b) => b..enableCustomSurchargeTaxes3 = value)),
              ),
            ),
            if (widget.showValues) ...[
              SizedBox(width: kGutterWidth),
              Expanded(
                child: CustomFormField(
                  label: widget.valueLabel,
                  controller: _customValue3Controller,
                ),
              ),
            ]
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CustomFormField(
                label: localization.lookup('${widget.fieldType}_field'),
                controller: _customField4Controller,
                showTaxes: widget.showChargeTaxes,
                taxesEnabled: company.enableCustomSurchargeTaxes4,
                onTaxesChanged: (value) => viewModel.onCompanyChanged(company
                    .rebuild((b) => b..enableCustomSurchargeTaxes4 = value)),
              ),
            ),
            if (widget.showValues) ...[
              SizedBox(width: kGutterWidth),
              Expanded(
                child: CustomFormField(
                  label: widget.valueLabel,
                  controller: _customValue4Controller,
                ),
              ),
            ]
          ],
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
