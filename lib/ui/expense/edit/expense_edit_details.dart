import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
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

  final List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
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
    final viewModel = widget.viewModel;
    final expense = viewModel.expense.rebuild((b) => b
      ..amount = parseDouble(_amountController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim());
    if (expense != viewModel.expense) {
      viewModel.onChanged(expense);
    }
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
              entityType: EntityType.vendor,
              labelText: localization.vendor,
              initialValue:
                  (vendorState.map[expense.vendorId] ?? VendorEntity()).name,
              entityMap: vendorState.map,
              entityList:
                  memoizedDropdownVendorList(vendorState.map, vendorState.list),
              onSelected: (vendor) {
                viewModel
                    .onChanged(expense.rebuild((b) => b..vendorId = vendor.id));
              },
              onAddPressed: (completer) {
                viewModel.onAddVendorPressed(context, completer);
              },
            ),
            expense.isInvoiced
                ? SizedBox()
                : EntityDropdown(
                    entityType: EntityType.client,
                    labelText: localization.client,
                    initialValue:
                        (clientState.map[expense.clientId] ?? ClientEntity())
                            .displayName,
                    entityMap: clientState.map,
                    entityList: memoizedDropdownClientList(
                        clientState.map, clientState.list),
                    onSelected: (client) {
                      var currencyId = (client as ClientEntity).currencyId;
                      if (currencyId == 0) {
                        currencyId = company.currencyId;
                      }
                      viewModel.onChanged(expense.rebuild((b) => b
                        ..clientId = client.id
                        ..invoiceCurrencyId = currencyId));
                    },
                    onAddPressed: (completer) {
                      viewModel.onAddClientPressed(context, completer);
                    },
                  ),
            EntityDropdown(
              entityType: EntityType.expenseCategory,
              labelText: localization.category,
              initialValue: (company.expenseCategoryMap[expense.categoryId] ??
                      ExpenseCategoryEntity())
                  .name,
              entityMap: company.expenseCategoryMap,
              entityList: memoizedDropdownExpenseCategoriesList(
                  company.expenseCategoryMap, company.expenseCategories),
              onSelected: (category) {
                viewModel.onChanged(
                    expense.rebuild((b) => b..categoryId = category.id));
              },
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: localization.amount,
              ),
            ),
            EntityDropdown(
              entityType: EntityType.currency,
              entityMap: staticState.currencyMap,
              entityList: memoizedCurrencyList(staticState.currencyMap),
              labelText: localization.currency,
              initialValue: staticState
                  .currencyMap[viewModel.expense.expenseCurrencyId]?.name,
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
              labelText: company.getCustomFieldLabel(CustomFieldType.expense1),
              options: company.getCustomFieldValues(CustomFieldType.expense1),
            ),
            CustomField(
              controller: _custom2Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.expense2),
              options: company.getCustomFieldValues(CustomFieldType.expense2),
            ),
          ],
        ),
      ],
    );
  }
}
