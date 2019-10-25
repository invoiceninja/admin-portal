import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
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
    _controller = TabController(vsync: this, length: 3);
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

    //_recurringPrefixController.text = widget.viewModel.settings.
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
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    final state = viewModel.state;

    return SettingsScaffold(
      title: localization.systemSettings,
      onSavePressed: null,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        tabs: [
          Tab(
            text: localization.general,
          ),
          Tab(
            text: localization.clients,
          ),
          Tab(
            text: localization.products,
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
                      labelText: localization.padding,
                    ),
                    //isEmpty: false,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        //value:
                        isExpanded: true,
                        isDense: true,
                        /*
                          onChanged: (value) => viewModel.onSettingsChanged(
                              settings
                                  .rebuild((b) => b..portalMode = value)),
                           */
                        items: List<int>.generate(10, (i) => i + 1)
                            .map((value) => DropdownMenuItem(
                                  child: Text('${'0' * value}1'),
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
                ],
              ),
            ],
          ),
          ListView(children: <Widget>[
            EntityNumberSettings(),
            CustomFieldsSettings(),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(),
            CustomFieldsSettings(),
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
          label: localization.pattern,
          controller: _patternController,
        ),
        DecoratedFormField(
          label: localization.counter,
          controller: _counterController,
        ),
      ],
    );
  }
}

class CustomFieldsSettings extends StatefulWidget {
  const CustomFieldsSettings({this.fieldLabel});

  final String fieldLabel;

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
    final localization = AppLocalization.of(context);

    return FormCard(
      children: <Widget>[
        DecoratedFormField(
          label: widget.fieldLabel,
          controller: _customField1Controller,
        ),
        DecoratedFormField(
          label: widget.fieldLabel,
          controller: _customField2Controller,
        ),
        DecoratedFormField(
          label: widget.fieldLabel,
          controller: _customField2Controller,
        ),
        DecoratedFormField(
          label: widget.fieldLabel,
          controller: _customField2Controller,
        ),
      ],
    );
  }
}
