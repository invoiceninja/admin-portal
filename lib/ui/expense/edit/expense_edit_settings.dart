import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class ExpenseEditSettings extends StatefulWidget {
  const ExpenseEditSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseEditVM viewModel;

  @override
  ExpenseEditSettingsState createState() => ExpenseEditSettingsState();
}

class ExpenseEditSettingsState extends State<ExpenseEditSettings> {
  final _transactionReferenceController = TextEditingController();

  final List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
      _transactionReferenceController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense;
    _transactionReferenceController.text = expense.transactionReference;

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
    final expense = viewModel.expense.rebuild((b) =>
        b..transactionReference = _transactionReferenceController.text.trim());
    if (expense != viewModel.expense) {
      viewModel.onChanged(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.company;
    final expense = viewModel.expense;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            TaxRateDropdown(
              taxRates: company.taxRates,
              onSelected: (taxRate) =>
                  viewModel.onChanged(expense.rebuild((b) => b
                    ..taxRate1 = taxRate.rate
                    ..taxName1 = taxRate.name)),
              labelText: localization.tax,
              initialTaxName: expense.taxName1,
              initialTaxRate: expense.taxRate1,
            ),
            company.enableSecondTaxRate
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) =>
                        viewModel.onChanged(expense.rebuild((b) => b
                          ..taxRate2 = taxRate.rate
                          ..taxName2 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: expense.taxName2,
                    initialTaxRate: expense.taxRate2,
                  )
                : SizedBox(),
            SizedBox(height: 20),
            SwitchListTile(
              activeColor: Theme.of(context).accentColor,
              title: Text(localization.markBillable),
              value: expense.shouldBeInvoiced,
              onChanged: (value) => viewModel.onChanged(
                  expense.rebuild((b) => b..shouldBeInvoiced = value)),
            ),
            SwitchListTile(
              activeColor: Theme.of(context).accentColor,
              title: Text(localization.markPaid),
              value: expense.paymentDate.isNotEmpty,
              onChanged: (value) => viewModel.onChanged(expense.rebuild((b) =>
                  b..paymentDate = value ? convertDateTimeToSqlDate() : '')),
            ),
            expense.paymentDate.isNotEmpty
                ? DatePicker(
                    labelText: localization.date,
                    selectedDate: expense.paymentDate,
                    onSelected: (date) {
                      viewModel.onChanged(
                          expense.rebuild((b) => b..paymentDate = date));
                    },
                  )
                : SizedBox(),
            expense.paymentDate.isNotEmpty
                ? TextFormField(
                    controller: _transactionReferenceController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: localization.transactionReference,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ],
    );
  }
}
