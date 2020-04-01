import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/custom_fields_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
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
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_customFields');

  FocusScopeNode _focusNode;
  TabController _controller;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    return EditScaffold(
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
            text: localization.products,
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
          ListView(
            children: <Widget>[
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.product,
              ),
            ],
          ),
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

class CustomFieldsSettings extends StatelessWidget {
  const CustomFieldsSettings({
    @required this.fieldType,
    @required this.viewModel,
    this.showChargeTaxes = false,
  });

  final CustomFieldsVM viewModel;
  final bool showChargeTaxes;
  final String fieldType;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final company = viewModel.company;

    return FormCard(
      children: <Widget>[
        CustomFormField(
          label: localization.lookup('${fieldType}_field'),
          value: company.customFields['${fieldType}1'],
          onChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..customFields['${fieldType}1'] = value)),
          showTaxes: showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes1,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes1 = value)),
        ),
        CustomFormField(
          label: localization.lookup('${fieldType}_field'),
          value: company.customFields['${fieldType}2'],
          onChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..customFields['${fieldType}2'] = value)),
          showTaxes: showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes2,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes2 = value)),
        ),
        CustomFormField(
          label: localization.lookup('${fieldType}_field'),
          value: company.customFields['${fieldType}3'],
          onChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..customFields['${fieldType}3'] = value)),
          showTaxes: showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes3,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes3 = value)),
        ),
        CustomFormField(
          label: localization.lookup('${fieldType}_field'),
          value: company.customFields['${fieldType}4'],
          onChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..customFields['${fieldType}4'] = value)),
          showTaxes: showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes4,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes4 = value)),
        ),
      ],
    );
  }
}

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    @required this.label,
    @required this.onChanged,
    @required this.value,
    this.showTaxes = false,
    this.taxesEnabled,
    this.onTaxesChanged,
  });

  final String label;
  final String value;
  final bool showTaxes;
  final bool taxesEnabled;
  final Function(String) onChanged;
  final Function(bool) onTaxesChanged;

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final _customFieldController = TextEditingController();
  final _optionsController = TextEditingController();
  String _fieldType = kFieldTypeSingleLineText;

  List<TextEditingController> _controllers = [];
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
      _customFieldController,
      _optionsController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    if ('${widget.value ?? ''}'.isNotEmpty) {
      if (widget.value.contains('|')) {
        final parts = widget.value.split('|');
        _customFieldController.text = parts[0];
        switch (parts[1]) {
          case kFieldTypeSingleLineText:
            _fieldType = kFieldTypeSingleLineText;
            break;
          case kFieldTypeDate:
            _fieldType = kFieldTypeDate;
            break;
          case kFieldTypeSwitch:
            _fieldType = kFieldTypeSwitch;
            break;
          default:
            _fieldType = kFieldTypeDropdown;
            _optionsController.text = parts[1];
            break;
        }
      } else {
        _fieldType = kFieldTypeMultiLineText;
        _customFieldController.text = widget.value;
      }
    } else {
      _customFieldController.text = widget.value;
    }

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      var value = _customFieldController.text.trim();
      if ([
        kFieldTypeSingleLineText,
        kFieldTypeDate,
        kFieldTypeSwitch,
      ].contains(_fieldType)) {
        value = '$value|$_fieldType';
      } else if (_fieldType == kFieldTypeDropdown) {
        value = '$value|${_optionsController.text.trim()}';
      }
      widget.onChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child: DecoratedFormField(
                label: widget.label,
                controller: _customFieldController,
              ),
            ),
            if (widget.showTaxes) ...[
              Checkbox(
                activeColor: Theme.of(context).accentColor,
                value: widget.taxesEnabled ?? false,
                onChanged: widget.onTaxesChanged,
              ),
              GestureDetector(
                child: Text(localization.chargeTaxes),
                onTap: () => widget.onTaxesChanged(!widget.taxesEnabled),
              ),
            ] else ...[
              SizedBox(width: 20),
              Flexible(
                child: AppDropdownButton(
                  labelText: localization.fieldType,
                  value: _fieldType,
                  onChanged: (dynamic value) {
                    setState(() {
                      _fieldType = value;
                      if (value != kFieldTypeDropdown) {
                        _optionsController.text = '';
                      }
                      _onChanged();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text(localization.singleLineText),
                      value: kFieldTypeSingleLineText,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.multiLineText),
                      value: kFieldTypeMultiLineText,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.switchLabel),
                      value: kFieldTypeSwitch,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.dropdown),
                      value: kFieldTypeDropdown,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.date),
                      value: kFieldTypeDate,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        if (_fieldType == kFieldTypeDropdown)
          Flexible(
            child: DecoratedFormField(
              label: localization.options,
              controller: _optionsController,
              hint: localization.commaSeparatedList,
            ),
          ),
        SizedBox(height: 15),
      ],
    );
  }
}
