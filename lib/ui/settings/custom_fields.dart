// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/custom_fields_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CustomFields extends StatefulWidget {
  const CustomFields({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final CustomFieldsVM viewModel;

  @override
  _CustomFieldsState createState() => _CustomFieldsState();
}

class _CustomFieldsState extends State<CustomFields>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_customFields');

  FocusScopeNode? _focusNode;
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    final state = widget.viewModel.state;
    int tabs = 4;

    [
      EntityType.invoice,
      EntityType.payment,
      EntityType.task,
      EntityType.vendor,
      EntityType.expense,
      EntityType.project,
    ].forEach((entityType) {
      if (state.company.isModuleEnabled(entityType)) {
        tabs++;
      }
    });

    final settingsUIState = state.settingsUIState;
    _controller = TabController(
        vsync: this, length: tabs, initialIndex: settingsUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = state.company;

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
          if (company.isModuleEnabled(EntityType.invoice))
            Tab(
              text: localization.invoices,
            ),
          if (company.isModuleEnabled(EntityType.payment))
            Tab(
              text: localization.payments,
            ),
          if (company.isModuleEnabled(EntityType.project))
            Tab(
              text: localization.projects,
            ),
          if (company.isModuleEnabled(EntityType.task))
            Tab(
              text: localization.tasks,
            ),
          if (company.isModuleEnabled(EntityType.vendor))
            Tab(
              text: localization.vendors,
            ),
          if (company.isModuleEnabled(EntityType.expense))
            Tab(
              text: localization.expenses,
            ),
          Tab(
            text: localization.users,
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
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.company,
              ),
            ],
          ),
          ScrollableListView(children: <Widget>[
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldType: CustomFieldType.client,
            ),
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldType: CustomFieldType.contact,
            ),
          ]),
          ScrollableListView(
            children: <Widget>[
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.product,
              ),
            ],
          ),
          if (company.isModuleEnabled(EntityType.invoice))
            ScrollableListView(children: <Widget>[
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
          if (company.isModuleEnabled(EntityType.payment))
            ScrollableListView(children: <Widget>[
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.payment,
              ),
            ]),
          if (company.isModuleEnabled(EntityType.project))
            ScrollableListView(children: <Widget>[
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.project,
              ),
            ]),
          if (company.isModuleEnabled(EntityType.task))
            ScrollableListView(children: <Widget>[
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.task,
              ),
            ]),
          if (company.isModuleEnabled(EntityType.vendor))
            ScrollableListView(children: <Widget>[
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.vendor,
              ),
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.vendorContact,
              ),
            ]),
          if (company.isModuleEnabled(EntityType.expense))
            ScrollableListView(children: <Widget>[
              CustomFieldsSettings(
                viewModel: viewModel,
                fieldType: CustomFieldType.expense,
              ),
            ]),
          ScrollableListView(children: <Widget>[
            CustomFieldsSettings(
              viewModel: viewModel,
              fieldType: CustomFieldType.user,
            ),
          ]),
        ],
      ),
    );
  }
}

class CustomFieldsSettings extends StatelessWidget {
  const CustomFieldsSettings({
    required this.fieldType,
    required this.viewModel,
    this.showChargeTaxes = false,
  });

  final CustomFieldsVM viewModel;
  final bool showChargeTaxes;
  final String fieldType;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final company = viewModel.company;
    var labelKey = '${fieldType}_field';
    if (labelKey == 'vendor_contact_field') {
      labelKey = 'contact_field';
    }

    return FormCard(
      children: [
        CustomFormField(
          label: localization.lookup(labelKey),
          value: company.customFields['${fieldType}1'],
          onChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..customFields['${fieldType}1'] = value)),
          showTaxes: showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes1,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes1 = value)),
        ),
        CustomFormField(
          label: localization.lookup(labelKey),
          value: company.customFields['${fieldType}2'],
          onChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..customFields['${fieldType}2'] = value)),
          showTaxes: showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes2,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes2 = value)),
        ),
        CustomFormField(
          label: localization.lookup(labelKey),
          value: company.customFields['${fieldType}3'],
          onChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..customFields['${fieldType}3'] = value)),
          showTaxes: showChargeTaxes,
          taxesEnabled: company.enableCustomSurchargeTaxes3,
          onTaxesChanged: (value) => viewModel.onCompanyChanged(
              company.rebuild((b) => b..enableCustomSurchargeTaxes3 = value)),
        ),
        CustomFormField(
          label: localization.lookup(labelKey),
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
    required this.label,
    required this.onChanged,
    required this.value,
    this.showTaxes = false,
    this.taxesEnabled,
    this.onTaxesChanged,
  });

  final String? label;
  final String? value;
  final bool showTaxes;
  final bool? taxesEnabled;
  final Function(String) onChanged;
  final Function(bool)? onTaxesChanged;

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final _customFieldController = TextEditingController();
  final _optionsController = TextEditingController();
  String _fieldType = kFieldTypeSingleLineText;

  List<TextEditingController> _controllers = [];
  //final _debouncer = Debouncer();

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
      if (widget.value!.contains('|')) {
        final parts = widget.value!.split('|');
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
        _customFieldController.text = widget.value ?? '';
      }
    } else {
      _customFieldController.text = widget.value ?? '';
    }

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    //_debouncer.run(() {
    var value = _customFieldController.text.trim();

    if (value.isEmpty) {
      if ((widget.value ?? '').isNotEmpty) {
        widget.onChanged('');
      }
      return;
    }

    if ([
      kFieldTypeSingleLineText,
      kFieldTypeDate,
      kFieldTypeSwitch,
    ].contains(_fieldType)) {
      value = '$value|$_fieldType';
    } else if (_fieldType == kFieldTypeDropdown) {
      value =
          '$value|${_optionsController.text.split(',').map((part) => part.trim()).join(',')}';
    }

    widget.onChanged(value);
    //});
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
                keyboardType: TextInputType.text,
              ),
            ),
            if (widget.showTaxes) ...[
              SizedBox(width: 16),
              InkWell(
                child: Row(
                  children: [
                    IgnorePointer(
                      child: Checkbox(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: widget.taxesEnabled ?? false,
                        onChanged: (value) => null,
                      ),
                    ),
                    Text(localization!.chargeTaxes),
                    SizedBox(width: 16),
                  ],
                ),
                onTap: () => widget.onTaxesChanged!(!widget.taxesEnabled!),
              )
            ] else ...[
              SizedBox(width: 16),
              Flexible(
                child: AppDropdownButton(
                  labelText: localization!.fieldType,
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
              keyboardType: TextInputType.text,
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }
}
