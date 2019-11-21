import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/generated_numbers_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_generatedNumbers');

  FocusScopeNode _focusNode;
  TabController _controller;

  bool autoValidate = false;

  final _recurringPrefixController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

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
    _debouncer.run(() {
      final settings = widget.viewModel.settings.rebuild((b) => b
        ..recurringInvoiceNumberPrefix =
            _recurringPrefixController.text.trim());

      if (settings != widget.viewModel.settings) {
        widget.viewModel.onSettingsChanged(settings);
      }
    });
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
        isScrollable: isMobile(context),
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
                        // TODO remove this check
                        value: (settings.counterPadding ?? 0) > 0
                            ? settings.counterPadding
                            : 4,
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
                  AppDropdownButton(
                    labelText: localization.resetCounter,
                    value: settings.resetCounterFrequencyId,
                    onChanged: (dynamic value) => viewModel.onSettingsChanged(
                        settings.rebuild(
                            (b) => b..resetCounterFrequencyId = value)),
                    items: [
                      DropdownMenuItem<String>(
                        child: Text(localization.never),
                        value: '0',
                      ),
                      ...kFrequencies
                          .map((id, frequency) =>
                              MapEntry<String, DropdownMenuItem<String>>(
                                  id,
                                  DropdownMenuItem<String>(
                                    child: Text(localization.lookup(frequency)),
                                    value: id,
                                  )))
                          .values
                          .toList()
                    ],
                  ),
                  if ((int.tryParse(settings.resetCounterFrequencyId ?? '0') ??
                          0) >
                      0)
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
            EntityNumberSettings(
              counterValue: settings.clientNumberCounter,
              patternValue: settings.clientNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..clientNumberCounter = counter
                    ..clientNumberPattern = pattern)),
            ),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(
              counterValue: settings.invoiceNumberCounter,
              patternValue: settings.invoiceNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..invoiceNumberCounter = counter
                    ..invoiceNumberPattern = pattern)),
            ),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(
              counterValue: settings.quoteNumberCounter,
              patternValue: settings.quoteNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..quoteNumberCounter = counter
                    ..quoteNumberPattern = pattern)),
            ),
          ]),
          ListView(children: <Widget>[
            EntityNumberSettings(
              counterValue: settings.paymentNumberCounter,
              patternValue: settings.paymentNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..paymentNumberCounter = counter
                    ..paymentNumberPattern = pattern)),
            ),
          ]),
        ],
      ),
    );
  }
}

class EntityNumberSettings extends StatefulWidget {
  const EntityNumberSettings({
    @required this.counterValue,
    @required this.patternValue,
    @required this.onChanged,
  });

  final int counterValue;
  final String patternValue;
  final Function(int, String) onChanged;

  @override
  _EntityNumberSettingsState createState() => _EntityNumberSettingsState();
}

class _EntityNumberSettingsState extends State<EntityNumberSettings> {
  final _counterController = TextEditingController();
  final _patternController = TextEditingController();

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
      _counterController,
      _patternController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _counterController.text = '${widget.counterValue ?? ''}';
    _patternController.text = widget.patternValue;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      final int counter = parseDouble(_counterController.text.trim()).toInt();
      final String pattern = _patternController.text.trim();

      if (counter != widget.counterValue || pattern != widget.patternValue) {
        widget.onChanged(counter, pattern);
      }
    });
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
