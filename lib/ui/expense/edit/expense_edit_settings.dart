import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/utils/money.dart';

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
  bool showPaymentFields = false;
  bool showConvertCurrencyFields = false;

  final _transactionReferenceController = TextEditingController();
  final _exchangeRateController = TextEditingController();

  final List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
      _transactionReferenceController,
      _exchangeRateController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense;
    _transactionReferenceController.text = expense.transactionReference;
    _exchangeRateController.text = formatNumber(expense.exchangeRate, context,
        formatNumberType: FormatNumberType.input);

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    showPaymentFields = expense.paymentDate.isNotEmpty;
    showConvertCurrencyFields =
        expense.expenseCurrencyId != expense.invoiceCurrencyId;

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
      ..transactionReference = _transactionReferenceController.text.trim()
      ..exchangeRate = parseDouble(_exchangeRateController.text));
    if (expense != viewModel.expense) {
      viewModel.onChanged(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final staticState = viewModel.state.staticState;
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
            SizedBox(height: 16),
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
              value: showPaymentFields,
              onChanged: (value) {
                if (value && expense.paymentDate.isEmpty) {
                  viewModel.onChanged(expense.rebuild(
                      (b) => b..paymentDate = convertDateTimeToSqlDate()));
                }
                setState(() => showPaymentFields = value);
              },
            ),
            showPaymentFields
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 8),
                      EntityDropdown(
                        entityType: EntityType.paymentType,
                        entityMap: staticState.paymentTypeMap,
                        entityList:
                            memoizedPaymentTypeList(staticState.paymentTypeMap),
                        labelText: localization.paymentType,
                        initialValue: staticState
                            .paymentTypeMap[expense.paymentTypeId]?.name,
                        onSelected: (paymentType) => viewModel.onChanged(expense
                            .rebuild((b) => b..paymentTypeId = paymentType.id)),
                      ),
                      DatePicker(
                        labelText: localization.date,
                        selectedDate: expense.paymentDate,
                        onSelected: (date) {
                          viewModel.onChanged(
                              expense.rebuild((b) => b..paymentDate = date));
                        },
                      ),
                      TextFormField(
                        controller: _transactionReferenceController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: localization.transactionReference,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : SizedBox(),
            SwitchListTile(
              activeColor: Theme.of(context).accentColor,
              title: Text(localization.convertCurrency),
              value: showConvertCurrencyFields,
              onChanged: (value) =>
                  setState(() => showConvertCurrencyFields = value),
            ),
            showConvertCurrencyFields
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 8),
                      EntityDropdown(
                        entityType: EntityType.currency,
                        entityMap: staticState.currencyMap,
                        entityList:
                            memoizedCurrencyList(staticState.currencyMap),
                        labelText: localization.currency,
                        initialValue: staticState
                            .currencyMap[viewModel.expense.invoiceCurrencyId]
                            ?.name,
                        onSelected: (SelectableEntity currency) {
                          final exchangeRate = getExchangeRate(context,
                              fromCurrencyId: expense.expenseCurrencyId,
                              toCurrencyId: currency.id);
                          viewModel.onChanged(expense.rebuild((b) => b
                            ..invoiceCurrencyId = currency.id
                            ..exchangeRate = exchangeRate));
                          // addPostFrameCallback is needed to prevent the
                          // new invoiceCurrencyId value from being cleared
                          WidgetsBinding.instance
                              .addPostFrameCallback((duration) {
                            _exchangeRateController.text = formatNumber(
                                exchangeRate, context,
                                formatNumberType: FormatNumberType.input);
                          });
                        },
                      ),
                      TextFormField(
                        key: ValueKey('__${expense.invoiceCurrencyId}__'),
                        controller: _exchangeRateController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: localization.exchangeRate,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ],
    );
  }
}
