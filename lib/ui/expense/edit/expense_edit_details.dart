import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';

class ExpenseEditDetails extends StatefulWidget {
  const ExpenseEditDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseEditVM viewModel;

  @override
  ExpenseEditDetailsState createState() => ExpenseEditDetailsState();
}

class ExpenseEditDetailsState extends State<ExpenseEditDetails> {
  final _amountController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense;
    _amountController.text = formatNumber(expense.amount, context,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = expense.customValue1;
    _custom2Controller.text = expense.customValue2;

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
    _debouncer.run(() {
      final viewModel = widget.viewModel;
      final expense = viewModel.expense.rebuild((b) => b
        ..amount = parseDouble(_amountController.text)
        ..customValue1 = _custom1Controller.text.trim()
        ..customValue2 = _custom2Controller.text.trim());
      if (expense != viewModel.expense) {
        viewModel.onChanged(expense);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final expense = viewModel.expense;
    final company = viewModel.company;
    final staticState = viewModel.state.staticState;
    final vendorState = viewModel.state.vendorState;
    final clientState = viewModel.state.clientState;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            EntityDropdown(
              key: ValueKey('__vendor_${expense.vendorId}__'),
              allowClearing: true,
              entityType: EntityType.vendor,
              labelText: localization.vendor,
              entityId: expense.vendorId,
              entityList:
                  memoizedDropdownVendorList(vendorState.map, vendorState.list),
              onSelected: (vendor) {
                viewModel.onChanged(
                    expense.rebuild((b) => b..vendorId = vendor?.id));
              },
              onAddPressed: (completer) {
                viewModel.onAddVendorPressed(context, completer);
              },
            ),
            expense.isInvoiced
                ? SizedBox()
                : EntityDropdown(
                    key: ValueKey('__client_${expense.clientId}__'),
                    allowClearing: true,
                    entityType: EntityType.client,
                    labelText: localization.client,
                    entityId: expense.clientId,
                    entityList: memoizedDropdownClientList(
                        clientState.map, clientState.list),
                    onSelected: (client) {
                      final currencyId =
                          (client as ClientEntity)?.settings?.currencyId ??
                              company.currencyId;
                      viewModel.onChanged(expense.rebuild((b) => b
                        ..clientId = client?.id
                        ..invoiceCurrencyId = currencyId));
                    },
                    onAddPressed: (completer) {
                      viewModel.onAddClientPressed(context, completer);
                    },
                  ),
            EntityDropdown(
              key: ValueKey('__category_${expense.categoryId}__'),
              entityType: EntityType.expenseCategory,
              labelText: localization.category,
              entityId: expense.categoryId,
              entityList: memoizedDropdownExpenseCategoriesList(
                  company.expenseCategoryMap, company.expenseCategories),
              onSelected: (category) {
                viewModel.onChanged(
                    expense.rebuild((b) => b..categoryId = category.id));
              },
            ),
            DecoratedFormField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              label: localization.amount,
            ),
            EntityDropdown(
              key:
                  ValueKey('__expense_currency_${expense.expenseCurrencyId}__'),
              entityType: EntityType.currency,
              entityList: memoizedCurrencyList(staticState.currencyMap),
              labelText: localization.currency,
              entityId: expense.expenseCurrencyId,
              onSelected: (SelectableEntity currency) => viewModel.onChanged(
                  viewModel.expense
                      .rebuild((b) => b..expenseCurrencyId = currency.id)),
            ),
            DatePicker(
              labelText: localization.date,
              selectedDate: expense.expenseDate,
              onSelected: (date) {
                viewModel
                    .onChanged(expense.rebuild((b) => b..expenseDate = date));
              },
            ),
            CustomField(
              controller: _custom1Controller,
              field: CustomFieldType.expense1,
              value: expense.customValue1,
            ),
            CustomField(
              controller: _custom2Controller,
              field: CustomFieldType.expense2,
              value: expense.customValue2,
            ),
          ],
        ),
      ],
    );
  }
}
