// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/project_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseEditDetails extends StatefulWidget {
  const ExpenseEditDetails({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AbstractExpenseEditVM viewModel;

  @override
  ExpenseEditDetailsState createState() => ExpenseEditDetailsState();
}

class ExpenseEditDetailsState extends State<ExpenseEditDetails> {
  final _numberController = TextEditingController();
  final _amountController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  late List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _numberController,
      _amountController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense!;
    _numberController.text = expense.number;
    _amountController.text = formatNumber(expense.amount, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _custom1Controller.text = expense.customValue1;
    _custom2Controller.text = expense.customValue2;
    _custom3Controller.text = expense.customValue3;
    _custom4Controller.text = expense.customValue4;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final expense = viewModel.expense!.rebuild((b) => b
      ..number = _numberController.text.trim()
      ..amount = parseDouble(_amountController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());
    if (expense != viewModel.expense) {
      _debouncer.run(() {
        viewModel.onChanged!(expense);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final viewModel = widget.viewModel;
    final expense = viewModel.expense!;
    final company = state.company;
    final staticState = viewModel.state!.staticState;
    final vendorState = viewModel.state!.vendorState;
    final clientState = viewModel.state!.clientState;
    final isFullscreen = state.prefState.isEditorFullScreen(EntityType.expense);

    final amountField = DecoratedFormField(
      controller: _amountController,
      keyboardType:
          TextInputType.numberWithOptions(decimal: true, signed: true),
      label: localization.amount,
      onSavePressed: viewModel.onSavePressed,
      isMoney: true,
    );

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          padding: isFullscreen
              ? const EdgeInsets.only(
                  left: kMobileDialogPadding,
                  top: kMobileDialogPadding,
                  right: kMobileDialogPadding / 2,
                )
              : null,
          children: <Widget>[
            if (expense.isOld)
              DecoratedFormField(
                controller: _numberController,
                label: localization.expenseNumber,
                autocorrect: false,
                keyboardType: TextInputType.text,
              ),
            EntityDropdown(
              autofocus: true,
              entityType: EntityType.vendor,
              labelText: localization.vendor,
              entityId: expense.vendorId,
              entityList: memoizedDropdownVendorList(vendorState.map,
                  vendorState.list, state.userState.map, state.staticState),
              onSelected: (vendor) {
                viewModel.onChanged!(
                    expense.rebuild((b) => b..vendorId = vendor?.id ?? ''));
              },
              onAddPressed: (completer) {
                viewModel.onAddVendorPressed!(context, completer);
              },
              onCreateNew: (completer, name) {
                store.dispatch(SaveVendorRequest(
                    vendor: VendorEntity().rebuild((b) => b..name = name),
                    completer: completer));
              },
            ),
            if (!expense.isInvoiced) ...[
              EntityDropdown(
                entityType: EntityType.client,
                labelText: localization.client,
                entityId: expense.clientId,
                entityList: memoizedDropdownClientList(clientState.map,
                    clientState.list, state.userState.map, state.staticState),
                onSelected: (client) {
                  String currencyId = '';
                  if (client != null) {
                    currencyId = (client as ClientEntity).settings.currencyId ??
                        company.currencyId;
                  }
                  viewModel.onChanged!(expense.rebuild((b) => b
                    ..clientId = client?.id ?? ''
                    ..invoiceCurrencyId = currencyId));
                },
                onAddPressed: (completer) {
                  viewModel.onAddClientPressed!(context, completer);
                },
              ),
              ProjectPicker(
                key: Key('__project_${expense.clientId}__'),
                projectId: expense.projectId,
                clientId: expense.clientId,
                onChanged: (selectedId) {
                  final project = store.state.projectState.get(selectedId);
                  viewModel.onChanged!(expense.rebuild((b) => b
                    ..projectId = project.id
                    ..clientId = project.clientId.isNotEmpty
                        ? project.clientId
                        : expense.clientId));
                },
                /*
                onAddPressed: (completer) {
                  viewModel.onAddProjectPressed(context, completer);
                },
                 */
              ),
            ],
            EntityDropdown(
              allowClearing: true,
              entityType: EntityType.expenseCategory,
              labelText: localization.category,
              entityId: expense.categoryId,
              entityList: memoizedDropdownExpenseCategoriesList(
                  state.expenseCategoryState.map,
                  state.expenseCategoryState.list),
              onSelected: (category) {
                viewModel.onChanged!(
                    expense.rebuild((b) => b..categoryId = category?.id ?? ''));
              },
              onCreateNew: (completer, name) {
                store.dispatch(SaveExpenseCategoryRequest(
                    expenseCategory:
                        ExpenseCategoryEntity().rebuild((b) => b..name = name),
                    completer: completer));
              },
            ),
            UserPicker(
              userId: expense.assignedUserId,
              onChanged: (userId) => viewModel.onChanged!(
                  expense.rebuild((b) => b..assignedUserId = userId)),
            ),
            if (!expense.usesInclusiveTaxes) amountField,
            if (company.enableFirstExpenseTaxRate ||
                expense.taxName1.isNotEmpty)
              if (expense.calculateTaxByAmount == true)
                TaxRateField(
                  initialTaxAmount: expense.taxAmount1,
                  initialTaxName: expense.taxName1,
                  onNameChanged: (name) => viewModel
                      .onChanged!(expense.rebuild((b) => b..taxName1 = name)),
                  onAmountChanged: (amount) => viewModel.onChanged!(
                      expense.rebuild((b) => b..taxAmount1 = amount)),
                )
              else
                TaxRateDropdown(
                  onSelected: (taxRate) =>
                      viewModel.onChanged!(expense.rebuild((b) => b
                        ..taxRate1 = taxRate.rate
                        ..taxName1 = taxRate.name)),
                  labelText: localization.tax,
                  initialTaxName: expense.taxName1,
                  initialTaxRate: expense.taxRate1,
                ),
            if (company.enableSecondExpenseTaxRate ||
                expense.taxName2.isNotEmpty)
              if (expense.calculateTaxByAmount == true)
                TaxRateField(
                  initialTaxAmount: expense.taxAmount2,
                  initialTaxName: expense.taxName2,
                  onNameChanged: (name) => viewModel
                      .onChanged!(expense.rebuild((b) => b..taxName2 = name)),
                  onAmountChanged: (amount) => viewModel.onChanged!(
                      expense.rebuild((b) => b..taxAmount2 = amount)),
                )
              else
                TaxRateDropdown(
                  onSelected: (taxRate) =>
                      viewModel.onChanged!(expense.rebuild((b) => b
                        ..taxRate2 = taxRate.rate
                        ..taxName2 = taxRate.name)),
                  labelText: localization.tax,
                  initialTaxName: expense.taxName2,
                  initialTaxRate: expense.taxRate2,
                ),
            if (company.enableThirdExpenseTaxRate ||
                expense.taxName3.isNotEmpty)
              if (expense.calculateTaxByAmount == true)
                TaxRateField(
                  initialTaxAmount: expense.taxAmount3,
                  initialTaxName: expense.taxName3,
                  onNameChanged: (name) => viewModel
                      .onChanged!(expense.rebuild((b) => b..taxName3 = name)),
                  onAmountChanged: (amount) => viewModel.onChanged!(
                      expense.rebuild((b) => b..taxAmount3 = amount)),
                )
              else
                TaxRateDropdown(
                  onSelected: (taxRate) =>
                      viewModel.onChanged!(expense.rebuild((b) => b
                        ..taxRate3 = taxRate.rate
                        ..taxName3 = taxRate.name)),
                  labelText: localization.tax,
                  initialTaxName: expense.taxName3,
                  initialTaxRate: expense.taxRate3,
                ),
            if (expense.usesInclusiveTaxes) amountField,
            EntityDropdown(
              entityType: EntityType.currency,
              entityList: memoizedCurrencyList(staticState.currencyMap),
              labelText: localization.currency,
              entityId: expense.currencyId,
              onSelected: (SelectableEntity? currency) => viewModel.onChanged!(
                  viewModel.expense!
                      .rebuild((b) => b..currencyId = currency?.id ?? '')),
            ),
            DatePicker(
              labelText: localization.date,
              selectedDate: expense.date,
              onSelected: (date, _) {
                viewModel.onChanged!(expense.rebuild((b) => b..date = date));
              },
            ),
            CustomField(
              controller: _custom1Controller,
              field: CustomFieldType.expense1,
              value: expense.customValue1,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom2Controller,
              field: CustomFieldType.expense2,
              value: expense.customValue2,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom3Controller,
              field: CustomFieldType.expense3,
              value: expense.customValue3,
              onSavePressed: viewModel.onSavePressed,
            ),
            CustomField(
              controller: _custom4Controller,
              field: CustomFieldType.expense4,
              value: expense.customValue4,
              onSavePressed: viewModel.onSavePressed,
            ),
          ],
        ),
        if (expense.isRecurring)
          FormCard(
            padding: isFullscreen
                ? const EdgeInsets.only(
                    left: kMobileDialogPadding,
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding / 2,
                  )
                : null,
            children: [
              AppDropdownButton<String>(
                  labelText: localization.frequency,
                  value: expense.frequencyId,
                  onChanged: (dynamic value) {
                    viewModel.onChanged!(
                        expense.rebuild((b) => b..frequencyId = value));
                  },
                  items: kFrequencies.entries
                      .map((entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(localization.lookup(entry.value)),
                          ))
                      .toList()),
              DatePicker(
                labelText: expense.lastSentDate.isNotEmpty
                    ? localization.nextSendDate
                    : localization.startDate,
                onSelected: (date, _) {
                  viewModel.onChanged!(
                      expense.rebuild((b) => b..nextSendDate = date));
                },
                selectedDate: expense.nextSendDate,
                firstDate: DateTime.now(),
              ),
              AppDropdownButton<int>(
                labelText: localization.remainingCycles,
                value: expense.remainingCycles,
                blankValue: null,
                onChanged: (dynamic value) => viewModel.onChanged!(
                    expense.rebuild((b) => b..remainingCycles = value)),
                items: [
                  DropdownMenuItem(
                    child: Text(localization.endless),
                    value: -1,
                  ),
                  ...List<int>.generate(37, (i) => i)
                      .map((value) => DropdownMenuItem(
                            child: Text('$value'),
                            value: value,
                          ))
                      .toList()
                ],
              ),
            ],
          )
      ],
    );
  }
}
