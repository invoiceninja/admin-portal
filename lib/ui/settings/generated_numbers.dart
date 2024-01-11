// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/generated_numbers_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class GeneratedNumbers extends StatefulWidget {
  const GeneratedNumbers({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final GeneratedNumbersVM viewModel;

  @override
  _GeneratedNumbersState createState() => _GeneratedNumbersState();
}

class _GeneratedNumbersState extends State<GeneratedNumbers>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_generatedNumbers');

  FocusScopeNode? _focusNode;
  TabController? _controller;

  bool autoValidate = false;

  final _recurringPrefixController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();

    final company = widget.viewModel.state.company;
    int tabs = 2;

    [
      EntityType.invoice,
      EntityType.payment,
      EntityType.quote,
      EntityType.credit,
      EntityType.recurringInvoice,
      EntityType.project,
      EntityType.task,
      EntityType.vendor,
      EntityType.purchaseOrder,
      EntityType.expense,
      EntityType.recurringExpense,
    ].forEach((entityType) {
      if (company.isModuleEnabled(entityType)) {
        tabs++;
      }
    });

    _focusNode = FocusScopeNode();

    final settingsUIState = widget.viewModel.state.settingsUIState;
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
    _recurringPrefixController.text = settings.recurringNumberPrefix ?? '';

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      final settings = widget.viewModel.settings.rebuild((b) =>
          b..recurringNumberPrefix = _recurringPrefixController.text.trim());

      if (settings != widget.viewModel.settings) {
        widget.viewModel.onSettingsChanged(settings);
      }
    });
  }

  void _onSavePressed(BuildContext context) {
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;

    final values = [
      settings.clientNumberPattern,
      settings.invoiceNumberPattern,
      settings.paymentNumberPattern,
      settings.quoteNumberPattern,
      settings.creditNumberPattern,
      settings.recurringInvoiceNumberPattern,
      settings.projectNumberPattern,
      settings.taskNumberPattern,
      settings.vendorNumberPattern,
      settings.purchaseOrderNumberPattern,
      settings.expenseNumberPattern,
      settings.recurringExpenseNumberPattern,
    ];

    bool isValid = true;
    values.forEach((value) {
      value ??= '';
      final containsSubCounter = value.contains('{\$client_counter}');
      final containsCounterOrId = value.contains('{\$client_id_number}') ||
          value.contains('{\$client_number}') ||
          value.contains('{\$counter}');

      if (containsSubCounter && !containsCounterOrId) {
        isValid = false;
      }
    });

    if (!isValid) {
      showDialog<ErrorDialog>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(AppLocalization.of(context)!
                .counterPatternError
                .replaceAll(':', '\$'));
          });

      return;
    }

    viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    final state = viewModel.state;
    final company = state.company;

    return EditScaffold(
      title: localization.generatedNumbers,
      onSavePressed: _onSavePressed,
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
          if (company.isModuleEnabled(EntityType.invoice))
            Tab(
              text: localization.invoices,
            ),
          if (company.isModuleEnabled(EntityType.recurringInvoice))
            Tab(
              text: localization.recurringInvoices,
            ),
          if (company.isModuleEnabled(EntityType.payment))
            Tab(
              text: localization.payments,
            ),
          if (company.isModuleEnabled(EntityType.quote))
            Tab(
              text: localization.quotes,
            ),
          if (company.isModuleEnabled(EntityType.credit))
            Tab(
              text: localization.credits,
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
          if (company.isModuleEnabled(EntityType.purchaseOrder))
            Tab(
              text: localization.purchaseOrders,
            ),
          if (company.isModuleEnabled(EntityType.expense))
            Tab(
              text: localization.expenses,
            ),
          if (company.isModuleEnabled(EntityType.recurringExpense))
            Tab(
              text: localization.recurringExpenses,
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
              FormCard(
                isLast: true,
                children: <Widget>[
                  AppDropdownButton<int>(
                    labelText: localization.numberPadding,
                    value: settings.counterPadding,
                    blankValue: null,
                    onChanged: (dynamic value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..counterPadding = value)),
                    items: List<int>.generate(10, (i) => i + 1)
                        .map((value) => DropdownMenuItem(
                              child: Text('${'0' * (value - 1)}1'),
                              value: value,
                            ))
                        .toList(),
                  ),
                  AppDropdownButton<String>(
                    labelText: localization.generateNumber,
                    value: settings.counterNumberApplied,
                    onChanged: (dynamic value) => viewModel.onSettingsChanged(
                        settings
                            .rebuild((b) => b..counterNumberApplied = value)),
                    items: [
                      DropdownMenuItem(
                        child: Text(localization.whenSaved),
                        value: kGenerateNumberWhenSaved,
                      ),
                      DropdownMenuItem(
                        child: Text(localization.whenSent),
                        value: kGenerateNumberWhenSent,
                      ),
                    ],
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
                      onSelected: (value, _) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..resetCounterDate = value)),
                    ),
                  if (company.isModuleEnabled(EntityType.recurringInvoice))
                    DecoratedFormField(
                      label: localization.recurringPrefix,
                      controller: _recurringPrefixController,
                      keyboardType: TextInputType.text,
                    ),
                  SizedBox(height: 20),
                  if (company.isModuleEnabled(EntityType.quote))
                    BoolDropdownButton(
                      iconData: Icons.content_copy,
                      label: localization.sharedInvoiceQuoteCounter,
                      value: settings.sharedInvoiceQuoteCounter,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..sharedInvoiceQuoteCounter = value)),
                    ),
                  if (company.isModuleEnabled(EntityType.credit))
                    BoolDropdownButton(
                      iconData: Icons.content_copy,
                      label: localization.sharedInvoiceCreditCounter,
                      value: settings.sharedInvoiceCreditCounter,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild(
                              (b) => b..sharedInvoiceCreditCounter = value)),
                    ),
                ],
              ),
            ],
          ),
          EntityNumberSettings(
            showClientFields: false,
            counterValue: settings.clientNumberCounter,
            patternValue: settings.clientNumberPattern,
            onChanged: (counter, pattern) =>
                viewModel.onSettingsChanged(settings.rebuild((b) => b
                  ..clientNumberCounter = counter
                  ..clientNumberPattern = pattern)),
          ),
          if (company.isModuleEnabled(EntityType.invoice))
            EntityNumberSettings(
              counterValue: settings.invoiceNumberCounter,
              patternValue: settings.invoiceNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..invoiceNumberCounter = counter
                    ..invoiceNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.recurringInvoice))
            EntityNumberSettings(
              counterValue: settings.recurringInvoiceNumberCounter,
              patternValue: settings.recurringInvoiceNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..recurringInvoiceNumberCounter = counter
                    ..recurringInvoiceNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.payment))
            EntityNumberSettings(
              counterValue: settings.paymentNumberCounter,
              patternValue: settings.paymentNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..paymentNumberCounter = counter
                    ..paymentNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.quote))
            EntityNumberSettings(
              counterValue: settings.quoteNumberCounter,
              patternValue: settings.quoteNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..quoteNumberCounter = counter
                    ..quoteNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.credit))
            EntityNumberSettings(
              counterValue: settings.creditNumberCounter,
              patternValue: settings.creditNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..creditNumberCounter = counter
                    ..creditNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.project))
            EntityNumberSettings(
              counterValue: settings.projectNumberCounter,
              patternValue: settings.projectNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..projectNumberCounter = counter
                    ..projectNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.task))
            EntityNumberSettings(
              showClientFields: false,
              counterValue: settings.taskNumberCounter,
              patternValue: settings.taskNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..taskNumberCounter = counter
                    ..taskNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.vendor))
            EntityNumberSettings(
              showClientFields: false,
              counterValue: settings.vendorNumberCounter,
              patternValue: settings.vendorNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..vendorNumberCounter = counter
                    ..vendorNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.purchaseOrder))
            EntityNumberSettings(
              showClientFields: false,
              counterValue: settings.purchaseOrderNumberCounter,
              patternValue: settings.purchaseOrderNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..purchaseOrderNumberCounter = counter
                    ..purchaseOrderNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.expense))
            EntityNumberSettings(
              showClientFields: false,
              showVendorFields: false,
              counterValue: settings.expenseNumberCounter,
              patternValue: settings.expenseNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..expenseNumberCounter = counter
                    ..expenseNumberPattern = pattern)),
            ),
          if (company.isModuleEnabled(EntityType.recurringExpense))
            EntityNumberSettings(
              showClientFields: false,
              showVendorFields: false,
              counterValue: settings.recurringExpenseNumberCounter,
              patternValue: settings.recurringExpenseNumberPattern,
              onChanged: (counter, pattern) =>
                  viewModel.onSettingsChanged(settings.rebuild((b) => b
                    ..recurringExpenseNumberCounter = counter
                    ..recurringExpenseNumberPattern = pattern)),
            ),
        ],
      ),
    );
  }
}

class EntityNumberSettings extends StatefulWidget {
  const EntityNumberSettings({
    required this.counterValue,
    required this.patternValue,
    required this.onChanged,
    this.showVendorFields = false,
    this.showClientFields = true,
  });

  final int? counterValue;
  final String? patternValue;
  final Function(int?, String) onChanged;
  final bool showVendorFields;
  final bool showClientFields;

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
    _patternController.text = widget.patternValue ?? '';

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      final int? counter =
          parseInt(_counterController.text.trim(), zeroIsNull: true);
      final String pattern = _patternController.text.trim();

      if (counter != widget.counterValue || pattern != widget.patternValue) {
        widget.onChanged(counter, pattern);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return ScrollableListView(
      children: [
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              label: localization.numberPattern,
              controller: _patternController,
              keyboardType: TextInputType.text,
            ),
            DecoratedFormField(
              label: localization.numberCounter,
              controller: _counterController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 8),
          child: OutlinedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(localization.viewDateFormats.toUpperCase()),
            ),
            onPressed: () => launchUrl(Uri.parse(kPHPDateFormatsUrl)),
          ),
        ),
        HelpPanel(
          showClientFields: widget.showClientFields,
          showVendorFields: widget.showVendorFields,
          onFieldPressed: (field) {
            final selection = _patternController.selection;
            final offset = selection.extent.offset;

            String newValue = field;
            int newOffset = field.length;

            if (offset >= 0) {
              final currentValue = _patternController.text;
              newValue = currentValue.substring(0, offset) +
                  field +
                  currentValue.substring(offset);
              newOffset = offset + field.length;
            } else {
              newValue = _patternController.text + newValue;
            }

            _patternController.text = newValue;

            if (offset >= 0) {
              _patternController.selection =
                  TextSelection.fromPosition(TextPosition(offset: newOffset));
            }
          },
        ),
      ],
    );
  }
}

class HelpPanel extends StatelessWidget {
  const HelpPanel({
    required this.onFieldPressed,
    this.showVendorFields = false,
    this.showClientFields = true,
  });

  final bool showVendorFields;
  final bool showClientFields;
  final Function(String) onFieldPressed;

  @override
  Widget build(BuildContext context) {
    final fields = [
      'counter',
      'client_counter',
      'group_counter',
      'year',
      'date:format',
      'client_number',
      'client_id_number',
      'client_custom1',
      'client_custom2',
      'client_custom3',
      'client_custom4',
      'vendor_number',
      'vendor_id_number',
      'vendor_custom1',
      'vendor_custom2',
      'vendor_custom3',
      'vendor_custom4',
      'user_id',
      'user_custom1',
      'user_custom2',
      'user_custom3',
      'user_custom4',
    ];

    return FormCard(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        isLast: true,
        children: fields
            .where((field) => showVendorFields || !field.startsWith('vendor'))
            .where((field) =>
                showClientFields ||
                (!field.startsWith('client') && !field.startsWith('group')))
            .map((field) => '\{\$$field\}')
            .map((field) => InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(field),
                  ),
                  onTap: () => onFieldPressed(field),
                ))
            .toList());
  }
}
