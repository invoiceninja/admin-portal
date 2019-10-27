import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/generated_numbers_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class GeneratedNumbers extends StatefulWidget {
  const GeneratedNumbers({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final GeneratedNumbersVM viewModel;

  @override
  _GeneratedNumbersState createState() => _GeneratedNumbersState();
}

class _GeneratedNumbersState extends State<GeneratedNumbers>
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
      title: localization.generatedNumbers,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.settings,
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
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(),
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

